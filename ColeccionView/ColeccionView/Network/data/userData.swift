//
//  user.swift
//  api_rest
//
//  Created by Pato Gallo on 19/09/2024.
//

import Foundation

struct Ejercicio: Decodable {
    let nombre: String?
    let peso: Int?
}

struct Dias: Decodable {
    let lunes: [Ejercicio]?
    let martes: [Ejercicio]?
    let miercoles: [Ejercicio]?
    let jueves: [Ejercicio]?
    let viernes: [Ejercicio]?
}

struct Semana: Decodable {
    let numero: Int
    let dias: Dias
}

struct Rutina: Decodable {
    let nombre: String
    let semanas: [Semana]
}

struct Persona: Decodable {
    let id: String //TODO changes in anothers APIS
    let nombre: String
    let apellido: String
    let edad: Int
    let mail: String
    let contrasena: String
    let rutinas: [Rutina]
}




