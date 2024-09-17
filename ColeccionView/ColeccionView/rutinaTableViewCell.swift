//
//  rutinaTableViewCell.swift
//  ColeccionView
//
//  Created by Pato Gallo on 13/09/2024.
//

import UIKit

class rutinaTableViewCell: UITableViewCell {

    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var myCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myCell.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        secondLabel.textColor = .green
        firstLabel.textColor = .white

        // Ajuste del tamaño y tipo de letra para una mejor estética
        firstLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        secondLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
    }
    
}
