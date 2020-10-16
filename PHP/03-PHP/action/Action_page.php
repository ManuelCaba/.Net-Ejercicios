<?php

//Importación de las clases utilizadas
include "../clase/Test.php";
include "../clase/Pregunta.php";

$imagen = "";

//Se generan las preguntas
$preg1 = new Pregunta();
$preg2 = new Pregunta();
$preg3 = new Pregunta();

$preg1->setRespuesta(3);
$preg2->setRespuesta(1);
$preg3->setRespuesta(1);

$test = new Test();

//Se recuperan las respuestas del cliente
$respuestasClientes = [];

$respuestasClientes[0] = (int)$_POST["preg1"];
$respuestasClientes[1] = (int)$_POST["preg2"];
$respuestasClientes[2] = (int)$_POST["preg3"];

//Se guardan añaden nuevas preguntas
$test->addPregunta(0,$preg1);
$test->addPregunta(1,$preg2);
$test->addPregunta(2,$preg3);

//Se comprueban las respuestas

$contadorAciertos = 0;


for($i = 0; $i < 3; $i++)
{
    $respuesta = $test->getPregunta($i)->getRespuesta();

    $respuestaCliente = $respuestasClientes[$i];

   if($respuesta == $respuestaCliente)
   {
       $contadorAciertos++;
   }
}

switch ($contadorAciertos)
{
    case 1:
        $imagen = "../img/img1.jpg";
        echo '<h1>Has tenido '.$contadorAciertos.' aciertos</h1><img src="'.$imagen.'" width: 30%; height: 100px;>';
    break;
    case 2:
        $imagen = "../img/img2.jpg";
        echo '<h1>Has tenido '.$contadorAciertos.' aciertos</h1><img src="'.$imagen.'" width: 30%; height: 100px;>';
    break;
    case 3:
        $imagen = "../img/img3.jpg";
        echo '<h1>Has tenido '.$contadorAciertos.' aciertos</h1><img src="'.$imagen.'" width: 30%; height: 100px;>';
    break;
    default:
        echo "Me comes la pinga";
}

?>