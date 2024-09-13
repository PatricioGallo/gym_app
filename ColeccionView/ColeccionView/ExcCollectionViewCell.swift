//
//  ExcCollectionViewCell.swift
//  ColeccionView
//
//  Created by Pato Gallo on 09/09/2024.
//

import UIKit

class ExcCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myViewCollect: UICollectionView!
    @IBOutlet weak var myView: UIView!
    let myCellWidth = UIScreen.main.bounds.width
    var ejemplo = ["Prensa","Correr","Saltar"]
    var myLabel = ""
    var lunes: [Ejercicio]?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Hacer las esquinas redondeadas
        myView.layer.cornerRadius = 10
        myView.layer.masksToBounds = false
        myViewCollect.dataSource = self
        myViewCollect.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        myViewCollect.delegate = self
    }
}

extension ExcCollectionViewCell: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lunes!.count //esto es un ejemplo, cambiar mas adelante
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
        cell.myLabel.text = "\(lunes![indexPath.row].nombre)"
        return cell
    }
}

extension ExcCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth*2/3, height: myCellWidth/2)
    }
}
