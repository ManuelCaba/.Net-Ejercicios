import { Byte } from "@angular/compiler/src/util";

export interface Persona {

    ID: number;

    Nombre: String;

    Apellidos: String;

    Direccion: String;

    FechaNacimiento: Date;

    Foto : Byte[];

    Telefono: String;

    IDDepartamento: number;

    NombreDepartamento: String;
}
