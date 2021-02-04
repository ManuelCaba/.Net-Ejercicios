﻿window.onload = inicializaEventos;
var table;
var body;
var loader;
var loaderDepartamentos;
const llamada = "https://apicrudpersonasmanuel.azurewebsites.net/api/";
var arrayPersonas;
var arrayDepartamentos;

function inicializaEventos() {

    table = document.getElementById("table");
    body = table.getElementsByTagName('tbody')[0];
    loader = document.getElementById('loader');
    loaderDepartamentos = document.getElementById('loaderDepartamentos');
    loader.className = "loader";
    getPersonas();
}

function getPersonas() {

    var miLlamada = new XMLHttpRequest();

    miLlamada.open("GET", llamada + "PersonasDTO");

    miLlamada.onreadystatechange = function () {
        if (miLlamada.readyState < 4) {
            loader.className = "loader";
        }
        else {
            if (miLlamada.readyState == 4 && miLlamada.status == 200) {
                arrayPersonas = JSON.parse(miLlamada.responseText);
                //pintar tabla
                loader.className = "";
                mostrarPersonas();
            }
        }
    }

    miLlamada.send();
}

function getDepartamentos(event) {

    var miLlamada = new XMLHttpRequest();

    miLlamada.open("GET", llamada + "Departamentos");

    miLlamada.onreadystatechange = function () {
        if (miLlamada.readyState < 4) {

        }
        else {
            if (miLlamada.readyState == 4 && miLlamada.status == 200) {
                arrayDepartamentos = JSON.parse(miLlamada.responseText);
                abrirModal(event);
            }
        }
    }

    miLlamada.send();
}

function mostrarPersonas() {
    for (i = 0; i < arrayPersonas.length; i++) {

        celda = 0;
        fila = body.insertRow();

        ID = (document.createElement('td'));
        ID.innerHTML = arrayPersonas[i].ID;
        nombre = (document.createElement('td'));
        nombre.innerHTML = arrayPersonas[i].Nombre;
        apellidos = (document.createElement('td'));
        apellidos.innerHTML = arrayPersonas[i].Apellidos;
        fechaNacimiento = (document.createElement('td'));
        fechaNacimiento.innerHTML = arrayPersonas[i].FechaNacimiento.split('T')[0];
        direccion = (document.createElement('td'));
        direccion.innerHTML = arrayPersonas[i].Direccion;
        telefono = (document.createElement('td'));
        telefono.innerHTML = arrayPersonas[i].Telefono;
        nombreDepartamento = (document.createElement('td'));
        nombreDepartamento.innerHTML = arrayPersonas[i].NombreDepartamento;
        IDDepartamento = (document.createElement('td'));
        IDDepartamento.innerHTML = arrayPersonas[i].IDDepartamento;
        IDDepartamento.style.visibility = "hidden";

        fila.appendChild(ID);
        fila.appendChild(nombre);
        fila.appendChild(apellidos);
        fila.appendChild(fechaNacimiento);
        fila.appendChild(direccion);
        fila.appendChild(telefono);
        fila.appendChild(nombreDepartamento);

        var btnEditar = document.createElement('button');
        btnEditar.className = "far fa-edit";
        btnEditar.onclick = getDepartamentos;

        var btnBorrar = document.createElement('button');
        btnBorrar.className = "fas fa-trash";
        btnBorrar.name = "btnBorrar"
        btnBorrar.onclick = eliminarPersona;

        var celdaBotones = document.createElement('td');
        celdaBotones.appendChild(btnEditar);
        celdaBotones.appendChild(btnBorrar);
        fila.appendChild(celdaBotones);

        fila.appendChild(IDDepartamento);
    }
}

function eliminarPersona(event) {
    if (confirm("Está seguro que desea eliminar el usuario?") == true) {

        var btn = event.target;
        var filaActual = btn.closest('tr');
        var idPersona = filaActual.cells[0].innerHTML;

        var miLlamada = new XMLHttpRequest();

        miLlamada.open("DELETE", llamada + "Personas/" + idPersona);

        miLlamada.onreadystatechange = function () {
            if (miLlamada.readyState < 4) {
                loader.className = "loader";
            }
            else {
                if (miLlamada.readyState == 4 && miLlamada.status == 204) {
                    loader.className = "";
                    actualizarPagina();
                }
            }
        }

        miLlamada.send();
        
    }     
}

function actualizarPagina() {
    var new_tbody = document.createElement('tbody');
    body.parentNode.replaceChild(new_tbody, body);
    body = new_tbody;
    getPersonas();
}

function abrirModal(event) {
    
    var fila = event.target.closest('tr');
    var ID;
    var nombre;
    var apellidos;
    var fechaNacimiento;
    var direccion;
    var telefono;
    var IDDepartamento;

    if (fila != null) {
        ID = fila.cells[0].innerHTML;
        nombre = fila.cells[1].innerHTML;
        apellidos = fila.cells[2].innerHTML;
        fechaNacimiento = new Date(fila.cells[3].innerHTML);
        direccion = fila.cells[4].innerHTML;
        telefono = fila.cells[5].innerHTML;
        IDDepartamento = fila.cells[8].innerHTML;
    }

    document.getElementById('ID').value = ID;
    document.getElementById('Nombre').value = nombre;
    document.getElementById('Apellidos').value = apellidos;
    $(".datepicker").datepicker('setDate', fechaNacimiento);
    //document.getElementById('FechaNacimiento').value = fechaNacimiento.getDate();
    document.getElementById('Direccion').value = direccion;
    document.getElementById('Telefono').value = telefono;
    document.getElementById('Departamento');

    $('#modal').modal('show');

}