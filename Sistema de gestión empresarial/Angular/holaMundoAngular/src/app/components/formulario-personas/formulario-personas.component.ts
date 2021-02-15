import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-formulario-personas',
  templateUrl: './formulario-personas.component.html',
  styleUrls: ['./formulario-personas.component.css']
})
export class FormularioPersonasComponent implements OnInit {

  constructor() { }

  ngOnInit(): void {
  }

  saludar(){
    alert("Hola "+(<HTMLInputElement>document.getElementById("nombre")).value+" "+(<HTMLInputElement>document.getElementById("apellidos")).value);
  }

}
