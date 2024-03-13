<?php header("Access-Control-Allow-Origin: *");

include('conexion.php');

$libroId = isset($_GET['libro_id']) ? $_GET['libro_id'] : null;

if($libroId){
    $query = "SELECT * FROM resenias
        WHERE libro_id = ?";
    $stmt = mysqli_prepare($cnx, $query);
    mysqli_stmt_bind_param($stmt, "i", $libroId);
    $exito = mysqli_stmt_execute($stmt);

    if($exito){
        echo json_encode(['mensaje' => 'Se encontraron reseñas.']);
    } else {
        echo json_encode(['mensaje' => 'Hubo un error al intentar buscar las reseñas.']);
    }
    mysqli_stmt_close($stmt);
} else {
    echo json_encode(['mensaje' => 'Datos insuficientes para obtener las reseñas.']);
}
mysqli_close($cnx);