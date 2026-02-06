<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ISellOnline - Your Online Marketplace</title>
    <link rel="icon" type="image/png" href="/assets/logo.png">
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body>
    <div id="app"></div>
    <script>
        window.tagline = "{{ env('TAGLINE') }}";
    </script>
</body>
</html>