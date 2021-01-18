window.onload = inicializaEventos;

function inicializaEventos() {

    //document.getElementById("btnSaludar").onclick = saludar;

    document.getElementById("btnSaludar").addEventListener("click", saludar, false);

}

function saludar() {

    alert("Hello World");

}