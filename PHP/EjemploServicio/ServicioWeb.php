<?php
header('Content-Type: application/json');//La respuesta es un JSON
$arrayEjemplo=["Seat","Volvo","Smart"];//Array de Strings
echo json_encode($arrayEjemplo);//Mostramos la array como un JSON
//NOTA: Este servicio no cumple REST.

