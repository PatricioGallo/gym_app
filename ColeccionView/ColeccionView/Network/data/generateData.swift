//
//  generateData.swift
//  ColeccionView
//
//  Created by Pato Gallo on 23/09/2024.
//

import Foundation

class generateData{
    
    static var newPerson: Persona?
    static var userID   =   1
    
    func modificarPesoEnEjercicio(newPersona: inout Persona, rutinaIndex: Int, semanaIndex: Int, diaIndex: Int, ejercicioIndex: Int, nuevoPeso: Int) {
        // Validar que los índices sean correctos para evitar accesos fuera de rango
        guard rutinaIndex >= 0 && rutinaIndex < newPersona.rutinas.count else { return }
        guard semanaIndex >= 0 && semanaIndex < newPersona.rutinas[rutinaIndex].semanas.count else { return }
        guard diaIndex >= 0 && diaIndex < newPersona.rutinas[rutinaIndex].semanas[semanaIndex].dias.count else { return }
        guard ejercicioIndex >= 0 && ejercicioIndex < newPersona.rutinas[rutinaIndex].semanas[semanaIndex].dias[diaIndex].ejercicios.count else { return }
        
        // Modificar el peso del ejercicio
        newPersona.rutinas[rutinaIndex].semanas[semanaIndex].dias[diaIndex].ejercicios[ejercicioIndex].peso = nuevoPeso
    }
        
}
