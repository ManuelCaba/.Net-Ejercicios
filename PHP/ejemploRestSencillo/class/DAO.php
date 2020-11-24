<?php


/*Clase abstracta diseñada para acceder a una base de datos MySQL*/
class DAO
{

    //Datos para conectarse a la BD MySQL del Servidor
    const SERVER_MYSQL = "localhost";
    const USER_MYSQL = "usuario";
    const PASSWORD_MYSQL = "asd";

    /*Atributos*/
    protected $conexion;


    /*Metodos de la clase DAO*/

    //Método utilizado para abrir una conexion con la BD
    protected function openConection()
    {
        $this->conexion=new mysqli(self::SERVER_MYSQL, self::USER_MYSQL, self::PASSWORD_MYSQL);
        if ( $this->conexion->connect_error) {
            echo " <br> Failed to connect to MySQL: " .  $this->conexion->connect_error . "<br>";
        }
        return  $this->conexion;
    }

    //Método utilizado para ejecutar una sentencia SQL, sin preparar, y sin resultados a obtener
    protected function query($sql)
    {
        //Abrimos la conexión con la BD
        $this->openConection();

        //Ejecutamos la sentencia SQL
        $sucess =  $this->conexion->query($sql);

        //Comprobamos si ha habido algún error
        if ($sucess === FALSE) {
            echo "<br> Error executing: " . $sql . "<br>";
        }

        //Cerramos la conexion
        $this->closeConection();
    }

    //Método utilizado para ejecutar una sentencia SQL, sin preparar, con resultados a obtener.
    //Por ello no se cierra la conexión, y se devuelve el resultado de la ejecución de la sentencia
    protected function query_with_result($sql)
    {
        //Abrimos la conexión con la BD
        $this->openConection();

        //Ejecutamos la sentencia SQL
        $sucess =  $this->conexion->query($sql);

        //Comprobamos si ha habido algún error
        if ($sucess === FALSE) {
            echo "<br> Error executing: " . $sql . "<br>";
        }

        return $sucess;
    }

    //Método utilizado para cerrar la conexión
    protected function closeConection(){

        /* Consignar y consolidar la transacción */
        if (! $this->conexion->commit()) {
            print("Error with transaction\n");
        }
        //Cerramos la conexion
        $this->conexion->close();
    }
}