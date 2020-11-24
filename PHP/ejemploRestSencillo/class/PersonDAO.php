<?php
require_once "DAO.php";
require_once "Person.php";
class PersonDAO extends DAO
{
//La presente clase, es una clase Mock, para la realización de pruebas

    const SCHEMA="EjemploServicio";
    const NAME_TABLE="Personas";

//Metodo Mock para obtener una array de personas en JSON
    function getPersons()
    {
        $this->openConection();

        //Definimos la consulta SQL
        $stmt = $this->conexion->prepare(
            "SELECT ID, Name, Surname, Age FROM ". self::SCHEMA.".".self::NAME_TABLE
        );

        //Ejecutamos la consulta SQL
        $stmt->execute();

        //Recibimos los datos de la consulta
        $result = $stmt->get_result();

        //Parseamos los datos recibidos como un array de productos
        $persons = $this->getPersonsArray($result);

        //Cerramos la conexion
        $this->closeConection();

        //Devolvemos el array
        return $persons;
    }

    private function getPersonsArray($result){
        //Definimos el array de productos
        $persons = array();

        //Iteramos los resultados obtenidos en una consulta a la BD
        for ($i=0;$i<$result->num_rows;$i++){
            //Obtenemos el registro
            $row = $result->fetch_assoc();
            //var_dump($row);
            //Creamos el objeto producto y seteamos los valores

            $person = new Person();
            $person->setIdPerson($_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'].$row["ID"]);
            $person->setName($row["Name"]);
            $person->setSurname($row["Surname"]);
            $person->setAge($row["Age"]);

            //Guardamos el objeto product en el array
            $persons[$i] = $person;
            //var_dump($products);
        }
        return $persons;
    }

//Metodo Mock para obtener una array de personas en JSON
    function getPersonWithId($id)
    {
        //Creamos un objeto persona con dicha información
        $this->openConection();

        //Definimos la consulta SQL
        $stmt = $this->conexion->prepare(
            "SELECT ID, Name, Surname, Age FROM ". self::SCHEMA.".".self::NAME_TABLE." WHERE ID = (?)"
        );

        $stmt->bind_param("i", $id);

        //Ejecutamos la consulta SQL
        $stmt->execute();

        //Recibimos los datos de la consulta
        $result = $stmt->get_result();

        if ($result->num_rows > 0){
            //Obtenemos el registro
            $row = $result->fetch_assoc();
            //var_dump($row);
            //Creamos el objeto producto y seteamos los valores

            $person = new Person();
            $person->setIdPerson($_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'].$row["ID"]);
            $person->setName($row["Name"]);
            $person->setSurname($row["Surname"]);
            $person->setAge($row["Age"]);
        }

        return $person;
    }
}