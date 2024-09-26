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
    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //Cell Config
        myCell.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        //Labels configs
        firstLabel.textColor = .white
        firstLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        secondLabel.textColor = .green
        secondLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        //Image Config
        myImage.layer.cornerRadius = myImage.frame.size.width / 2
        myImage.clipsToBounds = true
    }
}
