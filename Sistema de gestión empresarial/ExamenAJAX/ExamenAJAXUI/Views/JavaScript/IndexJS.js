window.onload = inicializaEventos;
var table;
var body;
var loader;
var loaderDepartamentos;
const llamada = "https://apicrudpersonasmanuel.azurewebsites.net/api/";
var arrayPersonas;
var persona;
var arrayDepartamentos;

/*************************************************************
 * Método que inicializa los eventos utilizados e inicicializa
 * los atributos necesarios
 * Signatura = inicializaEventos()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se inicilizará las propiedades necesarias
 * para el rendimiento de la página
 ************************************************************/
function inicializaEventos() {

    table = document.getElementById("table");
    body = table.getElementsByTagName('tbody')[0];
    loader = document.getElementById('loader');
    loaderDepartamentos = document.getElementById('loaderDepartamentos');
    loader.className = "loader";
    $('#SaveChanges').on("click", saveChanges);
    $('#btnCrear').on("click", getDepartamentos);
    getPersonas();
    filtrar();
}

/**************************************************************
 * Método que recibe un listado de personas de la API
 * Signatura = getPersonas()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se cargará un listado completo de personas
 * proporcionado por la API
 *************************************************************/
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

/********************************************************************
 * Método que recibe un listado de departamentos de la API
 * Signatura = getPersonas()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se cargará un listado completo de departamentos
 * proporcionado por la API
 *******************************************************************/
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

/********************************************************************
 * Método que muestra un listado de personas en una tabla
 * Signatura = mostrarPersonas()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se cargará una tabla con el listado de personas
 *******************************************************************/
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
        btnEditar.className = "far fa-edit btn";
        btnEditar.onclick = getDepartamentos;

        var btnBorrar = document.createElement('button');
        btnBorrar.className = "fas fa-trash btn";
        btnBorrar.name = "btnBorrar"
        btnBorrar.onclick = eliminarPersona;

        var celdaBotones = document.createElement('td');
        celdaBotones.appendChild(btnEditar);
        celdaBotones.appendChild(btnBorrar);
        fila.appendChild(celdaBotones);

        fila.appendChild(IDDepartamento);
    }

    pagination();
}

/****************************************************************
 * Método que crea una paginación con botones para la tabla de
 * personas con un límite de 10 filas
 * Signatura = pagination()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se creará una paginación a partir de botones
 * con un límite de 10 filas de personas por página
 ****************************************************************/
function pagination() {
    $('#nav').remove();
    $('#table').after('<div id="nav"></div>');
    var rowsShown = 10;
    var rowsTotal = $('#table tbody tr').length;
    var numPages = rowsTotal / rowsShown;
    for (i = 0; i < numPages; i++) {
        var pageNum = i + 1;
        $('#nav').append('<a href="#" class="btn" rel="' + i + '">' + pageNum + '</a> ');
    }
    $('#table tbody tr').hide();
    $('#table tbody tr').slice(0, rowsShown).show();
    $('#nav a:first').addClass('active');
    $('#nav a').bind('click', function () {

        $('#nav a').removeClass('active');
        $(this).addClass('active');
        var currPage = $(this).attr('rel');
        var startItem = currPage * rowsShown;
        var endItem = startItem + rowsShown;
        $('#table tbody tr').css('opacity', '0.0').hide().slice(startItem, endItem).
            css('display', 'table-row').animate({ opacity: 1 }, 300);
    })
}

/****************************************************************
 * Método que elimina la persona según la fila del botón pulsado
 * Signatura = eliminarPersona(event)
 * Entradas: 
 *      - event
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se eliminará la persona de la fila donde se 
 * haya pulsado el botón eliminar
 ****************************************************************/
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

/**********************************************************************
 * Método que recarga la página y actualiza los datos
 * Signatura = actualizarPagina()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se recargará la página con los datos actualizados
 **********************************************************************/
function actualizarPagina() {
    $('#modal').modal('hide');
    var new_tbody = document.createElement('tbody');
    body.parentNode.replaceChild(new_tbody, body);
    body = new_tbody;
    getPersonas();
}

/*********************************************************************************
 * Método que abre el modal de formulario de personas y lo prepara
 * según la elección del usuario
 * Signatura = abriModal(event)
 * Entradas:
 *      - event
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se abrirá un formulario preparado según la condición, crear
 * o editar persona
 ********************************************************************************/
