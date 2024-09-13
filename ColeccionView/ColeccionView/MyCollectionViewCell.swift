import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configuración de la etiqueta y fondo de la vista
        myLabel.textColor = .white
        myView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0) // Gris más oscuro

        // Ajuste del tamaño y tipo de letra para una mejor estética
        myLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold) // Tamaño de letra 18, peso semibold
        
        // Hacer las esquinas redondeadas
        myView.layer.cornerRadius = 10
        myView.layer.masksToBounds = false

    }
}

