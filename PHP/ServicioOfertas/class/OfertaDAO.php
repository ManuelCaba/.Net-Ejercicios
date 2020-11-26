<?php
require_once "DAO.php";
require_once "Oferta.php";
class OfertaDAO extends DAO
{
//La presente clase, es una clase Mock, para la realización de pruebas

    const SCHEMA="ServicioOfertas";
    const NAME_TABLE="Ofertas";

//Metodo Mock para obtener una array de personas en JSON
    function getOfertas()
    {
        $this->openConection();

        //Definimos la consulta SQL
        $stmt = $this->conexion->prepare(
            "SELECT ID, Empresa, Detalles, Sueldo FROM ". self::SCHEMA.".".self::NAME_TABLE
        );

        //Ejecutamos la consulta SQL
        $stmt->execute();

        //Recibimos los datos de la consulta
        $result = $stmt->get_result();

        //Parseamos los datos recibidos como un array de productos
        $ofertas = $this->getOfertasArray($result);

        //Cerramos la conexion
        $this->closeConection();

        //Devolvemos el array
        return $ofertas;
    }

    private function getOfertasArray($result){
        //Definimos el array de productos
        $ofertas = array();

        //Iteramos los resultados obtenidos en una consulta a la BD
        for ($i=0;$i<$result->num_rows;$i++){
            //Obtenemos el registro
            $row = $result->fetch_assoc();
            //var_dump($row);

            $oferta = new Oferta();
            $oferta->setIdOferta($_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'].$row["ID"]);
            $oferta->setEmpresa($row["Empresa"]);
            $oferta->setDetalles($row["Detalles"]);
            $oferta->setSueldo($row["Sueldo"]);

            //Guardamos el objeto product en el array
            $ofertas[$i] = $oferta;
            //var_dump($products);
        }
        return $ofertas;
    }

//Metodo Mock para obtener una array de personas en JSON
    function getOfertaWithId($id)
    {
        //Creamos un objeto persona con dicha información
        $this->openConection();

        //Definimos la consulta SQL
        $stmt = $this->conexion->prepare(
            "SELECT ID, Empresa, Detalles, Sueldo FROM ". self::SCHEMA.".".self::NAME_TABLE." WHERE ID = (?)"
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

            $oferta = new Oferta();
            $oferta->setIdOferta($_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'].$row["ID"]);
            $oferta->setEmpresa($row["Empresa"]);
            $oferta->setDetalles($row["Detalles"]);
            $oferta->setSueldo($row["Sueldo"]);
        }

        return $oferta;
    }
}