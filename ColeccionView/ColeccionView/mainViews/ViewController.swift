import UIKit

class ViewController: UIViewController,rutinaViewCellDelegate {
    //Variables and oulets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var persona: Persona?
    var rutinas: [Rutina] = []
    var newPerson: Persona? = nil
    let myCellWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        loadData()
        self.title = "Inicio"
    }
    
    private func loadData(){
        
        netWorkingProvider.shared.getUser(id: generateData.userID) { (user) in
            DispatchQueue.main.async {
                 self.activityIndicator.stopAnimating()
                 self.newPerson = user
                 self.collectionView.dataSource = self
                 self.collectionView.delegate = self
                 self.collectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
                 self.collectionView.register(UINib(nibName: "headerCell", bundle: nil), forCellWithReuseIdentifier: "hcell")
                 self.collectionView.register(UINib(nibName: "infoViewCell", bundle: nil), forCellWithReuseIdentifier: "infoCell")
                 self.collectionView.register(UINib(nibName: "rutinaViewCell", bundle: nil), forCellWithReuseIdentifier: "rutinaCell")
                 self.collectionView.reloadData()
                generateData.newPerson = user
                }
            } failure: { (error) in
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                    print("\(error.debugDescription) with \(String(describing: self.newPerson))")
                 }
            }
    } //loadData
} //ViewController

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch (indexPath.row){
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hcell", for: indexPath) as! headerCell
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
    func didSelectRutina(path: Int) {
        performSegue(withIdentifier: "weeks_path", sender: path)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weeks_path",
           let path = sender as? Int,
           let destinationVC = segue.destination as? MyWeeksViewController {
            destinationVC.rutinaPath = path
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch(indexPath.row ){
        case 0:
            return CGSize(width: myCellWidth, height: myCellWidth/4)
        case 1:
            return CGSize(width: myCellWidth, height: myCellWidth/2)
        case 2:
            return CGSize(width: myCellWidth, height: myCellWidth)
        default:
            return CGSize(width: myCellWidth, height: myCellWidth/2)
        }
    }
}

