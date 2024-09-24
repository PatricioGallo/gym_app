//struct Ejercicio_mod: Codable {  // Conforma a Encodable y Decodable
//    var nombre: String?
//    var peso: Int?
//}
//
//struct Dias_mod: Codable {
//    var nombre: String
//    var ejercicios: [Ejercicio_mod]
//}
//
//struct Semana_mod: Codable {
//    var numero: Int
//    var dias: [Dias_mod]
//}
//
//struct Rutina_mod: Codable {
//    var nombre: String?
//    var semanas: [Semana_mod]?
//}

struct Persona_mod: Codable {  // Cambiado a Codable
    var nombre: String?
    var apellido: String?
    var edad: Int?
    var mail: String?
    var contrasena: String?
    var rutinas: [Rutina]
}

