<?php
    
    class Persona
    {
        //Declaración de los atributos de la clase
        private $nombre;
        private $apellidos;
        private $edad;
        private $direccion;
        private $imagen;

        //Constructor
        public function __construct($nombre, $apellidos, $edad, $direccion, $imagen)
        {
            $this->nombre = $nombre;
            $this->apellidos = $apellidos;
            $this->edad = $edad;
            $this->direccion = $direccion;
            $this->imagen = $imagen;
        }

        //Propiedades de la clase
        public function getNombre()
        {
            return $this->nombre;
        }
        
        public function setNombre($nombre)
        {
            $this->nombre = $nombre;
        }

        public function getApellidos()
        {
            return $this->apellidos;
        }

        public function setApellidos($apellidos)
        {
            $this->apellidos = $apellidos;
        }

        public function getEdad()
        {
            return $this->edad;
        }

        public function setEdad($edad)
        {
            $this->edad = $edad;
        }

        public function getDireccion()
        {
            return $this->direccion;
        }

        public function setDireccion($direccion)
        {
            $this->direccion = $direccion;
        }

        public function getImagen()
        {
            return $this->imagen;
        }

        public function setImagen($imagen)
        {
            $this->imagen = $imagen;
        }
}