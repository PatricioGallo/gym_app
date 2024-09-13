//
//  rutinaTableViewCell.swift
//  ColeccionView
//
//  Created by Pato Gallo on 13/09/2024.
//

import UIKit

class rutinaTableViewCell: UITableViewCell {

    @IBOutlet weak var myCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myCell.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("Toque la celda")
    }
    
}
