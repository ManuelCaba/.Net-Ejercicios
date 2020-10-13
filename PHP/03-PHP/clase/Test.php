<?php
    
    class Test
    {
        //Declaración de los atributos de la clase
        private $preguntas = array();

        //Propiedades de la clase
        public function getPregunta($index)
        {
            return $this->preguntas[$index];
        }

        public function addPregunta($index, $pregunta)
        {
            $this->preguntas[$index] = $pregunta;
        }
}