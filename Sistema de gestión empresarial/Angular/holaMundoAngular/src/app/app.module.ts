import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { TablaPersonasComponent } from './components/tabla-personas/tabla-personas.component';
import { FormularioPersonasComponent } from './components/formulario-personas/formulario-personas.component';
import { ListaPersonasComponent } from './components/lista-personas/lista-personas.component';

import { ReactiveFormsModule } from '@angular/forms';
import {MatProgressSpinnerModule} from '@angular/material/progress-spinner';
import {MatRadioModule} from '@angular/material/radio';
import {MatSliderModule} from '@angular/material/slider';
import {MatChipsModule} from '@angular/material/chips';
import {MatFormFieldModule} from '@angular/material/form-field'; 
import { MatCardModule } from '@angular/material/card'; 
import { MatInputModule } from '@angular/material/input';

//API
import { HttpClientModule } from '@angular/common/http';

@NgModule({
  declarations: [
    AppComponent,
    TablaPersonasComponent,
    FormularioPersonasComponent,
    ListaPersonasComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    MatProgressSpinnerModule,
    MatRadioModule,
    MatSliderModule,
    MatChipsModule,
    MatFormFieldModule,
    MatCardModule,
    MatInputModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
