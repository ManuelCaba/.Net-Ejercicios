<?php
    
    class Persona
    {
        private $anhoNacimiento;
        
        public function getEdad()
        {
            return date("Y") - $this->anhoNacimiento;
        }
        
        public function setAnhoNacimiento($anhoNacimiento)
        {
            $this->anhoNacimiento = $anhoNacimiento;
        }
        
        public function getAnhoNacimiento()
        {
            return $this->anhoNacimiento;
        }
}