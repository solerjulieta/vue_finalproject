<?php header("Access-Control-Allow-Origin: *");

include('conexion.php');

$reseniaId = isset($_POST['resenia_id']) ? $_POST['resenia_id'] : null;
$usuarioId = isset($_POST['usuario_id']) ? $_POST['usuario_id'] : null;
$libroId = isset($_POST['libro_id']) ? $_POST['libro_id'] : null;
$recomiendo = isset($_POST['recomiendo']) ? $_POST['recomiendo'] : null;
$comentario = isset($_POST['comentario']) ? $_POST['comentario'] : null;
$fechaPublicacion = date("Y-m-d H:i:s");

if($usuarioId && $libroId && $recomiendo && $comentario){
    $query = "INSERT INTO resenias (resenia_id, usuario_id, libro_id, recomiendo, comentario, fecha_publicacion)
        VALUES (?, ?, ?, ?, ?, ?)";
    $stmt = mysqli_prepare($cnx, $query);
    mysqli_stmt_bind_param($stmt, "siisss", $reseniaId, $usuarioId, $libroId, $recomiendo, $comentario, $fechaPublicacion);
    $exito = mysqli_stmt_execute($stmt);

    if($exito){
        echo json_encode(['mensaje' => '¡Se añadió tu reseña!']);
    } else {
        echo json_encode(['error' => 'Hubo un error al intentar añadir tu reseña.']);
    }

    mysqli_stmt_close($stmt);

    mysqli_close($cnx);
} else {
    echo json_encode(['error' => 'Datos insuficientes para añadir la reseña.']);
}