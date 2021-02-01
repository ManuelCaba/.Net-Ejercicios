window.onload = inicializaEventos;
var table;
var body;
const llamada = "https://apicrudpersonasmanuel.azurewebsites.net/api/";
var arrayPersonas;

$(document).ready(function () {
    table = $('#table').DataTable({
        "processing": true,
        "serverSide": true,
        "type": "GET",
        "ajax": "https://apicrudpersonasmanuel.azurewebsites.net/api/Personas"
    });

    ////getting the value of search box
    //$('.dataTables_filter input').unbind().keyup(function (e) {
    //    var value = $(this).val();
    //    if (value.length > 3) {
    //        alert(value);
    //        table.search(value).draw();
    //    } else {
    //        //optional, reset the search if the phrase 
    //        //is less then 3 characters long
    //        table.search('').draw();
    //    }
    //});
});

function inicializaEventos() {

    table = document.getElementById("table");
    body = table.getElementsByTagName('tbody')[0];
    getPersonas();


}

function getPersonas() {

    var miLlamada = new XMLHttpRequest();

    var prueba = llamada + "Personas";

    miLlamada.open("GET", "https://apicrudpersonasmanuel.azurewebsites.net/api/Personas");

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
                fila.insertCell(celda).innerHTML = arrayPersonas[i][property];
                celda++;
            }
            fila.insertCell(celda).innerHTML = 
        }
    }
}