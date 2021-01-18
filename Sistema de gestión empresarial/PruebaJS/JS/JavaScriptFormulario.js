window.onload = inicializaEventos;

function inicializaEventos() {

    document.getElementById("btnSaludar").addEventListener("click", saludar, false);

}

function saludar() {

    var nombre = document.getElementById("inpNombre").value;
    var apellidos = document.getElementById("inpApellidos").value;

    let persona = new clsPersona(nombre, apellidos);

    alert("Hola " + persona.getNombre() + " " + persona.getApellidos());

}