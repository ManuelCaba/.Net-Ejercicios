<?php
    
    class Persona
    {
        private $edad;
        
        public function getEdad()
        {
            return $this->edad;
        }
        
        public function setEdad($edad)
        {
            $this->edad = $edad;
        }
        
        public function getAnhoNacimiento()
        {
            return date("Y") - $this->edad;
        }
}