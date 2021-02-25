import { Injectable } from '@angular/core';

import { HttpClient } from '@angular/common/http';

import { Observable } from 'rxjs';

import { Persona } from '../interfaces/persona';

@Injectable({
  providedIn: 'root'
})
export class PersonasserviceService {

  /*URL de mi aPI para usar en todo el Servicio*/

  urlWebAPI='https://apicrudpersonasmanuel.azurewebsites.net/api/PersonasDTO';

  constructor(private http: HttpClient) { }

  listadoPersonas(): Observable<Persona[]>{

    return this.http.get<Persona[]>(this.urlWebAPI);
  }
}
