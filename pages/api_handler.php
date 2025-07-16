<?php
header('Content-Type: application/json');
if (isset($_GET['text']) && !empty($_GET['text'])) {
    $question = urlencode($_GET['text']);
    $apiUrl = "https://apicesabotz.biz.id/bard-ai.php?text=" . $question;
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $apiUrl);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 45); 

    $response = curl_exec($ch);
    $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);


    if (curl_errno($ch) || $httpcode != 200) {
        http_response_code(502); 
        echo json_encode([
            'status' => false,
           
            'error' => 'Gagal menghubungi server AI. (Detail: ' . curl_error($ch) . ' | Kode HTTP: ' . $httpcode . ')'
        ]);
    } else {
       
        echo $response;
    }

  
    curl_close($ch);

} else {
   
    http_response_code(400); 
    echo json_encode([
        'status' => false,
        'error' => 'Tidak ada pertanyaan yang dikirim.'
    ]);
}
?>