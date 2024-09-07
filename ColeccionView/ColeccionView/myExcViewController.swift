//
//  myExcViewController.swift
//  ColeccionView
//
//  Created by Pato Gallo on 04/09/2024.
//

import UIKit

class myExcViewController: UIViewController {
    var semana: [Semana] = []
    let myCellWidth = UIScreen.main.bounds.width
    @IBOutlet weak var excCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ejercicios"
        excCollection.dataSource = self
        excCollection.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        excCollection.delegate = self
    }
    


}

extension myExcViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return semana.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
        let week = semana[indexPath.row]
        cell.myLabel.text = "\(week.numero)"
        return cell
    }
}

//extension myExcViewController: UICollectionViewDelegate {
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let week = semana[indexPath.row]
////        semana = rutina.semanas
////        performSegue(withIdentifier: "ex_path", sender: self)
////    }
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        if segue.identifier == "ex_path" {
////            if let destinoVC = segue.destination as? myExcViewController {
////                destinoVC.semana = semana!
////            }
////        }
////    }
//
//}

extension myExcViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth, height: myCellWidth/2)
    }
}
