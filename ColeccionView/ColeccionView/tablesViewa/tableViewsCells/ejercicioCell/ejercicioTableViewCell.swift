//
//  ejercicioTableViewCell.swift
//  ColeccionView
//
//  Created by Pato Gallo on 16/09/2024.
//

import UIKit

class ejercicioTableViewCell: UITableViewCell {

    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myCell: UIView!
    @IBOutlet weak var newBottomLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Cell Config
        myCell.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.0)
        //Label Config
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        middleLabel.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        middleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        middleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        bottomLabel.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        bottomLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        newBottomLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        newBottomLabel.textColor = .darkGray
        //Image Config
        myImage.layer.cornerRadius = myImage.frame.size.width / 2
        myImage.clipsToBounds = true
    }

    
}
