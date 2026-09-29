<?php
header('Content-Type: application/json');

$data = json_decode(file_get_contents('php://input'), true);

$mobile = $data['mobile'] ?? '';

if (empty($mobile)) {
    echo json_encode([
        "ResponseCode" => "401",
        "Result" => "false",
        "ResponseMsg" => "Mobile number is required."
    ]);
    exit;
}

echo json_encode([
    "ResponseCode" => "200",
    "Result" => "true",
    "ResponseMsg" => "OTP verification skipped.",
    "otp" => "123456"
]);
?>