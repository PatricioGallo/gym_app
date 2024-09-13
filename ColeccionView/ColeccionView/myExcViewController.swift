//
//  myExcViewController.swift
//  ColeccionView
//
//  Created by Pato Gallo on 04/09/2024.
//

import UIKit

class myExcViewController: UIViewController {
    var dias: Dias?
    var ejercicio: [Ejercicio]?
    let myCellWidth = UIScreen.main.bounds.width
    @IBOutlet weak var excCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ejercicios"
        excCollection.dataSource = self
        excCollection.register(UINib(nibName: "ExcCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myExCell")
        excCollection.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        excCollection.register(UINib(nibName: "infoViewCell", bundle: nil), forCellWithReuseIdentifier: "infoCell")
        excCollection.delegate = self
        
    }
    
}

extension myExcViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8 //esto es un ejemplo, cambiar mas adelante
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
                case 0:
                    // Configura la celda para la fila 1
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
                    cell.myLabel.text = "Header"
                    return cell
                case 1:
                    // Configura la celda para la fila 1
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
                    cell.myLabel.text = "Info"
                    return cell
                case 2:
                    // Configura la celda para la fila 1
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myExCell", for: indexPath) as! ExcCollectionViewCell
                        cell.lunes = dias!.lunes
                    return cell
                case 3:
                    // Configura la celda para la fila 1
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myExCell", for: indexPath) as! ExcCollectionViewCell
                        cell.lunes = dias!.martes
                    return cell
                case 4:
                    // Configura la celda para la fila 0
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myExCell", for: indexPath) as! ExcCollectionViewCell
                        cell.lunes = dias!.miercoles
                    return cell
                case 5:
                    // Configura la celda para la fila 0
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myExCell", for: indexPath) as! ExcCollectionViewCell
                        cell.lunes = dias!.jueves
                    return cell
                case 6:
                    // Configura la celda para la fila 0
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myExCell", for: indexPath) as! ExcCollectionViewCell
                        cell.lunes = dias!.viernes
                    return cell
                case 7:
                    // Configura la celda para la fila 0
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell", for: indexPath) as! infoViewCell
//                        cell.lunes = dias!.viernes
                    return cell
                default:
                    // Configura la celda para cualquier otra sección
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
                    cell.myLabel.text = "ERROR!!!"
                    return cell
                }
    }
}

extension myExcViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
                case 0:
                    return CGSize(width: myCellWidth, height: myCellWidth/2)
                case 1:
                    return CGSize(width: myCellWidth, height: myCellWidth)
                case 2:
                    return CGSize(width: myCellWidth, height: myCellWidth/2)
                case 3:
                    return CGSize(width: myCellWidth, height: myCellWidth/2)
                case 4:
                    return CGSize(width: myCellWidth, height: myCellWidth/2)
                case 5:
                    return CGSize(width: myCellWidth, height: myCellWidth/2)
                case 6:
                    return CGSize(width: myCellWidth, height: myCellWidth/2)
                case 7:
                    return CGSize(width: myCellWidth, height: myCellWidth/2)
                default:
                    return CGSize(width: myCellWidth, height: myCellWidth/2)
                }
    }
}
