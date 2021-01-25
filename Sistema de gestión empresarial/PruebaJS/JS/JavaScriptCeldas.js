window.onload = inicializaEventos;

var tabla;

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

    document.getElementById("btnRecorreCeldas").onclick = recorrerCeldas;
    document.getElementById("btnAñadeFila").onclick = añadirFila;
    document.getElementById("btnBorraFila").onclick = borrarFila;
    tabla = document.getElementById("tabla");

}

/*************************************************************
 * Método que recorre y muestra el contenido de una tabla
 * Signatura = recorrerCeldas()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se mostrará en un alert el contenido de
 * una tabla
 ************************************************************/
function recorrerCeldas() {

    var contenido;

    for (var i = 0, row; row = tabla.rows[i]; i++) {
        for (var j = 0, col; col = row.cells[j]; j++) {
            if (contenido != null) {
                contenido += ", "+col.innerText;
            }
            else {
                contenido = col.innerText;
            }
        }
    }

    alert(contenido);
}

/*************************************************************
 * Método que añade una fila a una tabla
 * Signatura = añadirFila()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se añadirá una nueva fila a una tabla
 ************************************************************/
function añadirFila() {

    var numeroColumnas = tabla.rows[0].cells.length;

    var fila = document.createElement("tr");
    var numeroAnterior = tabla.rows[(tabla.rows.length - 1)].cells[0].innerText.match(/(\d+)/g)[0];

    for (i = 0; i < numeroColumnas; i++) {

        celda = document.createElement("td");
        numeroCelda = parseInt(numeroAnterior) + 10 + i;
        textoCelda = document.createTextNode("Celda"+numeroCelda);

        celda.appendChild(textoCelda);
        fila.appendChild(celda);
        tabla.appendChild(fila);
    }
}

/*************************************************************
 * Método que borra la última fila de una tabla
 * Signatura = borrarFila()
 * Entradas: No hay
 * Precondiciones: No hay
 * Salidas: No hay
 * Postcondiciones: Se eliminará la última fila de una tabla
 ************************************************************/
function borrarFila() {
    tabla.deleteRow((tabla.rows.length - 1));
}