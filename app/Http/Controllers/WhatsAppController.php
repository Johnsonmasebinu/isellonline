<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;

class WhatsAppController extends Controller
{
    public function webhook(Request $request)
    {
        if ($request->isMethod('get')) {
            // Verification
            if ($request->hub_mode == 'subscribe' && $request->hub_verify_token == config('whatsapp.verify_token')) {
                $this->logActivity(['type' => 'verification', 'status' => 'success', 'challenge' => $request->hub_challenge, 'timestamp' => now()]);
                return response($request->hub_challenge, 200)->header('Content-Type', 'text/plain');
            }
            $this->logActivity(['type' => 'verification', 'status' => 'failed', 'params' => $request->all(), 'timestamp' => now()]);
            return response('Forbidden', 403);
        }

        if ($request->isMethod('post')) {
            // Handle incoming messages
            $data = $request->all();

            $this->logActivity(['type' => 'message_received', 'data' => $data, 'timestamp' => now()]);

            if (isset($data['entry'][0]['changes'][0]['value']['messages'])) {
                $phoneNumberId = $data['entry'][0]['changes'][0]['value']['metadata']['phone_number_id'];
                $from = $data['entry'][0]['changes'][0]['value']['messages'][0]['from'];

                // Send reply
                $sendResponse = Http::withHeaders([
                    'Authorization' => 'Bearer ' . config('whatsapp.access_token'),
                    'Content-Type' => 'application/json',
                ])->post("https://graph.facebook.com/v18.0/{$phoneNumberId}/messages", [
                    'messaging_product' => 'whatsapp',
                    'to' => $from,
                    'type' => 'text',
                    'text' => ['body' => 'Hi, Welcome To IsellOnline, Nigerian First E-commerce store creator']
                ]);

                $this->logActivity(['type' => 'send_response', 'response' => $sendResponse->json(), 'status' => $sendResponse->status(), 'timestamp' => now()]);

                if ($sendResponse->successful()) {
                    $this->logActivity(['type' => 'reply_sent', 'to' => $from, 'message' => 'Hi, Welcome To IsellOnline, Nigerian First E-commerce store creator', 'timestamp' => now()]);
                } else {
                    $this->logActivity(['type' => 'reply_failed', 'to' => $from, 'error' => $sendResponse->json(), 'timestamp' => now()]);
                }
            }

            return response()->json(['status' => 'OK']);
        }
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

    private function logActivity($data)
    {
        $path = Storage::path('logs/whatsapp.json');
        $dir = dirname($path);
        if (!is_dir($dir)) {
            mkdir($dir, 0755, true);
        }
        file_put_contents($path, json_encode($data) . "\n", FILE_APPEND | LOCK_EX);
    }
}