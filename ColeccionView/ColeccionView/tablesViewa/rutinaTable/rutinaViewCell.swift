import UIKit

protocol rutinaViewCellDelegate: AnyObject {
    func didSelectRutina(semanas: [Semana])
}

class rutinaViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var myView: UIView!
    
    var rutinas: [Rutina]? {
        didSet {
            myTable.reloadData()  // Recargar la tabla cuando se asignen nuevas rutinas
        }
    }
    
    weak var delegate: rutinaViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Fuentes
        myTable.dataSource = self
        myTable.delegate = self
        myTable.register(UINib(nibName: "rutinaTableViewCell", bundle: nil), forCellReuseIdentifier: "rutCell")
        
        // Atributos
        myTable.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        
        // Configuración de la etiqueta y fondo de la vista
        titleLabel.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0) // Gris más claro
        myView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        // Hacer las esquinas redondeadas
        myView.layer.cornerRadius = 10
        myView.layer.masksToBounds = false
    }
    
    func porcCalcRutina(rutina:Rutina) -> String{
        var ejConPeso = 0;
        var ejTotal = 0;
        var ejNil = 0;
        //Recorro las semanas
        for semana in rutina.semanas {
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
        }
        
        if(ejTotal == 0 && ejNil > 0 ){
            return ""
        } else{
            return "\((ejTotal != 0) ? Int(ejConPeso / ejTotal * 100) : 0) %"
        }
        
    }//Fin porcCalcRutina
}

extension rutinaViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rutinas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rutCell", for: indexPath) as! rutinaTableViewCell
        if let rutina = rutinas?[indexPath.row] {
            cell.firstLabel.text = rutina.nombre
            cell.secondLabel.text = porcCalcRutina(rutina: rutina)
        }
        return cell
    }
}

extension rutinaViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let semanas = rutinas?[indexPath.row].semanas {
            delegate?.didSelectRutina(semanas: semanas)
        }
    }
}

