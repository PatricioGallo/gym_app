//
//  MyWeeksViewController.swift
//  ColeccionView
//
//  Created by Pato Gallo on 04/09/2024.
//

import UIKit

class MyWeeksViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    var persona: Persona? // Propiedad para recibir la persona seleccionada

    override func viewDidLoad() {
        super.viewDidLoad()
        if let persona = persona {
                    myLabel.text = "\(persona.nombre) \(persona.apellido) - \(persona.edad) años"
                }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
