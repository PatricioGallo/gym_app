struct Ejercicio_mod: Codable {  // Conforma a Encodable y Decodable
    let nombre: String?
    let peso: Int?
}

struct Dias_mod: Codable {
    var nombre: String
    var ejercicios: [Ejercicio_mod]
}

struct Semana_mod: Codable {
    var numero: Int
    var dias: [Dias_mod]
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

