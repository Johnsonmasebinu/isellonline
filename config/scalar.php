<?php

return [

    'domain' => null,

    'path' => '/scalar',

    'middleware' => ['web'],

    'url' => '/scribe/openapi.yaml',

    'cdn' => 'https://cdn.jsdelivr.net/npm/@scalar/api-reference',

    'configuration' => [
        'theme' => 'laravel',
        'layout' => 'modern',
        'proxyUrl' => 'https://proxy.scalar.com',
        'showSidebar' => true,
        'hideModels' => false,
        'hideDownloadButton' => false,
        'hideTestRequestButton' => false,
        'hideSearch' => false,
        'darkMode' => false,
        'forceDarkModeState' => 'dark',
        'hideDarkModeToggle' => false,
        'searchHotKey' => 'k',
        'metaData' => [
            'title' => config('app.name').' API Reference',
        ],
        'favicon' => '',
        'hiddenClients' => [],
        'defaultHttpClient' => [
            'targetId' => 'shell',
            'clientKey' => 'curl',
        ],
        'withDefaultFonts' => true,
        'defaultOpenAllTags' => false,
    ],

];