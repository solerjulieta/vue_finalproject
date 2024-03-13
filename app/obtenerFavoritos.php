<?php header("Access-Control-Allow-Origin: *");

include('conexion.php');

$usuarioId = isset($_GET['usuario_id']) ? $_GET['usuario_id'] : null;

if($usuarioId){
    $query = "SELECT * FROM favoritos
        WHERE usuario_id = ?";
    $stmt = mysqli_prepare($cnx, $query);
    mysqli_stmt_bind_param($stmt, "i", $usuarioId);
    $exito = mysqli_stmt_execute($stmt);

    if($exito){
        $resultados = mysqli_stmt_get_result($stmt);
        $favoritos = [];

        while ($fila = mysqli_fetch_assoc($resultados)) {
            $favoritos[] = $fila;
        }

        echo json_encode(['favoritos' => $favoritos]);
    } else {
        echo json_encode(['mensaje' => 'Hubo un error al intentar obtener los favoritos.']);
    }
    mysqli_stmt_close($stmt);
} else {
    echo json_encode(['error' => 'Datos insuficientes para obtener favoritos.']);
}

mysqli_close($cnx);