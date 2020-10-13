<?php

    include "../clase/Persona.php";

    $persona = new Persona();    
    
    $persona->setEdad($_POST['edad']);
    
    echo date("Y") - $persona->getEdad();

?>