<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class WhatsAppController extends Controller
{
    public function webhook(Request $request)
    {
        if ($request->isMethod('get')) {
            // Verification
            if ($request->hub_mode == 'subscribe' && $request->hub_verify_token == config('whatsapp.verify_token')) {
                return response($request->hub_challenge, 200)->header('Content-Type', 'text/plain');
            }
            return response('Forbidden', 403);
        }

        if ($request->isMethod('post')) {
            // Handle incoming messages
            $data = $request->all();

            if (isset($data['entry'][0]['changes'][0]['value']['messages'])) {
                $phoneNumberId = $data['entry'][0]['changes'][0]['value']['metadata']['phone_number_id'];
                $from = $data['entry'][0]['changes'][0]['value']['messages'][0]['from'];

                // Send reply
                Http::withHeaders([
                    'Authorization' => 'Bearer ' . config('whatsapp.access_token'),
                    'Content-Type' => 'application/json',
                ])->post("https://graph.facebook.com/v18.0/{$phoneNumberId}/messages", [
                    'messaging_product' => 'whatsapp',
                    'to' => $from,
                    'type' => 'text',
                    'text' => ['body' => 'Hi, Welcome To IsellOnline, Nigerian First E-commerce store creator']
                ]);
            }

            return response()->json(['status' => 'OK']);
        }
    }
}