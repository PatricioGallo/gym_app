//
//  MyWeeksViewController.swift
//  ColeccionView
//
//  Created by Pato Gallo on 04/09/2024.
//

import UIKit

class MyWeeksViewController: UIViewController {

    @IBOutlet weak var myWeeksViews: UICollectionView!
    var persona: Persona? // Propiedad para recibir la persona seleccionada
    let myCellWidth = UIScreen.main.bounds.width
    var rutinas: [Rutina] = []
    var semana: [Semana]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Semanas"
        myWeeksViews.dataSource = self
        myWeeksViews.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        myWeeksViews.delegate = self
    }
    
}

extension MyWeeksViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rutinas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
        let rutina = rutinas[indexPath.row]
        semana = rutina.semanas
        cell.myLabel.text = "\(rutina.nombre)"
        return cell
    }
}

extension MyWeeksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rutina = rutinas[indexPath.row]
        semana = rutina.semanas
        performSegue(withIdentifier: "ex_path", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ex_path" {
            if let destinoVC = segue.destination as? myExcViewController {
                destinoVC.semana = semana!
            }
        }
    }

}

extension MyWeeksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth, height: myCellWidth/2)
    }
}

