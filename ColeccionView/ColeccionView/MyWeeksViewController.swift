//
//  MyWeeksViewController.swift
//  ColeccionView
//
//  Created by Pato Gallo on 04/09/2024.
//

import UIKit

class MyWeeksViewController: UIViewController, semanaViewCellDelegate {

    @IBOutlet weak var myWeeksViews: UICollectionView!
    let myCellWidth = UIScreen.main.bounds.width
    var semanas: [Semana]?
    var ejercicios:[Ejercicio]?
    var dias: Dias?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Semanas"
        myWeeksViews.dataSource = self
//        myWeeksViews.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        myWeeksViews.register(UINib(nibName: "semanaViewCell", bundle: nil), forCellWithReuseIdentifier: "weekTable")
        myWeeksViews.delegate = self
    }
}

extension MyWeeksViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekTable", for: indexPath) as! semanaViewCell
        cell.myLabel.text = "Eleji la semana de tu rutina"
        cell.semanas = semanas!
        cell.delegate = self
        return cell
        
    }
}

extension MyWeeksViewController: UICollectionViewDelegate {
        func didSelectSemana(dias: Dias) {
            // Maneja la lógica para realizar el segue o la navegación
            performSegue(withIdentifier: "ex_path", sender: dias)
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ex_path",
               let dias = sender as? Dias,
               let destinationVC = segue.destination as? myExcViewController {
                destinationVC.dias = dias
            }
        }

}

extension MyWeeksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth, height: (myCellWidth*3/2))
    }
}

