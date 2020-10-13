<?php
    
    class Pregunta
    {
        //Declaración de los atributos de la clase
        private $pregunta = "DEFAULT";
        private $respuesta;

        //Propiedades de la clase
        public function getPregunta()
        {
            return $this->pregunta;
        }
        
        public function setPregunta($pregunta)
        {
            $this->pregunta = $pregunta;
        }

        public function getRespuesta()
        {
            return $this->respuesta;
        }

        public function setRespuesta($respuesta)
        {
            $this->respuesta = $respuesta;
        }
}