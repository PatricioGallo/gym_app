//
//  infoViewCell.swift
//  ColeccionView
//
//  Created by Pato Gallo on 13/09/2024.
//

import UIKit

class infoViewCell: UICollectionViewCell {

    @IBOutlet weak var labelMid: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Configuración de la etiqueta y fondo de la vista
        labelTitle.textColor = .darkGray
        labelMid.textColor = .white
        myView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0) // Gris más oscuro

        // Ajuste del tamaño y tipo de letra para una mejor estética
        labelMid.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        labelTitle.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        // Hacer las esquinas redondeadas
        myView.layer.cornerRadius = 10
        myView.layer.masksToBounds = false

    }

}
