<?php

    include "../clase/Test.php";
    include "../clase/Pregunta.php";

    $preg1 = new Pregunta();
    $preg2 = new Pregunta();
    $preg3 = new Pregunta();

    $preg1->setRespuesta(3);
    $preg2->setRespuesta(1);
    $preg3->setRespuesta(1);

    $test = new Test();

    $test->addPregunta(0,$preg1);
    $test->addPregunta(1,$preg2);
    $test->addPregunta(2,$preg3);

    for($i = 0; i <= 3; $i++)
    {
       if($test->getPregunta(0)->getRespuesta() == ($_POST[$i]))
       {
           $contadorAciertos++;
       }
    }

    echo $test->getPregunta(0)->getRespuesta()."<br>";
    echo $test->getPregunta(1)->getRespuesta()."<br>";
    echo $test->getPregunta(2)->getRespuesta()."<br>";


?>