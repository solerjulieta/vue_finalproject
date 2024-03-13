<?php
header("Access-Control-Allow-Origin: *");

include('conexion.php');

$libro_id = isset($_GET['libro_id']) ? $_GET['libro_id'] : null;

if ($libro_id) {
    $query = "SELECT * FROM libros WHERE libro_id = ?";
    $stmt = mysqli_prepare($cnx, $query);
    
    if ($stmt) {
        mysqli_stmt_bind_param($stmt, "i", $libro_id);
        mysqli_stmt_execute($stmt);

        $result = mysqli_stmt_get_result($stmt);
        $detalle_libro = mysqli_fetch_assoc($result);

        if ($detalle_libro) {
            echo json_encode($detalle_libro);
        } else {
            echo json_encode(["error" => "ID de libro no válido"]);
        }

        mysqli_stmt_close($stmt);
    } else {
        echo json_encode(["error" => "Error en la preparación de la consulta"]);
    }
} else {
    echo json_encode(["error" => "ID de libro no proporcionado"]);
}
?>