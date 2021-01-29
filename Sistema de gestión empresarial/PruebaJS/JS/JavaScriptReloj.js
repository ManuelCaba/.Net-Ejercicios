window.onload = inicializaEventos;
const direccion = "../Images/";

function inicializaEventos() {

    dibujarReloj();
    window.setInterval(dibujarReloj, 1000)
}

function dibujarReloj() {

    var hora1 = document.getElementById("hora1");
    var hora2 = document.getElementById("hora2");
    var minuto1 = document.getElementById("minuto1");
    var minuto2 = document.getElementById("minuto2");
    var segundo1 = document.getElementById("segundo1");
    var segundo2 = document.getElementById("segundo2");

    var now = new Date();
    var hours = now.getHours().toString().split("");
    var minutes = now.getMinutes().toString().split("");
    var seconds = now.getSeconds().toString().split("");

    if (seconds.length == 1) {
        seconds = new Array(0, seconds[0]);
    }

    if (minutes.length == 1) {
        minutes = new Array(0, minutes[0]);
    }

    if (hours.length == 1) {
        hours = new Array(0, hours[0]);
    }

    hora1.src = direccion + hours[0] + ".gif";
    hora2.src = direccion + hours[1] + ".gif";

    minuto1.src = direccion + minutes[0] + ".gif";
    minuto2.src = direccion + minutes[1] + ".gif";

    segundo1.src = direccion + seconds[0] + ".gif";
    segundo2.src = direccion + seconds[1] + ".gif";

}