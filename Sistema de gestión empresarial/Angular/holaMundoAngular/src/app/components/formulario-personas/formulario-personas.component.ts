import { Component, OnInit } from '@angular/core';
import {FormGroup, FormControl, Validators} from '@angular/forms';

@Component({
  selector: 'app-formulario-personas',
  templateUrl: './formulario-personas.component.html',
  styleUrls: ['./formulario-personas.component.css']
})
export class FormularioPersonasComponent implements OnInit {

  formulario!: FormGroup;

  constructor() { }

  ngOnInit(): void {
    this.formulario=new FormGroup({
      nombre: new FormControl('',[Validators.required, Validators.minLength(3)]),
      apellidos:new FormControl('',[])});
  }

  saludar(){
    //alert("Hola "+(<HTMLInputElement>document.getElementById("nombre")).value+" "+(<HTMLInputElement>document.getElementById("apellidos")).value);
    alert('Hola ' + this.formulario.controls.nombre.value + ' ' + this.formulario.controls.apellidos.value);
  }

}
