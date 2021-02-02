window.onload = inicializaEventos;
var table;
var body;
const llamada = "https://apicrudpersonasmanuel.azurewebsites.net/api/";
var arrayPersonas;

function inicializaEventos() {

    table = document.getElementById("table");
    body = table.getElementsByTagName('tbody')[0];
    getPersonas();
}

function getPersonas() {

    var miLlamada = new XMLHttpRequest();

    miLlamada.open("GET", llamada + "Personas");

    miLlamada.onreadystatechange = function () {
        if (miLlamada.readyState < 4) {

        }
        else {
            if (miLlamada.readyState == 4 && miLlamada.status == 200) {
                arrayPersonas = JSON.parse(miLlamada.responseText);
                //pintar tabla
                mostrarPersonas();
            }
        }
    }

    miLlamada.send();
}

function mostrarPersonas() {
    for (i = 0; i < arrayPersonas.length; i++) {

        celda = 0;
        fila = body.insertRow();

        for (var property in arrayPersonas[i]) {
            if (property != "Foto") {
                if (property == "FechaNacimiento") {
                    arrayPersonas[i][property] = arrayPersonas[i][property].split("T")[0];
                    var fecha = new Date(arrayPersonas[i][property]);
                }
                fila.insertCell(celda).innerHTML = arrayPersonas[i][property];
                celda++;
            }
        }
        var btnEditar = document.createElement('button');
        btnEditar.className = "far fa-edit";

        var btnBorrar = document.createElement('button');
        btnBorrar.className = "fas fa-trash";

        var celdaBotones = document.createElement('td');
        celdaBotones.appendChild(btnEditar);
        celdaBotones.appendChild(btnBorrar);
        fila.appendChild(celdaBotones);
    }
}