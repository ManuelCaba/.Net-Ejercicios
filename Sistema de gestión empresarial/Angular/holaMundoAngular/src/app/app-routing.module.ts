import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {TablaPersonasComponent} from './components/tabla-personas/tabla-personas.component'
import {FormularioPersonasComponent} from './components/formulario-personas/formulario-personas.component'
import {ListaPersonasComponent} from './components/lista-personas/lista-personas.component'
import { TablaAPIComponentComponent } from './components/tabla-apicomponent/tabla-apicomponent.component';


const routes: Routes = [{path: '', component: TablaPersonasComponent}, 
{path: 'formulario', component: FormularioPersonasComponent},
{path: 'listado', component: ListaPersonasComponent},
{path: 'api', component: TablaAPIComponentComponent}];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
