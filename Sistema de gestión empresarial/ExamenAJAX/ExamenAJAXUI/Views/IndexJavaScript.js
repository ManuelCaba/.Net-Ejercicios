window.onload = inicializaEventos;
const llamada = "http://localhost:65123/api/";
var arrayMisiones;
var arrayMisionesActualizar;
var filasModificadas;
var filasActualizadas;
var loader;
var body;

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
    body = table.getElementsByTagName('tbody')[0];
    loader = document.getElementById('loader');
    loaderDepartamentos = document.getElementById('loaderDepartamentos');
    loader.className = "loader";
    document.getElementById("btnGuardar").onclick = actualizarMisionesModificadas;
    getMisiones();
}

/**************************************************************
 * Método que recibe un listado de misiones de la API
 * Signatura = getMisiones()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se cargará un listado completo de misiones
 * proporcionado por la API
 *************************************************************/
function getMisiones() {

    var miLlamada = new XMLHttpRequest();

    miLlamada.open("GET", llamada + "Misiones");

    miLlamada.onreadystatechange = function () {
        if (miLlamada.readyState < 4) {
            loader.className = "loader";
        }
        else {
            if (miLlamada.readyState == 4 && miLlamada.status == 200) {
                arrayMisiones = JSON.parse(miLlamada.responseText);
                //pintar tabla
                loader.className = "";
                mostrarMisiones();
            }
            else if (miLlamada.readyState == 4 && miLlamada.status == 204) {
                loader.className = "";
                alert('Ha habido un problema');
            }
        }
    }

    miLlamada.send();


    
}

/********************************************************************
 * Método que muestra un listado de misiones en una tabla
 * Signatura = mostrarMisiones()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se cargará una tabla con el listado de misiones
 *******************************************************************/
function mostrarMisiones() {
    for (i = 0; i < arrayMisiones.length; i++) {

        celda = 0;
        fila = body.insertRow();

        //Nombre
        nombre = (document.createElement('td'));
        nombre.innerHTML = arrayMisiones[i].nombre;

        //Descripcion
        descripcion = (document.createElement('td'));
        descripcion.innerHTML = arrayMisiones[i].descripcion;

        //Créditos
        celdaCreditos = (document.createElement('td'));
        creditos = (document.createElement('input'));
        creditos.value = arrayMisiones[i].creditos;
        celdaCreditos.appendChild(creditos);

        fila.appendChild(nombre);
        fila.appendChild(descripcion);
        fila.appendChild(celdaCreditos);
    }
}

 /********************************************************************
 * Método que actualiza en una api el precio las misiones modificadas
 * Signatura = actualizarMisionesModificadas()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se actualizará a partir de la API aquellas misiones
 * de la tabla cuyo precio haya sido modificado
 *******************************************************************/
function actualizarMisionesModificadas() {

    filasModificadas = 0;

    contador = 0;

    arrayMisionesActualizar = new Array();

    for (var i = 0, row; row = body.rows[i]; i++) {
        precio = row.cells[2].firstChild.value;
        if (arrayMisiones[i].creditos != precio) {
            arrayMisiones[i].creditos = precio;
            arrayMisionesActualizar[contador] = arrayMisiones[i];
            contador++;
        }
    }

    filasModificadas = arrayMisionesActualizar.length;
    filasActualizadas = 0;

    for (i = 0; i < filasModificadas; i++) {
        editarMision(arrayMisionesActualizar[i]);
        filasActualizadas++;
    }
}

/****************************************************************
 * Método que actualiza una misión en la base de datos
 * Signatura = editarMision(Mision)
 * Entradas:
 *      - Mision
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se actualizará una misión en la base de datos
 ****************************************************************/
function editarMision(Mision) {
    var miLlamada = new XMLHttpRequest();

    miLlamada.open("PUT", llamada + "Misiones/" + Mision.id);

    miLlamada.setRequestHeader('Content-type', 'application/json; charset=utf-8');

    var json = JSON.stringify(Mision);

    // Definicion estados

    miLlamada.onreadystatechange = function () {

        if (miLlamada.readyState < 4) {

            loader.className = "loader";

        }
        else if (miLlamada.readyState == 4 && miLlamada.status == 204) {

            
            loader.className = "";
            //actualizarPagina();
            if (filasActualizadas == filasModificadas) {
                filasActualizadas = 0;
                alert(filasModificadas+' filas afectadas');
            }
            

        }

    };

    miLlamada.send(json);
}
