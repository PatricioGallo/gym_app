import UIKit

struct Ejercicio: Codable {
    let nombre: String
}

struct Semana: Codable {
    let numero: Int
    let ejercicios: [String]
}

struct Rutina: Codable {
    let nombre: String
    let semanas: [Semana]
}

struct Persona: Codable {
    let nombre: String
    let apellido: String
    let edad: Int
    let mail: String
    let contrasena: String
    let rutinas: [Rutina]
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var personas: [Persona] = []
    var persona_2: Persona?
    let myCellWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        collectionView.delegate = self
        self.title = "Rutinas"
        loadData()
    }
    
    private func loadData() {
        let jsonString = """
        [
            {
                "nombre": "Juan",
                "apellido": "Pérez",
                "edad": 30,
                "mail": "juan.perez@example.com",
                "contrasena": "123456",
                "rutinas": [
                    {
                        "nombre": "Rutina Cardio",
                        "semanas": [
                            {
                                "numero": 1,
                                "ejercicios": [
                                    "Correr 30 minutos",
                                    "Saltar la cuerda 15 minutos"
                                ]
                            },
                            {
                                "numero": 2,
                                "ejercicios": [
                                    "Ciclismo 45 minutos",
                                    "Saltar la cuerda 20 minutos"
                                ]
                            }
                        ]
                    },
                    {
                        "nombre": "Rutina Fuerza",
                        "semanas": [
                            {
                                "numero": 1,
                                "ejercicios": [
                                    "Sentadillas 3x12",
                                    "Flexiones 3x15"
                                ]
                            }
                        ]
                    }
                ]
            },
            {
                "nombre": "Ana",
                "apellido": "Gómez",
                "edad": 28,
                "mail": "ana.gomez@example.com",
                "contrasena": "abcdef",
                "rutinas": [
                    {
                        "nombre": "Rutina Full Body",
                        "semanas": [
                            {
                                "numero": 1,
                                "ejercicios": [
                                    "Burpees 3x10",
                                    "Plancha 3x1 minuto"
                                ]
                            }
                        ]
                    }
                ]
            },
            {
                "nombre": "Carlos",
                "apellido": "Martínez",
                "edad": 35,
                "mail": "carlos.martinez@example.com",
                "contrasena": "654321",
                "rutinas": [
                    {
                        "nombre": "Rutina Abdominales",
                        "semanas": [
                            {
                                "numero": 1,
                                "ejercicios": [
                                    "Crunches 3x15",
                                    "Elevación de piernas 3x12"
                                ]
                            }
                        ]
                    }
                ]
            },
            {
                "nombre": "Laura",
                "apellido": "Rodríguez",
                "edad": 27,
                "mail": "laura.rodriguez@example.com",
                "contrasena": "password",
                "rutinas": [
                    {
                        "nombre": "Rutina Yoga",
                        "semanas": [
                            {
                                "numero": 1,
                                "ejercicios": [
                                    "Postura del perro 3x1 minuto",
                                    "Postura del niño 3x1 minuto"
                                ]
                            }
                        ]
                    }
                ]
            },
            {
                "nombre": "Pedro",
                "apellido": "García",
                "edad": 40,
                "mail": "pedro.garcia@example.com",
                "contrasena": "qwerty",
                "rutinas": [
                    {
                        "nombre": "Rutina Flexibilidad",
                        "semanas": [
                            {
                                "numero": 1,
                                "ejercicios": [
                                    "Estiramiento de piernas 3x30 segundos",
                                    "Estiramiento de espalda 3x30 segundos"
                                ]
                            }
                        ]
                    }
                ]
            }
        ]
        """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Error al convertir la cadena JSON a Data")
            return
        }
        
        do {
            personas = try JSONDecoder().decode([Persona].self, from: jsonData)
            collectionView.reloadData()
        } catch {
            print("Error al decodificar el JSON: \(error)")
        }
    }
    
    
}

extension ViewController:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCollectionViewCell
        let persona = personas[indexPath.row]
        cell.myLabel.text = "\(persona.nombre) \(persona.apellido) - \(persona.edad) años"
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let persona = personas[indexPath.row]
        persona_2 = persona
        print("\(indexPath.section) \(indexPath.row) \(persona.nombre) \(persona.apellido) - \(persona.edad) años")
        // Imprime más información si lo necesitas
        performSegue(withIdentifier: "weeks_path", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weeks_path" {
            if let destinoVC = segue.destination as? MyWeeksViewController {
//                if let personaSeleccionada = sender as? Persona {
//                    // Asignar la persona seleccionada a la vista destino
//                    destinoVC.persona = personaSeleccionada
//                }
                destinoVC.persona = persona_2
            }
        }
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCellWidth, height: myCellWidth/2)
    }
}

