//
//  ViewControllerWeeks.swift
//  ControladorDeVistas
//
//  Created by Pato Gallo on 28/08/2024.
//

import UIKit

class ViewControllerWeeks: UIViewController {
    
    //Variables
    var button_type = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Actions
    @IBAction func semana1(_ sender: Any) {
        button_type = 1
        performSegue(withIdentifier: "RExc", sender: self)
    }
    @IBAction func semana2(_ sender: Any) {
        button_type = 2
        performSegue(withIdentifier: "RExc", sender: self)
    }
    @IBAction func semana3(_ sender: Any) {
        button_type = 3
        performSegue(withIdentifier: "RExc", sender: self)
    }
    
    //Override
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch button_type {
        case 1:
            if let destino = segue.destination as? ViewControllerEjercicios{
                destino.label_content = "Semana 1"
            }
        case 2:
            if let destino = segue.destination as? ViewControllerEjercicios{
                destino.label_content = "Semana 2"
            }
            
        case 3:
            if let destino = segue.destination as? ViewControllerEjercicios{
                destino.label_content = "Semana 3"
            }
        
        default:
            print("Invalid button!")
        }
    }
}
