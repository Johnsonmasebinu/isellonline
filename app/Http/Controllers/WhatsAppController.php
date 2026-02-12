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
        $path = storage_path('logs/laravel.log');
        if (file_exists($path)) {
            return response()->download($path);
        }

        $logPath = storage_path('logs');
        $files = glob($logPath . '/laravel-*.log');
        
        if (!empty($files)) {
            // Sort by modified time, newest first
            usort($files, function ($a, $b) {
                return filemtime($b) - filemtime($a);
            });
            return response()->download($files[0]);
        }

        // Diagnostic info
        $allFiles = glob($logPath . '/*');
        return response()->json([
            'error' => 'Log file not found',
            'scanned_path' => $logPath,
            'available_files' => array_map('basename', $allFiles ?: [])
        ], 404);
    }
}