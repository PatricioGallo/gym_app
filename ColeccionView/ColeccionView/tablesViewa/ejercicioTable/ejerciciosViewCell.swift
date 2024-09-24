import UIKit

//Week delegate config
protocol excViewCellDelegate: AnyObject {
    func didSelectExc(path: Int, diasPath: Int)
}

class ejerciciosViewCell: UICollectionViewCell {
    //Oulets and Variables
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTable: UITableView!
    var ejercicios: [Ejercicio]?
    weak var delegate: excViewCellDelegate?
    var dia_index:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Table Config
        myTable.dataSource = self
        myTable.delegate = self
        myTable.register(UINib(nibName: "ejercicioTableViewCell", bundle: nil), forCellReuseIdentifier: "ejCell")
        myTable.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        myTable.rowHeight = UITableView.automaticDimension
        // Label Config
        myLabel.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0) // Gris claro
        myLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        // View config
        myView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        myView.layer.cornerRadius = 10
        myView.layer.masksToBounds = false
    }
    
    func has_peso(_ ejercicio: Int?) -> String {
        if let peso = ejercicio {
            return "Peso anterior: \(peso) Kg"
        } else {
            return "Sin peso"
        }
    }

}

//DATASOURCE
extension ejerciciosViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ejercicios?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ejCell", for: indexPath) as! ejercicioTableViewCell
        if let ejercicio = ejercicios?[indexPath.row] {
            cell.titleLabel.text = "\(ejercicio.nombre ?? "")"
            cell.middleLabel.text = "\(ejercicio.serie ?? 0) series x 10 \(ejercicio.repe ?? 0)"
            cell.bottomLabel.text = has_peso(ejercicio.peso)
            cell.newBottomLabel.text = "Último entrenamiento: \(ejercicio.fecha ?? "")"
        }
        return cell
    }
}

//DELEGATE
extension ejerciciosViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectExc(path: indexPath.row, diasPath: dia_index!)
    }
}

