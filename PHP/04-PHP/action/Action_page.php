<?php

//Importación de las clases utilizadas
include "../clase/Persona.php";


//Creamos el objeto persona
$persona = new Persona($_POST["nombre"],$_POST["apellidos"],$_POST["edad"],$_POST["direccion"],"");

//Recogemos el nombre de la imagen
$imagen = $_FILES['imagen']['name'];

$persona->setImagen("../img/".$imagen);

//Recogemos el tipo, tamaño y nombre temporal de la imagen
$tipo = $_FILES['imagen']['type'];
$tamano = $_FILES['imagen']['size'];
$temp = $_FILES['imagen']['tmp_name'];

//Comprobamos que sea de formato de una imagen
if (!((strpos($tipo, "jpeg") || strpos($tipo, "jpg") || strpos($tipo, "png")) &&
    ($tamano < 2000000)))
{
    echo '<div><b>Error. La extensión o el tamaño de los archivos no es correcta.<br/>                 
    - Se permiten archivos .jpg, .png. y de 200 kb como máximo.</b></div>';
}
else //Guardamos la imagen y mostramos los datos del usuario
{
    if (move_uploaded_file($temp, $persona->getImagen()))
    {
        chmod($persona->getImagen(), 0777);

        echo '<p>'.$persona->getNombre().'</p>
              <p>'.$persona->getApellidos().'</p>
              <p>'.$persona->getEdad().'</p>
              <p>'.$persona->getDireccion().'</p>
              <p><img style="width: auto; height: auto" src='.$persona->getImagen().'></p>';
    }
}

?>