//
//  user.swift
//  api_rest
//
//  Created by Pato Gallo on 19/09/2024.
//

import Foundation
//
//struct User: Decodable{
//    let name: String?
//    let mail: String?
//    let age: String? // Cambiado a String para coincidir con el JSON
//    let weight: String? // Cambiado a String para coincidir con el JSON
//    let id: String? // Cambiado a String para coincidir con el JSON
//
//    enum CodingKeys: String, CodingKey {
//            case age
//            case id
//            case mail = "mail" // Cambia aquí si el nombre en el JSON es diferente
//            case name
//            case weight
//        }
//}
//
//struct newUser: Encodable{
//    let name: String?
//    let mail: String?
//    let age: String? // Cambiado a String para coincidir con el JSON
//    let weight: String? // Cambiado a String para coincidir con el JSON
//}

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
    let id: String
    let nombre: String
    let apellido: String
    let edad: Int
    let mail: String
    let contrasena: String
    let rutinas: [Rutina]
}



