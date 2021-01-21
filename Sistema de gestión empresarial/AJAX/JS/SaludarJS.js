window.onload = inicializaEventos;

function inicializaEventos() {

    document.getElementById("btnSaludar").addEventListener("click", saludar, false);

}

function saludar() {

    var miLLamada = new XMLHttpRequest();
    miLLamada.open("GET", "http://localhost:60718/Pages/Hola.html");

    miLLamada.onreadystatechange = function () {

        if (miLLamada.readyState < 4) {
            //reloj
        }
        else if (miLLamada.readyState == 4 && miLLamada.status == 200) {
            var saludo = miLLamada.responseText;

            document.getElementById("respuesta").innerHTML = saludo;
        }
    };

    miLLamada.send();
}