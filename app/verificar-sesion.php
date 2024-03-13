<?php header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');

session_start();

try {
    if (isset($_SESSION['usuario_id'])) {
        echo json_encode(['usuarioLogueado' => true]);
    } else {
        echo json_encode(['usuarioLogueado' => false]);
    }
} catch (Exception $e) {
    $response = [
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ];
    echo json_encode($response);
}
?>