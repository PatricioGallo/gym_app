import UIKit

class ejerciciosViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTable: UITableView!
    
    var ejercicios: [Ejercicio]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Fuentes
        myTable.dataSource = self
        //myTable.delegate = self
        myTable.register(UINib(nibName: "ejercicioTableViewCell", bundle: nil), forCellReuseIdentifier: "ejCell")
        
        // Atributos
        myTable.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        
        // Configuración de la etiqueta y fondo de la vista
        myLabel.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0) // Gris claro
        myView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        myLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        // Hacer las esquinas redondeadas
        myView.layer.cornerRadius = 10
        myView.layer.masksToBounds = false
        myTable.rowHeight = UITableView.automaticDimension
    }
    
    func has_peso(_ ejercicio: Int?) -> String {
        if let peso = ejercicio {
            return "Peso anterior: \(peso) Kg"
        } else {
            return "Sin peso"
        }
    }

}

extension ejerciciosViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ejercicios?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ejCell", for: indexPath) as! ejercicioTableViewCell
        if let ejercicio = ejercicios?[indexPath.row] {
            cell.titleLabel.text = "\(ejercicio.nombre ?? "")"
            cell.middleLabel.text = "4 series x 10 repeticiones"
            cell.bottomLabel.text = has_peso(ejercicio.peso)
            cell.newBottomLabel.text = "Último entrenamiento: 16.09.2024"
        }
        return cell
    }
}

