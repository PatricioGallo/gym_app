class generateData {
    
    static var newPerson: Persona?
    static var userID = 1
    
    // Método para modificar el peso de un ejercicio
    static func modificarPesoEnEjercicio(rutinaIndex: Int, semanaIndex: Int, diaIndex: Int, ejercicioIndex: Int, nuevoPeso: Int) {
        // Verificar que `newPerson` no sea nulo
        guard var persona = newPerson else {
            print("No se ha inicializado la persona.")
            return
        }
        
        // Validar que los índices sean correctos
        guard rutinaIndex >= 0 && rutinaIndex < persona.rutinas.count else { return }
        guard semanaIndex >= 0 && semanaIndex < persona.rutinas[rutinaIndex].semanas.count else { return }
        guard diaIndex >= 0 && diaIndex < persona.rutinas[rutinaIndex].semanas[semanaIndex].dias.count else { return }
        guard ejercicioIndex >= 0 && ejercicioIndex < persona.rutinas[rutinaIndex].semanas[semanaIndex].dias[diaIndex].ejercicios.count else { return }
        
        // Modificar el peso del ejercicio
        persona.rutinas[rutinaIndex].semanas[semanaIndex].dias[diaIndex].ejercicios[ejercicioIndex].peso = nuevoPeso
        
        // Actualizar la variable estática
        newPerson = persona
    }
}

