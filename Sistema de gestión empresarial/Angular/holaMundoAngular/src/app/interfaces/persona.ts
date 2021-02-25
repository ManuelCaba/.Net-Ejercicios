import { Byte } from "@angular/compiler/src/util";

export interface Persona {

    ID: BigInt;

    Nombre: String;

    Apellidos: String;

    Direccion: String;

    FechaNacimiento: Date;

    Foto : Byte[];

    Telefono: String;

    IDDepartamento: BigInt;

    NombreDepartamento: String;
}
