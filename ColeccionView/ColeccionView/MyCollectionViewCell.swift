import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configuración de la etiqueta y fondo de la vista
        myLabel.textColor = .white
        secondLabel.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0) // Gris más claro
        myView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)

        // Ajuste del tamaño y tipo de letra para una mejor estética
        myLabel.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        secondLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        // Hacer las esquinas redondeadas
        myView.layer.cornerRadius = 10
        myView.layer.masksToBounds = false

    }
}

