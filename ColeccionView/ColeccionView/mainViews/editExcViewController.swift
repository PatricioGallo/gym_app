import UIKit

class editExcViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var myImage: UIImageView!
    var rutina : Rutina?
    var semana: Semana?
    var dia : Dias?
    var ejercicio: Ejercicio?
    var rutinaIndex:Int?
    var semanaIndex:Int?
    var diaIndex: Int?
    var ejercicioIndex: Int?

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
            print("Valor ingresado: \(peso)")
            let persona_modificada = Persona_mod(nombre: "Patricio", apellido: nil, edad: nil, mail: nil, contrasena: nil, rutinas: nil)
                
            netWorkingProvider.shared.editInfo(id: 1, user: persona_modificada,
                        success: { updatedUser in
                            // Manejar el éxito, actualizar el estado si es necesario
                            generateData.modificarPesoEnEjercicio(rutinaIndex: self.rutinaIndex!, semanaIndex: self.semanaIndex!, diaIndex: self.diaIndex!, ejercicioIndex: self.ejercicioIndex!, nuevoPeso: peso)
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

