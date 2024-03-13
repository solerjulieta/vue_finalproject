<?php header("Access-Control-Allow-Origin: *");

include('conexion.php');

$usuarioId = isset($_POST['usuario_id']) ? $_POST['usuario_id'] : null;
$libroId = isset($_POST['libro_id']) ? $_POST['libro_id'] : null;

if($usuarioId && $libroId){
    $query = "DELETE FROM favoritos
        WHERE usuario_id = ?
        AND libro_id = ?";
    $stmt = mysqli_prepare($cnx, $query);
    mysqli_stmt_bind_param($stmt, "ii", $usuarioId, $libroId);
    $exito = mysqli_stmt_execute($stmt);

    if($exito){
        echo json_encode(['mensaje' => 'El libro fue eliminado de favoritos.']);
    } else {
        echo json_encode(['mensaje' => 'Hubo un error al intentar quitar el libro de favoritos.']);
    }
    mysqli_stmt_close($stmt);
} else {
    echo json_encode(['error' => 'Datos insuficientes para eliminar de favoritos.']);
}
mysqli_close($cnx);