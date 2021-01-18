window.onload = inicializaEventos;
var selMarca;
var selModelo;

function inicializaEventos() {

    selMarca = document.getElementById("selMarca");
    selMarca.onchange = listaModelos;

    var option1 = document.createElement("option");
    option1.text = "Audi";
    var option2 = document.createElement("option");
    option2.text = "Toyota";
    var option3 = document.createElement("option");
    option3.text = "Mercedes";

    selMarca.add(option1);
    selMarca.add(option2);
    selMarca.add(option3);

    listaModelos();

}

function listaModelos() {

    selModelo = document.getElementById("selModelo");
    const seleccionado = selMarca.value;
    var length = selModelo.options.length;
    for (i = length - 1; i >= 0; i--) {
        selModelo.options[i] = null;
    }

    var option1 = document.createElement("option");
    var option2 = document.createElement("option");
    var option3 = document.createElement("option");

    switch (seleccionado) {
        case "Audi":
            option1.text = "Audi A4";
            option2.text = "Audi A6";
            option3.text = "Audi Q5";
            break;
        case "Toyota":
            option1.text = "Corolla";
            option2.text = "Yaris";
            option3.text = "Camry";
        break;
        case "Mercedes":
            option1.text = "GLA";
            option2.text = "Clase C";
            option3.text = "Coupé";
        break;
    }

    selModelo.add(option1);
    selModelo.add(option2);
    selModelo.add(option3);

}