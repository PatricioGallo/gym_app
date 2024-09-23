//
//  semanaViewCell.swift
//  ColeccionView
//
//  Created by Pato Gallo on 14/09/2024.
//

import UIKit

protocol semanaViewCellDelegate: AnyObject {
    func didSelectSemana(dias: [Dias])
}


class semanaViewCell: UICollectionViewCell {    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var myView: UIView!
    var semanas:[Semana]?
    var dias: [Dias]?
    weak var delegate: semanaViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Fuentes
        myTable.dataSource = self
        myTable.delegate = self
        myTable.register(UINib(nibName: "rutinaTableViewCell", bundle: nil), forCellReuseIdentifier: "rutCell")
        
        // Atributos
        myTable.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        
        // Configuración de la etiqueta y fondo de la vista
        myLabel.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0) // Gris más claro
        myView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        myLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        // Hacer las esquinas redondeadas
        myView.layer.cornerRadius = 10
        myView.layer.masksToBounds = false
        myTable.rowHeight = UITableView.automaticDimension
    }
    
    func porcCalcSemana(semana:Semana) -> String{
        var ejConPeso = 0;
        var ejTotal = 0;
        var ejNil = 0;

        //recorro por dia
        for dia in semana.dias{
            //recorro por ejercicio
            for ejercicio in dia.ejercicios {
                if let peso = ejercicio.peso {
                    if (peso != 0){
                        ejConPeso += 1
                    }
                    ejTotal += 1
                }
                ejNil += 1
            }
        }
    
        if(ejTotal == 0 && ejNil > 0 ){
            return ""
        } else{
            return "\((ejTotal != 0) ? Int((Double(ejConPeso) / Double(ejTotal)) * 100) : 0) %"
        }
    }//Fin porcCalcRutina

}

extension semanaViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return semanas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rutCell", for: indexPath) as! rutinaTableViewCell
        if let semana = semanas?[indexPath.row] {
            cell.firstLabel.text = "Semana \(semana.numero)"
            cell.secondLabel.text = porcCalcSemana(semana: semana)
        }
        return cell
    }
}

extension semanaViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dia = semanas?[indexPath.row].dias {
            delegate?.didSelectSemana(dias: dia)
        }
    }
}
