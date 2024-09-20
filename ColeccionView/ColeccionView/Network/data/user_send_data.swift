struct Ejercicio_mod: Codable {  // Conforma a Encodable y Decodable
    let nombre: String?
    let peso: Int?
}

struct Dias_mod: Codable {
    let lunes: [Ejercicio_mod]?
    let martes: [Ejercicio_mod]?
    let miercoles: [Ejercicio_mod]?
    let jueves: [Ejercicio_mod]?
    let viernes: [Ejercicio_mod]?
}

struct Semana_mod: Codable {
    let numero: Int?
    let dias: Dias_mod?
}

struct Rutina_mod: Codable {
    let nombre: String?
    let semanas: [Semana_mod]?
}

struct Persona_mod: Codable {  // Cambiado a Codable
    let nombre: String?
    let apellido: String?
    let edad: Int?
    let mail: String?
    let contrasena: String?
    let rutinas: [Rutina_mod]?
}

