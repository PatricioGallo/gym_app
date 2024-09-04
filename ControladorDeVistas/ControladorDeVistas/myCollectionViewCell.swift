import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configuración de la etiqueta y fondo de la vista
        myLabel.textColor = .systemYellow
        myView.backgroundColor = .black
        
        // Ajuste del tamaño y tipo de letra para una mejor estética
        myLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold) // Tamaño de letra 18, peso semibold
        
        // Hacer las esquinas redondeadas
        myView.layer.cornerRadius = 10
        myView.layer.masksToBounds = false

        // Agregar sombra
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOpacity = 0.5
        myView.layer.shadowOffset = CGSize(width: 0, height: 2)
        myView.layer.shadowRadius = 4
        
        myView.layer.shadowPath = UIBezierPath(roundedRect: myView.bounds, cornerRadius: myView.layer.cornerRadius).cgPath
    }
}


