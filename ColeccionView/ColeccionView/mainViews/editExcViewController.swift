import UIKit

protocol editExcDelegate: AnyObject {
    func didUpdateExercise(update: Int)
}

class editExcViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    var rutina : Rutina?
    var semana: Semana?
    var dia : Dias?
    var ejercicio: Ejercicio?
    var rutinaIndex:Int?
    var semanaIndex:Int?
    var diaIndex: Int?
    var ejercicioIndex: Int?
    var historial: [Historial] = []
    weak var delegate: editExcDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadExc(rutinaIndex: rutinaIndex, semanaIndex: semanaIndex, diaIndex: diaIndex, ejercicioIndex: ejercicioIndex)
        // Configuración del fondo
        self.view.backgroundColor = UIColor.black // Asegúrate de que el fondo no sea transparente

        // Configuración del Label
        tittleLabel.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        tittleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        assignTitle(title: ejercicio?.nombre)

        // Configuración del TextInput
        placeHolderConfig(peso: ejercicio?.peso)
        textInput.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
        textInput.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        textInput.textAlignment = .center
        
        // Asignar el delegate
        textInput.delegate = self
        
        // Configuración del Modal
        self.modalPresentationStyle = .pageSheet
        
        // Agregar una barra de herramientas con un botón
        setupToolbar()
        
        infoLabel.text = " Agarra la barra con las manos un poco más anchas que el ancho de los hombros y levántala desde el soporte, extendiendo los brazos hacia arriba. Baja la barra controladamente hacia tu pecho, manteniendo los codos a un ángulo de aproximadamente 45 grados respecto al torso. Asegúrate de que la barra toque suavemente tu pecho antes de empujarla de nuevo hacia arriba hasta que los brazos estén completamente extendidos."
    }
    
    func loadExc(rutinaIndex: Int?, semanaIndex: Int?, diaIndex: Int?, ejercicioIndex: Int?){
        if let deco_rut_path = rutinaIndex{
            rutina = generateData.newPerson?.rutinas[deco_rut_path]
        }
        if let deco_week_path = semanaIndex{
            semana = rutina?.semanas[deco_week_path]
        }
        if let deco_dia_path = diaIndex{
            dia = semana?.dias[deco_dia_path]
        }
        if let deco_exc_path = ejercicioIndex{
            ejercicio = dia?.ejercicios[deco_exc_path]
        }
    }

    func assignTitle(title: String?) {
        if let title_deco = title {
            tittleLabel.text = title_deco
        }
    }

    func placeHolderConfig(peso: Int?) {
        if let peso_d = peso {
            textInput.placeholder = "\(peso_d) KG"
        } else {
            textInput.placeholder = "0"
        }
    }

    // Configuración de la barra de herramientas
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Hecho", style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
        
        textInput.inputAccessoryView = toolbar
    }

    @objc func doneButtonTapped() {
        captureInputValue()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        captureInputValue()
        return true
    }

    private func captureInputValue() {
        if let text = textInput.text, !text.isEmpty, let peso = Int(text) {
            //Genero la persona mofificada
            var persona_modificada = Persona_mod(nombre:nil, apellido: nil, edad: nil, mail: nil, contrasena: nil, rutinas: [], messures: nil, historial: [])
            //Agarro los array ya existentes
            historial = generateData.newPerson?.historial ?? []
            var rutina_mod: [Rutina] = generateData.newPerson?.rutinas ?? []
            //modifico el array historial
            let obHistorial = Historial(id_exc: ejercicio?.id_exc, peso: peso, fecha: "26-09-2024")
            historial.append(obHistorial)
            //Agrego los cambios a persona
            persona_modificada.historial = historial
            persona_modificada.rutinas = rutina_mod
            //modifico el array rutinas
            generateData.modificarPersonaMod(persona: &persona_modificada, rutinaIndex: rutinaIndex!, semanaIndex: semanaIndex!, diaIndex: diaIndex!, ejercicioIndex: ejercicioIndex!, nuevoPeso: peso)
            //Subo a la nube
            netWorkingProvider.shared.editInfo(id: generateData.userID, user: persona_modificada,
                        success: { updatedUser in
                            //cambios del array local
                            generateData.newPerson?.historial = self.historial
                            generateData.modificarPesoEnEjercicio(rutinaIndex: self.rutinaIndex!, semanaIndex: self.semanaIndex!, diaIndex: self.diaIndex!, ejercicioIndex: self.ejercicioIndex!, nuevoPeso: peso)
                            self.delegate?.didUpdateExercise(update: 1)
                        },
                        failure: { error in
                            // Manejar el error
                            print("Error al actualizar el usuario: \(error?.localizedDescription ?? "Desconocido")")
                        })
            
            dismissModal() // Cierra el modal
        } else {
            print("El campo está vacío o no es un número válido.")
            dismissModal() // Cierra el modal
        }
    }

    private func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }

    // Validación de entrada en el UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Permitir borrar
        if string.isEmpty {
            return true
        }

        // Verificar que la nueva cadena solo contenga dígitos
        let allowedCharacterSet = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacterSet.isSuperset(of: characterSet)
    }
}

