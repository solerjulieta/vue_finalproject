<?php header("Access-Control-Allow-Origin: *");

include('conexion.php');

$reseniaId = isset($_POST['resenia_id']) ? $_POST['resenia_id'] : null;
$usuarioId = isset($_POST['usuario_id']) ? $_POST['usuario_id'] : null;
$libroId = isset($_POST['libro_id']) ? $_POST['libro_id'] : null;
$recomiendo = isset($_POST['recomiendo']) ? $_POST['recomiendo'] : null;
$comentario = isset($_POST['comentario']) ? $_POST['comentario'] : null;
$fechaPublicacion = date("Y-m-d H:i:s");

if($usuarioId && $libroId && $recomiendo && $comentario){
    $queryVerif = "SELECT COUNT(*) as total FROM resenias
        WHERE resenia_id = ?
        AND usuario_id = ?
        AND libro_id = ?";
    $stmtVerif = mysqli_prepare($cnx, $queryVerif);
    mysqli_stmt_bind_param($stmtVerif, "sii", $reseniaId, $usuarioId, $libroId);
    mysqli_stmt_execute($stmtVerif);
    $resultadoVerif = mysqli_stmt_get_result($stmtVerif);
    $rowVerif = mysqli_fetch_assoc($resultadoVerif);

    if($rowVerif['total'] > 0){
        $query = "UPDATE resenias
            SET recomiendo = ?, comentario = ?
            WHERE resenia_id = ?
            AND usuario_id = ?
            AND libro_id = ?";
        $stmt = mysqli_prepare($cnx, $query);
        mysqli_stmt_bind_param($stmt, "sssii", $recomiendo, $comentario, $reseniaId, $usuarioId, $libroId);
        $exito = mysqli_stmt_execute($stmt);

        if($exito){
            echo json_encode(['mensaje' => 'La reseña fue actualizada con éxito.']);
        } else {
            echo json_encode(['error' => 'Hubo un error al intentar actualizar la reseña.']);
        }

        mysqli_stmt_close($stmt);
    } else {
        echo json_encode(['error' => 'La reseña que estás intentando editar no existe.']);
    }

    mysqli_close($cnx);
} else {
    echo json_encode(['error' => 'Datos insuficientes para actualizar la reseña.']);
}