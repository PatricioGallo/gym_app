//
//  myExcViewController.swift
//  ColeccionView
//
//  Created by Patricio Gallo on 04/09/2024.
//

import UIKit

class myExcViewController: UIViewController {
    //OUTLETS AND VIEWS
    var dias: Dias?
    var ejercicio: [Ejercicio]?
    let myCellWidth = UIScreen.main.bounds.width
    @IBOutlet weak var excCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ejercicios"
        excCollection.dataSource = self
        excCollection.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        excCollection.register(UINib(nibName: "ejerciciosViewCell", bundle: nil), forCellWithReuseIdentifier: "exViewCell")
        excCollection.delegate = self
    }
}

//DATASOURCE
extension myExcViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
                case 0:
                    // Configura la celda para la fila 1
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
                    cell.myLabel.text = "Info"
                    cell.secondLabel.text = "Recorda anotar todos los pesos que hiciste en el dia y calificar el ejericio, para un mejor seguimiento."
                    return cell
                case 1:
                    // Configura la celda para la fila 2
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exViewCell", for: indexPath) as! ejerciciosViewCell
                    cell.myLabel.text = "Lunes"
                    cell.ejercicios = dias?.lunes
                    return cell
                case 2:
                    // Configura la celda para la fila 3
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exViewCell", for: indexPath) as! ejerciciosViewCell
                    cell.myLabel.text = "Martes"
                    cell.ejercicios = dias?.martes
                    return cell
                case 3:
                    // Configura la celda para la fila 4
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exViewCell", for: indexPath) as! ejerciciosViewCell
                    cell.myLabel.text = "Miercoles"
                    cell.ejercicios = dias?.miercoles
                    return cell
                case 4:
                    // Configura la celda para la fila 5
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exViewCell", for: indexPath) as! ejerciciosViewCell
                    cell.myLabel.text = "Jueves"
                    cell.ejercicios = dias?.miercoles
                    return cell
                case 5:
                    // Configura la celda para la fila 6
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exViewCell", for: indexPath) as! ejerciciosViewCell
                    cell.myLabel.text = "Viernes"
                    cell.ejercicios = dias?.miercoles
                    return cell
                default:
                    // Configura la celda para cualquier otra sección
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
                    cell.myLabel.text = "ERROR!!!"
                    return cell
                }
    }
}

//DELEGATE
extension myExcViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
                case 0:
                    return CGSize(width: myCellWidth, height: myCellWidth/3)
                case 1:
                    return CGSize(width: myCellWidth, height: myCellWidth*3/2)
                case 2:
                    return CGSize(width: myCellWidth, height: myCellWidth*3/2)
                case 3:
                    return CGSize(width: myCellWidth, height: myCellWidth*3/2)
                case 4:
                    return CGSize(width: myCellWidth, height: myCellWidth*3/2)
                case 5:
                    return CGSize(width: myCellWidth, height: myCellWidth*3/2)
                default:
                    return CGSize(width: myCellWidth, height: myCellWidth)
                }
    }
}
