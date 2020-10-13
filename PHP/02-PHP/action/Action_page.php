<?php

    include "../clase/Persona.php";

    $persona = new Persona();    

    $persona->setAnhoNacimiento($_POST['anho']);
    
    echo $persona->getEdad();

?>