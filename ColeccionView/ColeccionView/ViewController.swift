import UIKit

class ViewController: UIViewController,rutinaViewCellDelegate {
//    class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var persona: Persona?
    var rutinas: [Rutina] = []
    var semanas: [Semana] = []
    var newPerson: Persona? = nil
    let myCellWidth = UIScreen.main.bounds.width
    var showView: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData() //carga a la variable persona
        if(showView){
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
            collectionView.register(UINib(nibName: "headerCell", bundle: nil), forCellWithReuseIdentifier: "hcell")
            collectionView.register(UINib(nibName: "infoViewCell", bundle: nil), forCellWithReuseIdentifier: "infoCell")
            collectionView.register(UINib(nibName: "rutinaViewCell", bundle: nil), forCellWithReuseIdentifier: "rutinaCell")
            collectionView.delegate = self
        }
        self.title = "Rutinas"
    }
    
    private func loadData(){
        
        netWorkingProvider.shared.getUser(id: 1) { (user) in
            self.newPerson = user
            self.collectionView.reloadData() // Recargar la colección
        } failure: { (error) in
            print("\(error.debugDescription) with \(String(describing: self.newPerson))")
            self.showView = false
        }
        
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch (indexPath.row){
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hcell", for: indexPath) as! headerCell
            // Desempaquetar de forma segura
            if let person = newPerson {
                cell.myLabel.text = "\(person.nombre) \(person.apellido)"
            } else {
                cell.myLabel.text = ""
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell", for: indexPath) as! infoViewCell
            if let person = newPerson {
                cell.labelTitle.text = "\(person.nombre) repasa tus ultimos pesos"
                cell.labelMid.text = "75 KG"
            } else {
                cell.labelTitle.text = ""
                cell.labelMid.text = ""
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rutinaCell", for: indexPath) as! rutinaViewCell
            if let person = newPerson {
                cell.rutinas = person.rutinas
                cell.delegate = self
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hcell", for: indexPath) as! headerCell
            // Desempaquetar de forma segura
            if let person = newPerson {
                cell.myLabel.text = "\(person.nombre) \(person.apellido)"
            } else {
                cell.myLabel.text = "No data available"
            }
            return cell

        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func didSelectRutina(semanas: [Semana]) {
        // Maneja la lógica para realizar el segue o la navegación
        performSegue(withIdentifier: "weeks_path", sender: semanas)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weeks_path",
           let semanas = sender as? [Semana],
           let destinationVC = segue.destination as? MyWeeksViewController {
            destinationVC.semanas = semanas
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if(indexPath.row == 0){
            return CGSize(width: myCellWidth, height: myCellWidth/4)
        }
        else if (indexPath.row == 1){
            return CGSize(width: myCellWidth, height: myCellWidth/2)
        }else if (indexPath.row == 2){
            return CGSize(width: myCellWidth, height: myCellWidth)
        }
        else{
            return CGSize(width: myCellWidth, height: myCellWidth/2)
        }
    }
}

