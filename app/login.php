<?php
header("Access-Control-Allow-Origin: *");

require __DIR__ . '/../../vendor/autoload.php';

include('conexion.php');

use Firebase\JWT\JWT;

$email = $_POST['email'] ?? null;
$password = $_POST['password'] ?? null;

if($email && $password){
    $query = "SELECT * FROM usuarios
        WHERE email = ?";
    $stmt = mysqli_prepare($cnx, $query);
    mysqli_stmt_bind_param($stmt, "s", $email);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $usuario = mysqli_fetch_assoc($result);

    if($usuario && password_verify($password, $usuario['password'])){
        $clave_secreta = "liBr0t3c4_23";
        $token_payload = array(
            "usuario_id" => $usuario['usuario_id'],
            "email" => $usuario['email'],
        );
        $token = JWT::encode($token_payload, $clave_secreta, 'HS256');

        echo json_encode(['token' => $token, 'usuario_id' => $usuario['usuario_id'], 'mensaje' => 'Inicio de sesión exitoso']);
    } else {
        echo json_encode(['error' => 'Credenciales incorrectas']);
    }
    mysqli_stmt_close($stmt);
} else {
    echo json_encode(['error' => 'Datos insuficientes para el inicio de sesión']);
}
mysqli_close($cnx);

