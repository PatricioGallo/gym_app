struct Persona_mod: Codable {  // Cambiado a Codable
    var nombre: String?
    var apellido: String?
    var edad: Int?
    var mail: String?
    var contrasena: String?
    var rutinas: [Rutina]
    var messures:[Messures]?
    var historial : [Historial]?
}

