//
//  ViewControllerEjercicios.swift
//  ControladorDeVistas
//
//  Created by Pato Gallo on 28/08/2024.
//

import UIKit
import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}

func fetchUsers() {
    // La URL de la API
    let urlString = "https://jsonplaceholder.typicode.com/users"
    
    // Verificamos que la URL es válida
    guard let url = URL(string: urlString) else {
        print("URL inválida.")
        return
    }

    // Crear una sesión URLSession
    let session = URLSession.shared

    // Crear la tarea de datos
    let task = session.dataTask(with: url) { data, response, error in
        // Verificar si hubo algún error
        if let error = error {
            print("Error en la solicitud: \(error)")
            return
        }

        // Verificar que se recibieron datos
        guard let data = data else {
            print("No se recibieron datos.")
            return
        }

        // Intentar decodificar los datos en la estructura [User]
        do {
            let decoder = JSONDecoder()
            let users = try decoder.decode([User].self, from: data)
            
            // Recorrer los usuarios obtenidos
            for user in users {
                print("ID: \(user.id), Name: \(user.name), Email: \(user.email)")
            }
        } catch {
            print("Error al decodificar el JSON: \(error)")
        }
    }

    // Iniciar la tarea
    task.resume()
}

class ViewControllerEjercicios: UIViewController {
    
    var label_content:String?
    @IBOutlet weak var labelOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        if let final_title = label_content {
            self.title = final_title
            labelOutlet.text = final_title
        }
        
    }
    

}
