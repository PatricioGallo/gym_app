//
//  MyWeeksViewController.swift
//  ColeccionView
//
//  Created by Patricio Gallo on 04/09/2024.
//

import UIKit

class MyWeeksViewController: UIViewController, semanaViewCellDelegate {
    //OUTLETS AND VARIABLES
    @IBOutlet weak var myWeeksViews: UICollectionView!
    let myCellWidth = UIScreen.main.bounds.width
    var semanas: [Semana]?
    var ejercicios:[Ejercicio]?
    var dias: Dias?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Semanas"
        myWeeksViews.dataSource = self
        myWeeksViews.register(UINib(nibName: "semanaViewCell", bundle: nil), forCellWithReuseIdentifier: "weekTable")
        myWeeksViews.delegate = self
    }
}

//DATA SOURCE
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

//DELEGATE
extension MyWeeksViewController: UICollectionViewDelegate {
        func didSelectSemana(dias: Dias) {
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

//LAYOUT
extension MyWeeksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth, height: (myCellWidth*3/2))
    }
}

