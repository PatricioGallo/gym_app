import UIKit

struct Ejercicio: Codable {
    let nombre: String
    let peso: Int?
}

struct Dias: Codable {
    let lunes: [Ejercicio]
    let martes: [Ejercicio]
    let miercoles: [Ejercicio]
    let jueves: [Ejercicio]
    let viernes: [Ejercicio]
}

struct Semana: Codable {
    let numero: Int
    let dias: Dias
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

class ViewController: UIViewController,rutinaViewCellDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var persona: Persona?
    var rutinas: [Rutina] = []
    var semanas: [Semana] = []
    let myCellWidth = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        collectionView.register(UINib(nibName: "headerCell", bundle: nil), forCellWithReuseIdentifier: "hcell")
        collectionView.register(UINib(nibName: "infoViewCell", bundle: nil), forCellWithReuseIdentifier: "infoCell")
        collectionView.register(UINib(nibName: "rutinaViewCell", bundle: nil), forCellWithReuseIdentifier: "rutinaCell")
        collectionView.delegate = self
        self.title = "Rutinas"
        loadData() //carga a la variable persona
    }
    
    private func loadData() {
        // JSON para una sola persona
        let jsonString = """
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
                            "dias": {
                                "lunes": [
                                    {"nombre": "Correr 30 minutos"},
                                    {"nombre": "Burpees 3x15"},
                                    {"nombre": "Mountain Climbers 3x20"},
                                    {"nombre": "Jumping Jacks 3x30"},
                                    {"nombre": "Saltar la cuerda 15 minutos"}
                                ],
                                "martes": [
                                    {"nombre": "Trote suave 20 minutos"},
                                    {"nombre": "Subir escaleras 10 minutos"},
                                    {"nombre": "Sprint 5x30 segundos"},
                                    {"nombre": "Estocadas 3x15 por pierna"},
                                    {"nombre": "Saltos de tijera 3x20"}
                                ],
                                "miercoles": [
                                    {"nombre": "Ciclismo 45 minutos"},
                                    {"nombre": "Burpees 4x15"},
                                    {"nombre": "Plancha 3x1 minuto"},
                                    {"nombre": "Mountain Climbers 4x25"},
                                    {"nombre": "Saltar la cuerda 20 minutos"}
                                ],
                                "jueves": [
                                    {"nombre": "Correr 5 km"},
                                    {"nombre": "Trote suave 25 minutos"},
                                    {"nombre": "Subir cuestas 15 minutos"},
                                    {"nombre": "Sprint intermitente 20 minutos"},
                                    {"nombre": "Jumping Jacks 4x30"}
                                ],
                                "viernes": [
                                    {"nombre": "Ciclismo 30 minutos"},
                                    {"nombre": "Burpees 3x20"},
                                    {"nombre": "Saltar la cuerda 25 minutos"},
                                    {"nombre": "Mountain Climbers 4x30"},
                                    {"nombre": "Flexiones explosivas 3x15"}
                                ]
                            }
                        },
                        {
                            "numero": 2,
                            "dias": {
                                "lunes": [
                                    {"nombre": "Correr 6 km"},
                                    {"nombre": "Saltar la cuerda 30 minutos"},
                                    {"nombre": "Plancha lateral 3x1 minuto"},
                                    {"nombre": "Estocadas 4x15 por pierna"},
                                    {"nombre": "Mountain Climbers 4x20"}
                                ],
                                "martes": [
                                    {"nombre": "Burpees 4x20"},
                                    {"nombre": "Trote suave 30 minutos"},
                                    {"nombre": "Saltos en caja 4x12"},
                                    {"nombre": "Flexiones 4x15"},
                                    {"nombre": "Ciclismo 60 minutos"}
                                ],
                                "miercoles": [
                                    {"nombre": "Sprint 6x30 segundos"},
                                    {"nombre": "Correr 7 km"},
                                    {"nombre": "Subir escaleras 15 minutos"},
                                    {"nombre": "Saltar la cuerda 25 minutos"},
                                    {"nombre": "Mountain Climbers 4x25"}
                                ],
                                "jueves": [
                                    {"nombre": "Ciclismo 45 minutos"},
                                    {"nombre": "Burpees 5x20"},
                                    {"nombre": "Sprint con resistencia 5x1 minuto"},
                                    {"nombre": "Estocadas 4x12"},
                                    {"nombre": "Jumping Jacks 5x30"}
                                ],
                                "viernes": [
                                    {"nombre": "Trote con cambios de ritmo 30 minutos"},
                                    {"nombre": "Saltos laterales 4x20"},
                                    {"nombre": "Flexiones con aplauso 4x12"},
                                    {"nombre": "Burpees 4x25"},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ]
                            }
                        },
                        {
                            "numero": 3,
                            "dias": {
                                "lunes": [
                                    {"nombre": "Correr 7 km"},
                                    {"nombre": "Burpees 4x25"},
                                    {"nombre": "Mountain Climbers 4x30"},
                                    {"nombre": "Jumping Jacks 4x40"},
                                    {"nombre": "Saltar la cuerda 30 minutos"}
                                ],
                                "martes": [
                                    {"nombre": "Trote suave 40 minutos"},
                                    {"nombre": "Subir escaleras 15 minutos"},
                                    {"nombre": "Sprint 6x40 segundos"},
                                    {"nombre": "Estocadas 4x20 por pierna"},
                                    {"nombre": "Saltos de tijera 4x30"}
                                ],
                                "miercoles": [
                                    {"nombre": "Ciclismo 60 minutos"},
                                    {"nombre": "Burpees 5x20"},
                                    {"nombre": "Plancha 4x1 minuto"},
                                    {"nombre": "Mountain Climbers 5x30"},
                                    {"nombre": "Saltar la cuerda 25 minutos"}
                                ],
                                "jueves": [
                                    {"nombre": "Correr 8 km"},
                                    {"nombre": "Trote suave 30 minutos"},
                                    {"nombre": "Subir cuestas 20 minutos"},
                                    {"nombre": "Sprint intermitente 30 minutos"},
                                    {"nombre": "Jumping Jacks 5x40"}
                                ],
                                "viernes": [
                                    {"nombre": "Ciclismo 45 minutos"},
                                    {"nombre": "Burpees 4x30"},
                                    {"nombre": "Saltar la cuerda 30 minutos"},
                                    {"nombre": "Mountain Climbers 5x30"},
                                    {"nombre": "Flexiones explosivas 4x20"}
                                ]
                            }
                        },
                        {
                            "numero": 4,
                            "dias": {
                                "lunes": [
                                    {"nombre": "Correr 9 km"},
                                    {"nombre": "Saltar la cuerda 35 minutos"},
                                    {"nombre": "Plancha lateral 4x1 minuto"},
                                    {"nombre": "Estocadas 5x15 por pierna"},
                                    {"nombre": "Mountain Climbers 5x20"}
                                ],
                                "martes": [
                                    {"nombre": "Burpees 5x25"},
                                    {"nombre": "Trote suave 45 minutos"},
                                    {"nombre": "Saltos en caja 5x15"},
                                    {"nombre": "Flexiones 5x15"},
                                    {"nombre": "Ciclismo 75 minutos"}
                                ],
                                "miercoles": [
                                    {"nombre": "Sprint 7x30 segundos"},
                                    {"nombre": "Correr 10 km"},
                                    {"nombre": "Subir escaleras 20 minutos"},
                                    {"nombre": "Saltar la cuerda 30 minutos"},
                                    {"nombre": "Mountain Climbers 5x25"}
                                ],
                                "jueves": [
                                    {"nombre": "Ciclismo 60 minutos"},
                                    {"nombre": "Burpees 5x30"},
                                    {"nombre": "Sprint con resistencia 6x1 minuto"},
                                    {"nombre": "Estocadas 5x12"},
                                    {"nombre": "Jumping Jacks 6x30"}
                                ],
                                "viernes": [
                                    {"nombre": "Trote con cambios de ritmo 40 minutos"},
                                    {"nombre": "Saltos laterales 5x25"},
                                    {"nombre": "Flexiones con aplauso 5x12"},
                                    {"nombre": "Burpees 5x25"},
                                    {"nombre": "Plancha 5x1 minuto"}
                                ]
                            }
                        }
                    ]
                },
                {
                    "nombre": "Rutina Fuerza",
                    "semanas": [
                        {
                            "numero": 1,
                            "dias": {
                                "lunes": [
                                    {"nombre": "Sentadillas 4x12", "peso": 60},
                                    {"nombre": "Peso muerto 4x10", "peso": 80},
                                    {"nombre": "Press banca 4x8", "peso": 70},
                                    {"nombre": "Remo con mancuernas 4x12", "peso": 40},
                                    {"nombre": "Dominadas 3x8"}
                                ],
                                "martes": [
                                    {"nombre": "Zancadas 4x12 por pierna", "peso": 20},
                                    {"nombre": "Curl de bíceps 4x10", "peso": 15},
                                    {"nombre": "Press militar 4x10", "peso": 30},
                                    {"nombre": "Plancha 3x1 minuto"},
                                    {"nombre": "Peso muerto sumo 4x10", "peso": 85}
                                ],
                                "miercoles": [
                                    {"nombre": "Sentadillas con salto 4x12"},
                                    {"nombre": "Press banca inclinado 4x8", "peso": 75},
                                    {"nombre": "Dominadas asistidas 3x10"},
                                    {"nombre": "Zancadas con salto 4x10 por pierna"},
                                    {"nombre": "Curl martillo 4x12", "peso": 20}
                                ],
                                "jueves": [
                                    {"nombre": "Peso muerto rumano 4x10", "peso": 85},
                                    {"nombre": "Press militar con barra 4x10", "peso": 40},
                                    {"nombre": "Sentadillas 5x10", "peso": 70},
                                    {"nombre": "Plancha lateral 3x1 minuto por lado"},
                                    {"nombre": "Flexiones de triceps 4x12", "peso": 25}
                                ],
                                "viernes": [
                                    {"nombre": "Dominadas 4x10"},
                                    {"nombre": "Press de pecho 4x10", "peso": 65},
                                    {"nombre": "Remo con barra 4x12", "peso": 60},
                                    {"nombre": "Peso muerto convencional 4x12", "peso": 90},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ]
                            }
                        },
                        {
                            "numero": 2,
                            "dias": {
                                "lunes": [
                                    {"nombre": "Sentadillas 4x12", "peso": 65},
                                    {"nombre": "Peso muerto 4x10", "peso": 85},
                                    {"nombre": "Press banca 4x8", "peso": 75},
                                    {"nombre": "Remo con mancuernas 4x12", "peso": 45},
                                    {"nombre": "Dominadas 3x10"}
                                ],
                                "martes": [
                                    {"nombre": "Zancadas 4x12 por pierna", "peso": 25},
                                    {"nombre": "Curl de bíceps 4x10", "peso": 20},
                                    {"nombre": "Press militar 4x10", "peso": 35},
                                    {"nombre": "Plancha 3x1 minuto"},
                                    {"nombre": "Peso muerto sumo 4x10", "peso": 90}
                                ],
                                "miercoles": [
                                    {"nombre": "Sentadillas con salto 4x12"},
                                    {"nombre": "Press banca inclinado 4x8", "peso": 80},
                                    {"nombre": "Dominadas asistidas 3x12"},
                                    {"nombre": "Zancadas con salto 4x10 por pierna"},
                                    {"nombre": "Curl martillo 4x12", "peso": 25}
                                ],
                                "jueves": [
                                    {"nombre": "Peso muerto rumano 4x10", "peso": 90},
                                    {"nombre": "Press militar con barra 4x10", "peso": 45},
                                    {"nombre": "Sentadillas 5x10", "peso": 75},
                                    {"nombre": "Plancha lateral 3x1 minuto por lado"},
                                    {"nombre": "Flexiones de triceps 4x12", "peso": 30}
                                ],
                                "viernes": [
                                    {"nombre": "Dominadas 4x12"},
                                    {"nombre": "Press de pecho 4x10", "peso": 70},
                                    {"nombre": "Remo con barra 4x12", "peso": 65},
                                    {"nombre": "Peso muerto convencional 4x12", "peso": 95},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ]
                            }
                        },
                        {
                            "numero": 3,
                            "dias": {
                                "lunes": [
                                    {"nombre": "Sentadillas 4x12", "peso": 70},
                                    {"nombre": "Peso muerto 4x10", "peso": 90},
                                    {"nombre": "Press banca 4x8", "peso": 80},
                                    {"nombre": "Remo con mancuernas 4x12", "peso": 50},
                                    {"nombre": "Dominadas 3x12"}
                                ],
                                "martes": [
                                    {"nombre": "Zancadas 4x12 por pierna", "peso": 30},
                                    {"nombre": "Curl de bíceps 4x10", "peso": 25},
                                    {"nombre": "Press militar 4x10", "peso": 40},
                                    {"nombre": "Plancha 3x1 minuto"},
                                    {"nombre": "Peso muerto sumo 4x10", "peso": 95}
                                ],
                                "miercoles": [
                                    {"nombre": "Sentadillas con salto 4x12"},
                                    {"nombre": "Press banca inclinado 4x8", "peso": 85},
                                    {"nombre": "Dominadas asistidas 3x15"},
                                    {"nombre": "Zancadas con salto 4x10 por pierna"},
                                    {"nombre": "Curl martillo 4x12", "peso": 30}
                                ],
                                "jueves": [
                                    {"nombre": "Peso muerto rumano 4x10", "peso": 95},
                                    {"nombre": "Press militar con barra 4x10", "peso": 50},
                                    {"nombre": "Sentadillas 5x10", "peso": 80},
                                    {"nombre": "Plancha lateral 3x1 minuto por lado"},
                                    {"nombre": "Flexiones de triceps 4x12", "peso": 35}
                                ],
                                "viernes": [
                                    {"nombre": "Dominadas 4x15"},
                                    {"nombre": "Press de pecho 4x10", "peso": 75},
                                    {"nombre": "Remo con barra 4x12", "peso": 70},
                                    {"nombre": "Peso muerto convencional 4x12", "peso": 100},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ]
                            }
                        },
                        {
                            "numero": 4,
                            "dias": {
                                "lunes": [
                                    {"nombre": "Sentadillas 4x12", "peso": 75},
                                    {"nombre": "Peso muerto 4x10", "peso": 95},
                                    {"nombre": "Press banca 4x8", "peso": 85},
                                    {"nombre": "Remo con mancuernas 4x12", "peso": 55},
                                    {"nombre": "Dominadas 3x15"}
                                ],
                                "martes": [
                                    {"nombre": "Zancadas 4x12 por pierna", "peso": 35},
                                    {"nombre": "Curl de bíceps 4x10", "peso": 30},
                                    {"nombre": "Press militar 4x10", "peso": 45},
                                    {"nombre": "Plancha 3x1 minuto"},
                                    {"nombre": "Peso muerto sumo 4x10", "peso": 100}
                                ],
                                "miercoles": [
                                    {"nombre": "Sentadillas con salto 4x12"},
                                    {"nombre": "Press banca inclinado 4x8", "peso": 90},
                                    {"nombre": "Dominadas asistidas 3x15"},
                                    {"nombre": "Zancadas con salto 4x10 por pierna"},
                                    {"nombre": "Curl martillo 4x12", "peso": 35}
                                ],
                                "jueves": [
                                    {"nombre": "Peso muerto rumano 4x10", "peso": 100},
                                    {"nombre": "Press militar con barra 4x10", "peso": 55},
                                    {"nombre": "Sentadillas 5x10", "peso": 85},
                                    {"nombre": "Plancha lateral 3x1 minuto por lado"},
                                    {"nombre": "Flexiones de triceps 4x12", "peso": 40}
                                ],
                                "viernes": [
                                    {"nombre": "Dominadas 4x15"},
                                    {"nombre": "Press de pecho 4x10", "peso": 80},
                                    {"nombre": "Remo con barra 4x12", "peso": 75},
                                    {"nombre": "Peso muerto convencional 4x12", "peso": 105},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ]
                            }
                        }
                    ]
                },
                {
                    "nombre": "Rutina Hipertrofia",
                    "semanas": [
                        {
                            "numero": 1,
                            "dias": {
                                "lunes": [
                                    {"nombre": "Press banca 4x10", "peso": 60},
                                    {"nombre": "Press inclinado con mancuernas 4x12", "peso": 40},
                                    {"nombre": "Aperturas planas 4x15", "peso": 20},
                                    {"nombre": "Flexiones 4x20"},
                                    {"nombre": "Plancha 3x1 minuto"}
                                ],
                                "martes": [
                                    {"nombre": "Sentadillas 4x12", "peso": 60},
                                    {"nombre": "Peso muerto 4x10", "peso": 80},
                                    {"nombre": "Zancadas 4x12", "peso": 30},
                                    {"nombre": "Extensiones de pierna 4x15", "peso": 50},
                                    {"nombre": "Elevación de talones 4x20", "peso": 30}
                                ],
                                "miercoles": [
                                    {"nombre": "Dominadas 4x8"},
                                    {"nombre": "Remo con barra 4x10", "peso": 70},
                                    {"nombre": "Jalón al pecho 4x12", "peso": 60},
                                    {"nombre": "Peso muerto 4x10", "peso": 80},
                                    {"nombre": "Plancha lateral 3x1 minuto"}
                                ],
                                "jueves": [
                                    {"nombre": "Press militar 4x10", "peso": 40},
                                    {"nombre": "Elevaciones laterales 4x12", "peso": 15},
                                    {"nombre": "Remo con barra 4x10", "peso": 50},
                                    {"nombre": "Press con mancuernas 4x12", "peso": 30},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ],
                                "viernes": [
                                    {"nombre": "Curl de bíceps 4x12", "peso": 20},
                                    {"nombre": "Curl martillo 4x15", "peso": 25},
                                    {"nombre": "Extensiones de tríceps 4x12", "peso": 25},
                                    {"nombre": "Fondos 4x15"},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ]
                            }
                        },
                        {
                            "numero": 2,
                            "dias": {
                                "lunes": [
                                    {"nombre": "Press banca 4x10", "peso": 65},
                                    {"nombre": "Press inclinado con mancuernas 4x12", "peso": 45},
                                    {"nombre": "Aperturas planas 4x15", "peso": 25},
                                    {"nombre": "Flexiones 4x25"},
                                    {"nombre": "Plancha 3x1 minuto"}
                                ],
                                "martes": [
                                    {"nombre": "Sentadillas 4x12", "peso": 65},
                                    {"nombre": "Peso muerto 4x10", "peso": 85},
                                    {"nombre": "Zancadas 4x12", "peso": 35},
                                    {"nombre": "Extensiones de pierna 4x15", "peso": 55},
                                    {"nombre": "Elevación de talones 4x25", "peso": 35}
                                ],
                                "miercoles": [
                                    {"nombre": "Dominadas 4x10"},
                                    {"nombre": "Remo con barra 4x12", "peso": 75},
                                    {"nombre": "Jalón al pecho 4x15", "peso": 65},
                                    {"nombre": "Peso muerto 4x12", "peso": 85},
                                    {"nombre": "Plancha lateral 3x1 minuto"}
                                ],
                                "jueves": [
                                    {"nombre": "Press militar 4x10", "peso": 45},
                                    {"nombre": "Elevaciones laterales 4x15", "peso": 20},
                                    {"nombre": "Remo con barra 4x12", "peso": 55},
                                    {"nombre": "Press con mancuernas 4x15", "peso": 35},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ],
                                "viernes": [
                                    {"nombre": "Curl de bíceps 4x15", "peso": 25},
                                    {"nombre": "Curl martillo 4x20", "peso": 30},
                                    {"nombre": "Extensiones de tríceps 4x15", "peso": 30},
                                    {"nombre": "Fondos 4x20"},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ]
                            }
                        },
                        {
                            "numero": 3,
                            "dias": {
                                "lunes": [
                                    {"nombre": "Press banca 4x10", "peso": 70},
                                    {"nombre": "Press inclinado con mancuernas 4x12", "peso": 50},
                                    {"nombre": "Aperturas planas 4x15", "peso": 30},
                                    {"nombre": "Flexiones 4x30"},
                                    {"nombre": "Plancha 3x1 minuto"}
                                ],
                                "martes": [
                                    {"nombre": "Sentadillas 4x12", "peso": 70},
                                    {"nombre": "Peso muerto 4x10", "peso": 90},
                                    {"nombre": "Zancadas 4x12", "peso": 40},
                                    {"nombre": "Extensiones de pierna 4x20", "peso": 60},
                                    {"nombre": "Elevación de talones 4x30", "peso": 40}
                                ],
                                "miercoles": [
                                    {"nombre": "Dominadas 4x12"},
                                    {"nombre": "Remo con barra 4x12", "peso": 80},
                                    {"nombre": "Jalón al pecho 4x15", "peso": 70},
                                    {"nombre": "Peso muerto 4x12", "peso": 90},
                                    {"nombre": "Plancha lateral 3x1 minuto"}
                                ],
                                "jueves": [
                                    {"nombre": "Press militar 4x10", "peso": 50},
                                    {"nombre": "Elevaciones laterales 4x15", "peso": 25},
                                    {"nombre": "Remo con barra 4x12", "peso": 60},
                                    {"nombre": "Press con mancuernas 4x15", "peso": 40},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ],
                                "viernes": [
                                    {"nombre": "Curl de bíceps 4x15", "peso": 30},
                                    {"nombre": "Curl martillo 4x20", "peso": 35},
                                    {"nombre": "Extensiones de tríceps 4x15", "peso": 35},
                                    {"nombre": "Fondos 4x25"},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ]
                            }
                        },
                        {
                            "numero": 4,
                            "dias": {
                                "lunes": [
                                    {"nombre": "Press banca 4x10", "peso": 75},
                                    {"nombre": "Press inclinado con mancuernas 4x12", "peso": 55},
                                    {"nombre": "Aperturas planas 4x15", "peso": 35},
                                    {"nombre": "Flexiones 4x35"},
                                    {"nombre": "Plancha 3x1 minuto"}
                                ],
                                "martes": [
                                    {"nombre": "Sentadillas 4x12", "peso": 75},
                                    {"nombre": "Peso muerto 4x10", "peso": 95},
                                    {"nombre": "Zancadas 4x12", "peso": 45},
                                    {"nombre": "Extensiones de pierna 4x20", "peso": 65},
                                    {"nombre": "Elevación de talones 4x35", "peso": 45}
                                ],
                                "miercoles": [
                                    {"nombre": "Dominadas 4x15"},
                                    {"nombre": "Remo con barra 4x12", "peso": 85},
                                    {"nombre": "Jalón al pecho 4x15", "peso": 75},
                                    {"nombre": "Peso muerto 4x12", "peso": 95},
                                    {"nombre": "Plancha lateral 3x1 minuto"}
                                ],
                                "jueves": [
                                    {"nombre": "Press militar 4x10", "peso": 55},
                                    {"nombre": "Elevaciones laterales 4x15", "peso": 30},
                                    {"nombre": "Remo con barra 4x12", "peso": 65},
                                    {"nombre": "Press con mancuernas 4x15", "peso": 45},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ],
                                "viernes": [
                                    {"nombre": "Curl de bíceps 4x15", "peso": 35},
                                    {"nombre": "Curl martillo 4x20", "peso": 40},
                                    {"nombre": "Extensiones de tríceps 4x15", "peso": 40},
                                    {"nombre": "Fondos 4x30"},
                                    {"nombre": "Plancha 4x1 minuto"}
                                ]
                            }
                        }
                    ]
                }
            ]
        }

        """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Error al convertir la cadena JSON a Data")
            return
        }
        
        do {
            persona = try JSONDecoder().decode(Persona.self, from: jsonData)
            collectionView.reloadData()
        } catch {
            print("Error al decodificar el JSON: \(error)")
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
            if let personaVar = persona {
                cell.myLabel.text = "\(personaVar.nombre) \(personaVar.apellido)"
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell", for: indexPath) as! infoViewCell
            if let personaVar = persona {
                cell.labelTitle.text = "\(personaVar.nombre) repasa tus ultimos pesos"
                cell.labelMid.text = "75 KG"
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rutinaCell", for: indexPath) as! rutinaViewCell
            if let personaVar = persona {
                cell.rutinas = personaVar.rutinas
                cell.delegate = self
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rutinaCell", for: indexPath) as! rutinaViewCell
            if let personaVar = persona {
                cell.rutinas = personaVar.rutinas
                cell.delegate = self
            }
            return cell        }
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
        }else if (indexPath.row == 1){
            return CGSize(width: myCellWidth, height: myCellWidth/2)
        }else if (indexPath.row == 2){
            return CGSize(width: myCellWidth, height: myCellWidth)
        } else{
            return CGSize(width: myCellWidth, height: myCellWidth/2)
        }
    }
}

