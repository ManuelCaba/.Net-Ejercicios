window.onload = inicializaEventos;
var table;
var body;
var loader;
const llamada = "https://apicrudpersonasmanuel.azurewebsites.net/api/";
var arrayPersonas;
var arrayDepartamentos;

function inicializaEventos() {

    table = document.getElementById("table");
    body = table.getElementsByTagName('tbody')[0];
    loader = document.getElementById('loader');
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

function getDepartamentos() {

    var miLlamada = new XMLHttpRequest();

    miLlamada.open("GET", llamada + "Departamentos");

    miLlamada.onreadystatechange = function () {
        if (miLlamada.readyState < 4) {
        }
        else {
            if (miLlamada.readyState == 4 && miLlamada.status == 200) {
                arrayDepartamentos = JSON.parse(miLlamada.responseText);
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
        btnEditar.onclick = abrirModal;

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
        
    } else {
        userPreference = "Save Canceled!";
    }
    
}

function actualizarPagina() {
    var new_tbody = document.createElement('tbody');
    body.parentNode.replaceChild(new_tbody, body);
    body = new_tbody;
    getPersonas();
}

async function abrirModal(event) {
    
    var fila = event.target.closest('tr');
    if (fila != null) {
        var ID = fila.cells[0].innerHTML;
        var nombre = fila.cells[1].innerHTML;
        var apellidos = fila.cells[2].innerHTML;
        var fechaNacimiento = new Date(fila.cells[3].innerHTML);
        var direccion = fila.cells[4].innerHTML;
        var telefono = fila.cells[5].innerHTML;
        var IDDepartamento = fila.cells[8].innerHTML;
    }

    await getDepartamentos();

    document.getElementById('modal').style.visibility = "visible";


}

function cerrarModal() {
    document.getElementById('modal').style.visibility = "hidden";
}