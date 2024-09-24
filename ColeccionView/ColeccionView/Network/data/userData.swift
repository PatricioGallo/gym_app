//
//  user.swift
//  api_rest
//
//  Created by Pato Gallo on 19/09/2024.
//

import Foundation

struct Ejercicio: Codable {
    var nombre: String?
    var peso: Int?
}

struct Dias: Codable {
    var nombre: String
    var ejercicios: [Ejercicio]
}

struct Semana: Codable {
    var numero: Int
    var dias: [Dias]
}

struct Rutina: Codable {
    var nombre: String
    var semanas: [Semana]
}

struct Persona: Codable {
    var id: String //TODO changes in anothers APIS
    var nombre: String
    var apellido: String
    var edad: Int
    var mail: String
    var contrasena: String
    var rutinas: [Rutina]
}




