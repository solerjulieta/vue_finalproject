<?php header("Access-Control-Allow-Origin: *");

include('conexion.php');

$nombre = isset($_POST['nombre']) ? $_POST['nombre'] : null;
$email = isset($_POST['email']) ? $_POST['email'] : null;
$password = isset($_POST['password']) ? $_POST['password'] : null;

if($nombre && $email && $password){
    $passwordHashed = password_hash($password, PASSWORD_DEFAULT);

    $query = "INSERT INTO usuarios (nombre, email, password)
        VALUES (?, ?, ?)";
    $stmt = mysqli_prepare($cnx, $query);

    mysqli_stmt_bind_param($stmt, "sss", $nombre, $email, $passwordHashed);

    $exito = mysqli_stmt_execute($stmt);

    if ($exito) {
        echo json_encode(["mensaje" => "Registro exitoso"]);
    } else {
        echo json_encode(["error" => "Error al intentar registrar el usuario"]);
    }
    mysqli_stmt_close($stmt);
} else {
    echo json_encode(["error" => "Datos insuficientes para el registro"]);
}