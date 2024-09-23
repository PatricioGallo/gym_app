//
//  user.swift
//  api_rest
//
//  Created by Pato Gallo on 19/09/2024.
//

import Foundation

struct Ejercicio: Decodable {
    var nombre: String?
    var peso: Int?
}

struct Dias: Decodable {
    var nombre: String
    var ejercicios: [Ejercicio]
}

struct Semana: Decodable {
    var numero: Int
    var dias: [Dias]
}

struct Rutina: Decodable {
    var nombre: String
    var semanas: [Semana]
}

struct Persona: Decodable {
    var id: String //TODO changes in anothers APIS
    var nombre: String
    var apellido: String
    var edad: Int
    var mail: String
    var contrasena: String
    var rutinas: [Rutina]
}




