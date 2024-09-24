////
////  MyWeeksViewController.swift
////  ColeccionView
////
////  Created by Patricio Gallo on 04/09/2024.
////
//
import UIKit

class MyWeeksViewController: UIViewController, semanaViewCellDelegate {

    //OUTLETS AND VARIABLES
    @IBOutlet weak var myWeeksViews: UICollectionView!
    let myCellWidth = UIScreen.main.bounds.width
    var semanas: [Semana]?
    var ejercicios:[Ejercicio]?
    var dias: [Dias]?
    var rutinaPath: Int?
    var rutina:Rutina?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Semanas"
        loadWeek(path: rutinaPath)
        myWeeksViews.dataSource = self
        myWeeksViews.register(UINib(nibName: "semanaViewCell", bundle: nil), forCellWithReuseIdentifier: "weekTable")
        myWeeksViews.delegate = self
    }
    func loadWeek(path: Int?){
        if let deco_path = path{
            rutina = generateData.newPerson?.rutinas[deco_path]
            semanas = rutina?.semanas
            self.myWeeksViews.reloadData()
        }
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
    func didSelectSemana(path: Int) {
            performSegue(withIdentifier: "ex_path", sender: path)
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ex_path",
               let path = sender as? Int,
               let destinationVC = segue.destination as? myExcViewController {
                destinationVC.semanaPath = path
                destinationVC.rutinaPath = rutinaPath
            }
        }
}

//LAYOUT
extension MyWeeksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth, height: (myCellWidth*3/2))
    }
}

