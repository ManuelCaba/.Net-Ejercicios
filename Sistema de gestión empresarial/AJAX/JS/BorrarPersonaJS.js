window.onload = inicializaEventos;
var idPersona;

function inicializaEventos() {

    document.getElementById("btnBorrarPersona").addEventListener("click", borrarPersona, false);
    idPersona = document.getElementById("idPersona");

}

function borrarPersona() {

    var miLLamada = new XMLHttpRequest();
    miLLamada.open("DELETE", "https://apicrudpersonasmanuel.azurewebsites.net/api/Personas/" + idPersona.value);

    miLLamada.onreadystatechange = function () {

        if (miLLamada.readyState < 4) {
            //reloj
        }
        else if (miLLamada.readyState == 4 && miLLamada.status == 204) {

            document.getElementById("resultado").innerText = "Se ha borrado correctamente";
        }
    };

    miLLamada.send();
}