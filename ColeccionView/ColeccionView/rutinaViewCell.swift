import UIKit

class rutinaViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var myView: UIView!
    var rutinas:[Rutina]?
    var semanas:[Semana]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Souces
        myTable.dataSource = self
        myTable.delegate = self
        myTable.register(UINib(nibName: "rutinaTableViewCell", bundle: nil), forCellReuseIdentifier: "rutCell")
        //Atributos
        myTable.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        // Configuración de la etiqueta y fondo de la vista
        titleLabel.textColor = .darkGray
        myView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0) // Gris más oscuro
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        // Hacer las esquinas redondeadas
        myView.layer.cornerRadius = 10
        myView.layer.masksToBounds = false

    }
}

extension rutinaViewCell: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rutinas!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rutCell", for: indexPath) as! rutinaTableViewCell
        cell.firstLabel.text = "\(rutinas![indexPath.row].nombre)"
        cell.secondLabel.text = "30%"
        return cell
    }
    
}

extension rutinaViewCell: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        semanas = rutinas![indexPath.row].semanas
//        performSegue(withIdentifier: "weeks_path", sender: self)
    }
    
}
