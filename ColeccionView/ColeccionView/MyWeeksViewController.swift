//
//  MyWeeksViewController.swift
//  ColeccionView
//
//  Created by Pato Gallo on 04/09/2024.
//

import UIKit

class MyWeeksViewController: UIViewController {

    @IBOutlet weak var myWeeksViews: UICollectionView!
    let myCellWidth = UIScreen.main.bounds.width
    var semanas: [Semana]?
    var ejercicios:[Ejercicio]?
    var dias: Dias?
    
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
        return semanas!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
        cell.myLabel.text = "Semana \(semanas![indexPath.row].numero)"
        return cell
    }
}

extension MyWeeksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let semana = semanas?[indexPath.row] {
            dias = semana.dias  // Aquí se asigna un solo objeto Dias
        }
        performSegue(withIdentifier: "ex_path", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ex_path" {
            if let destinoVC = segue.destination as? myExcViewController {
                destinoVC.dias     = self.dias
            }
        }
    }

}

extension MyWeeksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth, height: myCellWidth/2)
    }
}

