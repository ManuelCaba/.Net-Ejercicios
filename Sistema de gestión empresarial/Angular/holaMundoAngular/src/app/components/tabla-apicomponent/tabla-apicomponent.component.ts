import { Component, OnInit } from '@angular/core';
import { Persona } from '../../interfaces/persona';
import {PersonasserviceService} from '../../services/personasservice.service'


@Component({
  selector: 'app-tabla-apicomponent',
  templateUrl: './tabla-apicomponent.component.html',
  styleUrls: ['./tabla-apicomponent.component.css']
})
export class TablaAPIComponentComponent implements OnInit {

  listadoPersonas: Persona[] = [];

  constructor(private personaService: PersonasserviceService) { }
  
  ngOnInit(): void {
  
    this.personaService.listadoPersonas().subscribe(data=>{
    
    this.listadoPersonas=data;}, error=>{

      //TODO: Controlar el error
      
      })

  }

}
