<?php header("Access-Control-Allow-Origin: *");

include('conexion.php');

$usuarioId = isset($_POST['usuario_id']) ? $_POST['usuario_id'] : null;
$libroId = isset($_POST['libro_id']) ? $_POST['libro_id'] : null;

if($usuarioId && $libroId){
    $queryVerif = "SELECT * FROM favoritos
        WHERE usuario_id = ?
        AND libro_id = ?";
    $stmtVerif = mysqli_prepare($cnx, $queryVerif);
    mysqli_stmt_bind_param($stmtVerif, "ii", $usuarioId, $libroId);
    mysqli_stmt_execute($stmtVerif);
    $resultVerif = mysqli_stmt_get_result($stmtVerif);

    if(mysqli_num_rows($resultVerif) > 0){
        echo json_encode(['error' => 'El libro ya está añadido en favoritos.']);
    } else {
        $query = "INSERT INTO favoritos (usuario_id, libro_id)
            VALUES (?, ?)";
        $stmt = mysqli_prepare($cnx, $query);
        mysqli_stmt_bind_param($stmt, "ii", $usuarioId, $libroId);
        $exito = mysqli_stmt_execute($stmt);

        if($exito){
            echo json_encode(['mensaje' => 'Libro guardado en favoritos.']);
        } else {
            echo json_encode(['error' => 'Hubo un error al intentar guardar en favoritos.']);
        }
        mysqli_stmt_close($stmt);
    }
    mysqli_stmt_close($stmtVerif);
} else {
    echo json_encode(['error' => 'Datos insuficientes para guardar en favoritos.']);
}

mysqli_close($cnx);