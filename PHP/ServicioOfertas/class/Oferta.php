<?php

//Para poder utilizar json_encode, la clase debe implementar JsonSerializable
class Oferta implements JsonSerializable
{
    private $idOferta;
    private $empresa;
    private $detalles;
    private $sueldo;


    /**
     * @return int
     */
    public function getIdOferta()
    {
        return $this->idOferta;
    }

    /**
     * @param int $idOferta
     */
    public function setIdOferta($idOferta)
    {
        $this->idOferta = $idOferta;
    }

    /**
     * @return string
     */
    public function getEmpresa()
    {
        return $this->empresa;
    }

    /**
     * @param string $empresa
     */
    public function setEmpresa($empresa)
    {
        $this->empresa = $empresa;
    }

    /**
     * @return string
     */
    public function getDetalles()
    {
        return $this->detalles;
    }

    /**
     * @param string $detalles
     */
    public function setDetalles($detalles)
    {
        $this->detalles = $detalles;
    }

    /**
     * @return int
     */
    public function getSueldo()
    {
        return $this->sueldo;
    }

    /**
     * @param int $sueldo
     */
    public function setSueldo($sueldo)
    {
        $this->sueldo = $sueldo;
    }


    public function jsonSerialize()
    {

            return array(
                'id' => $this->idOferta,
                'empresa' => $this->empresa,
                'detalles' => $this->detalles,
                'sueldo' => $this->sueldo,
            );
    }
}