function abrirModal(event) {

    var select = document.getElementById('Departamento');
    var fechaNacimiento = new Date();

    if (event.target.id != 'btnCrear') {
        var fila = event.target.closest('tr');
        var ID;
        var nombre;
        var apellidos;
        var direccion;
        var telefono;
        var IDDepartamento;

        ID = fila.cells[0].innerHTML;
        nombre = fila.cells[1].innerHTML;
        apellidos = fila.cells[2].innerHTML;
        fechaNacimiento = new Date(fila.cells[3].innerHTML);
        direccion = fila.cells[4].innerHTML;
        telefono = fila.cells[5].innerHTML;
        IDDepartamento = fila.cells[8].innerHTML;


        document.getElementById('ID').value = ID;
        document.getElementById('Nombre').value = nombre;
        document.getElementById('Apellidos').value = apellidos;
        //document.getElementById('FechaNacimiento').value = fechaNacimiento.getDate();
        document.getElementById('Direccion').value = direccion;
        document.getElementById('Telefono').value = telefono;
    }
    else {
        document.getElementById('ID').value = "";
        document.getElementById('Nombre').value = "";
        document.getElementById('Apellidos').value = "";
        //document.getElementById('FechaNacimiento').value = fechaNacimiento.getDate();
        document.getElementById('Direccion').value = "";
        document.getElementById('Telefono').value = "";
    }

    $(".datepicker").datepicker('setDate', fechaNacimiento);

    select.innerHTML = "";

    arrayDepartamentos.forEach((element, index, array) => {

        prueba = element;

        var opt = document.createElement("option");
        opt.text = element.Nombre;
        opt.value = element.ID;

        if (opt.value == IDDepartamento) {
            opt.selected = 'true';
        }

        select.appendChild(opt);
    });

    $('#modal').modal('show');


}

/***************************************************************************************
 * Método que recoge los datos del formulario y crea o edita una persona
 * según los requerimientos del usuario
 * Signatura = saveChanges()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se recogerá los datos del formulario y editará o creará una persona
 **************************************************************************************/
function saveChanges() {

    var ID = document.getElementById("ID").value;
    var Nombre = document.getElementById("Nombre").value;
    var Apellidos = document.getElementById("Apellidos").value;
    var Direccion = document.getElementById("Direccion").value;
    var Telefono = document.getElementById("Telefono").value;
    var FechaNacimiento = document.getElementById("FechaNacimiento").value;
    var IDDepartamento = document.getElementById("Departamento").value;

    persona = new clsPersona(ID, Nombre, Apellidos, Direccion, Telefono, FechaNacimiento, IDDepartamento, null);

    if (ID == "") {
        insertarPersona(persona);
    }
    else {
        editarPersona(persona);
    }
}

/****************************************************************
 * Método que inserta una persona en la base de datos
 * Signatura = insertarPersona(Persona)
 * Entradas:
 *      - Persona
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se insertará una persona en la base de datos
 ****************************************************************/
async function insertarPersona(Persona) {

    var miLlamada = new XMLHttpRequest();

    miLlamada.open("POST", llamada + "Personas");

    miLlamada.setRequestHeader('Content-type', "application/json;charset=UTF-8");
    // Definicion estados

    miLlamada.onreadystatechange = function () {

        if (miLlamada.readyState < 4) {

            loader.className = "loader";

        }
        else if (miLlamada.readyState == 4 && miLlamada.status == 201) {

            loader.className = "";
            actualizarPagina();
        }

    };

    miLlamada.send(JSON.stringify(Persona));
}

/****************************************************************
 * Método que actualiza una persona en la base de datos
 * Signatura = editarPersona(Persona)
 * Entradas:
 *      - Persona
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se actualizará una persona en la base de datos
 ****************************************************************/
function editarPersona(Persona) {
    var miLlamada = new XMLHttpRequest();

    miLlamada.open("PUT", llamada + "Personas/"+Persona.ID);

    miLlamada.setRequestHeader('Content-type', 'application/json; charset=utf-8');

    var json = JSON.stringify(Persona);

    // Definicion estados

    miLlamada.onreadystatechange = function () {

        if (miLlamada.readyState < 4) {

            loader.className = "loader";

        }
        else if (miLlamada.readyState == 4 && miLlamada.status == 200) {

            loader.className = "";
            actualizarPagina();

        }

    };

    miLlamada.send(json);
}

/***************************************************************************
 * Método que filtra una tabla de personas según sus propiedades
 * Signatura = filtrar()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se filtrará una persona según la necesidad del usuario
 **************************************************************************/
function filtrar() {
    $("#myInput").on("keyup", function () {
        var value = $(this).val().toLowerCase();
        $("#table tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });
}