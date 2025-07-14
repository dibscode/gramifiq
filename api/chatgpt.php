<?php
header('Content-Type: application/json');
$input = $_POST['message'];
$apiKey = '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';
$apiKeychatgpt = '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';

$data = [
  'model' => 'deepseek-chat',
  'messages' => [
    ["role" => "system", "content" => "Kamu adalah ustadz ahli fiqih. Jawab sesuai rujukan kitab."],
    ["role" => "user", "content" => $input]
  ]
];

$ch = curl_init('https://api.deepseek.com/v1/chat/completions');
curl_setopt_array($ch, [
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_HTTPHEADER => [
    "Content-Type: application/json",
    "Authorization: Bearer $apiKey"
  ],
  CURLOPT_POSTFIELDS => json_encode($data),
]);

$response = curl_exec($ch);
$httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

if ($response === false) {
    $error_msg = curl_error($ch);
    curl_close($ch);
    echo json_encode([
        "choices" => [
            [
                "message" => [
                    "content" => "Curl error: " . $error_msg
                ]
            ]
        ]
    ]);
    exit;
}
curl_close($ch);

if ($httpcode == 200 && $response) {
    echo $response;
} else {
    echo json_encode([
        "choices" => [
            [
                "message" => [
                    "content" => "Maaf, terjadi kesalahan pada server atau API DeepSeek."
                ]
            ]
        ]
    ]);
}