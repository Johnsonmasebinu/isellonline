<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;

class WhatsAppController extends Controller
{
    public function webhook(Request $request)
    {
        Log::info('WhatsApp Webhook Incoming Request', [
            'method' => $request->method(),
            'ip' => $request->ip(),
            'headers' => $request->headers->all(),
            'raw_content' => $request->getContent()
        ]);

        try {
            $this->logActivity([
                'type' => 'webhook_request',
                'method' => $request->method(),
                'headers' => $request->headers->all(),
                'data' => $request->all(),
                'timestamp' => now()
            ]);
        } catch (\Exception $e) {
            Log::error('Failed to log activity: ' . $e->getMessage());
        }

        if ($request->isMethod('get')) {
            // Verification
            if ($request->hub_mode == 'subscribe' && $request->hub_verify_token == config('whatsapp.verify_token')) {
                try {
                    $this->logActivity(['type' => 'verification', 'status' => 'success', 'challenge' => $request->hub_challenge, 'timestamp' => now()]);
                } catch (\Exception $e) {}
                
                return response($request->hub_challenge, 200)->header('Content-Type', 'text/plain');
            }
            
            try {
                $this->logActivity(['type' => 'verification', 'status' => 'failed', 'params' => $request->all(), 'timestamp' => now()]);
            } catch (\Exception $e) {}

            return response('Forbidden', 403);
        }

        if ($request->isMethod('post')) {
            // Handle incoming messages
            $data = $request->all();

            try {
                $this->logActivity(['type' => 'message_received', 'data' => $data, 'timestamp' => now()]);
            } catch (\Exception $e) {}

            if (isset($data['entry'][0]['changes'][0]['value']['messages'])) {
                $phoneNumberId = $data['entry'][0]['changes'][0]['value']['metadata']['phone_number_id'];
                $contact = $data['entry'][0]['changes'][0]['value']['messages'][0]['from']; // 'from' might be nested differently, usually messages[0]['from']
                $messageBody = $data['entry'][0]['changes'][0]['value']['messages'][0]['text']['body'] ?? '';

                 // Log message extraction
                Log::info('WhatsApp Message Extracted', ['phone_number_id' => $phoneNumberId, 'from' => $contact, 'body' => $messageBody]);

                // Send reply
                $response = Http::withHeaders([
                    'Authorization' => 'Bearer ' . config('whatsapp.access_token'),
                    'Content-Type' => 'application/json',
                ])->post("https://graph.facebook.com/v18.0/{$phoneNumberId}/messages", [
                    'messaging_product' => 'whatsapp',
                    'to' => $contact,
                    'type' => 'text',
                    'text' => ['body' => 'Hi, Welcome To IsellOnline, Nigerian First E-commerce store creator']
                ]);

                try {
                    $this->logActivity(['type' => 'send_response', 'response' => $response->json(), 'status' => $response->status(), 'timestamp' => now()]);
                } catch (\Exception $e) {}

                if ($response->successful()) {
                    try {
                        $this->logActivity(['type' => 'reply_sent', 'to' => $contact, 'message' => 'Hi, Welcome To IsellOnline, Nigerian First E-commerce store creator', 'timestamp' => now()]);
                    } catch (\Exception $e) {}
                } else {
                    Log::error('WhatsApp Reply Failed', ['response' => $response->body()]);
                    try {
                        $this->logActivity(['type' => 'reply_failed', 'to' => $contact, 'error' => $response->json(), 'timestamp' => now()]);
                    } catch (\Exception $e) {}
                }
            } else {
                Log::info('No messages found in webhook payload', ['data' => $data]);
            }

            return response()->json(['status' => 'OK']);
        }
        
        return response()->json(['status' => 'Method Not Allowed'], 405);
    }

    public function logs()
    {
        $path = Storage::path('logs/whatsapp.json');
        if (!file_exists($path)) {
            return response()->json([]);
        }
        $content = file_get_contents($path);
        $lines = explode("\n", trim($content));
        $logs = [];
        foreach ($lines as $line) {
            if ($line) {
                $logs[] = json_decode($line, true);
            }
        }
        return response()->json($logs);
    }

    public function clearLogs()
    {
        $path = Storage::path('logs/whatsapp.json');
        if (file_exists($path)) {
            unlink($path);
        }
        return response()->json(['message' => 'Logs cleared']);
    }

    private function logActivity($data)
    {
        $path = Storage::path('logs/whatsapp.json');
        $dir = dirname($path);
        if (!is_dir($dir)) {
            mkdir($dir, 0755, true);
        }
        file_put_contents($path, json_encode($data) . "\n", FILE_APPEND | LOCK_EX);
    }

    public function downloadLaravelLog()
    {
        // Force a log entry to test logging system
        Log::info('Debug: Diagnostic log check initiated at ' . now());

        $candidates = [
            storage_path('logs/laravel.log'),
            storage_path('app/private/logs/whatsapp.json'),
            Storage::path('logs/whatsapp.json'), // Resolves based on default disk
        ];

        // Check for daily logs in standard location
        $dailyLogs = glob(storage_path('logs/laravel-*.log'));
        if (!empty($dailyLogs)) {
            // Sort newest first
            usort($dailyLogs, function ($a, $b) {
                return filemtime($b) - filemtime($a);
            });
            $candidates = array_merge($candidates, $dailyLogs);
        }

        // Try to download the first existing file found
        foreach ($candidates as $path) {
            if (file_exists($path)) {
                return response()->download($path);
            }
        }

        // Diagnostic: Recursive scan of storage folder
        $foundFiles = [];
        try {
            $flags = \FilesystemIterator::SKIP_DOTS;
            $iterator = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator(storage_path(), $flags), \RecursiveIteratorIterator::SELF_FIRST);
            
            foreach ($iterator as $file) {
                if ($file->isFile() && in_array($file->getExtension(), ['log', 'json', 'txt'])) {
                    $foundFiles[] = $file->getPathname();
                }
            }
        } catch (\Exception $e) {
            $foundFiles[] = 'Error scanning: ' . $e->getMessage();
        }

        return response()->json([
            'error' => 'No relevant log files found',
            'candidates_checked' => array_unique($candidates),
            'storage_permissions' => substr(sprintf('%o', fileperms(storage_path())), -4),
            'all_storage_files' => $foundFiles
        ], 404);
    }
}