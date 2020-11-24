<?php

//Para poder utilizar json_encode, la clase debe implementar JsonSerializable
class Person implements JsonSerializable
{
    private $idPerson;
    private $name;
    private $surname;
    private $age;


    /**
     * @return int
     */
    public function getIdPerson()
    {
        return $this->idPerson;
    }

    /**
     * @param int $idPerson
     */
    public function setIdPerson($idPerson)
    {
        $this->idPerson = $idPerson;
    }

    /**
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param string $name
     */
    public function setName($name)
    {
        $this->name = $name;
    }

    /**
     * @return string
     */
    public function getSurname()
    {
        return $this->surname;
    }

    /**
     * @param string $surname
     */
    public function setSurname($surname)
    {
        $this->surname = $surname;
    }

    /**
     * @return int
     */
    public function getAge()
    {
        return $this->age;
    }

    /**
     * @param int $age
     */
    public function setAge($age)
    {
        $this->age = $age;
    }


    public function jsonSerialize()
    {

            return array(
                'id' => $this->idPerson,
                'name' => $this->name,
                'surname' => $this->surname,
                '$age' => $this->age,
            );
    }
}
