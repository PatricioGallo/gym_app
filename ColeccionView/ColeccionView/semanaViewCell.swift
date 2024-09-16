//
//  semanaViewCell.swift
//  ColeccionView
//
//  Created by Pato Gallo on 14/09/2024.
//

import UIKit

protocol semanaViewCellDelegate: AnyObject {
    func didSelectSemana(dias: Dias)
}


class semanaViewCell: UICollectionViewCell {    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var myView: UIView!
    var semanas:[Semana]?
    var dias: Dias?
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
    
    func porcCalcSemana(semana:Semana) -> Int{
        var ejConPeso = 0;
        var ejTotal = 0;
        var peso_total = 0;
        print(semana.numero)
        //Recorro dia lunes si existe
        if let lunes = semana.dias.lunes{
            for dia in lunes{
                if let peso = dia.peso {
                    if (peso != 0){
                        ejConPeso += 1
                    }
                    ejTotal += 1
                }
            }
        }
        //Recorro dia martes si existe
        if let martes = semana.dias.martes{
            for dia in martes{
                if let peso = dia.peso {
                    if (peso != 0){
                        ejConPeso += 1
                    }
                    ejTotal += 1
                }
            }
        }
        //Recorro dia miercoles si existe
        if let miercoles = semana.dias.miercoles{
            for dia in miercoles{
                if let peso = dia.peso {
                    if (peso != 0){
                        ejConPeso += 1
                    }
                    ejTotal += 1
                }
            }
        }
        //Recorro dia jueves si existe
        if let jueves = semana.dias.jueves{
            for dia in jueves{
                if let peso = dia.peso {
                    if (peso != 0){
                        ejConPeso += 1
                    }
                    ejTotal += 1
                }
            }
        }
        //Recorro dia viernes si existe
        if let viernes = semana.dias.viernes{
            for dia in viernes{
                if let peso = dia.peso {
                    if (peso != 0){
                        ejConPeso += 1
                    }
                    ejTotal += 1
                }
            }
        }

        return (ejTotal != 0) ? Int((Double(ejConPeso) / Double(ejTotal)) * 100) : 0
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
            cell.secondLabel.text = "\(porcCalcSemana(semana: semana))%"
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
