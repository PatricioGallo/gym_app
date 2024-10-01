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
    var newPeso:Bool = false
    
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
        //Logica del peso anterior
    }
    
    func has_peso(_ peso: Int?) -> String {
        if let peso_deco = peso {
            if (peso_deco == 0){
                return ""
            }
            newPeso = true
            return ", actual: \(peso_deco) Kg"
        } else {
            return ""
        }
    }
    
    func has_peso_anterior(_ peso_anterior: Int?) -> String {
        if let peso = peso_anterior {
            return "Peso anterior: \(peso) Kg"
        } else {
            return "Sin peso"
        }
    }
    
    func peso_anterior (_ index: Int?) -> String{
        let array = generateData.newPerson?.historial
        var flag = 0
        for elemento in array!.reversed(){
            if( newPeso == false){
                if (elemento.id_exc == index){
                    return "Peso anterior: \(elemento.peso ?? 0) Kg"
                }
            }
            if (elemento.id_exc == index){
                flag = flag + 1
            }
            if(flag == 2){
                return "Peso anterior: \(elemento.peso ?? 0) Kg"
            }
        }
        return "Sin peso anterior"
    }
    
    func fecha_anterior (_ index: Int?) -> String{
        let array = generateData.newPerson?.historial
        for elemento in array!.reversed(){
            if (elemento.id_exc == index){
                return "Ultimo entrenamiento: \(elemento.fecha ?? "")"
            }
        }
        return ""
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
            cell.middleLabel.text = "\(ejercicio.serie ?? 0) series x \(ejercicio.repe ?? 0) repes"
            cell.bottomLabel.text = peso_anterior(ejercicio.id_exc)
            cell.secondBottomLabel.text = has_peso(ejercicio.peso)
            cell.newBottomLabel.text = fecha_anterior(ejercicio.id_exc)
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

