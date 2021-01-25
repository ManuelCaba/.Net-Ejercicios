window.onload = inicializaEventos;

function inicializaEventos() {

    document.getElementById("btnApellido").addEventListener("click", apellido, false);

}

function apellido() {

    var miLLamada = new XMLHttpRequest();
    miLLamada.open("GET", "https://apicrudpersonasmanuel.azurewebsites.net/api/Personas/4");

    miLLamada.onreadystatechange = function () {

        if (miLLamada.readyState < 4) {
            //reloj
        }
        else if (miLLamada.readyState == 4 && miLLamada.status == 200) {
            var persona = JSON.parse(miLLamada.responseText);

            document.getElementById("persona").innerText = persona["Apellidos"];
        }
    };

    miLLamada.send();
}