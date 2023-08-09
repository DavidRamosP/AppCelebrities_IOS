//
//  SignUpViewController.swift
//  appCelebrities
//
//  Created by DavidEmanuel on 7/10/23.
//

import UIKit
import FirebaseAuth


class SignUpViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var provideTypeText: UITextField!
    @IBOutlet weak var passwordConfirmationText: UITextField!
    
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      title = "Register"
        provideTypeText.text = ProviderType.basic.rawValue
        
    }

    
    
    @IBAction func createActionButton(_ sender: Any) {
        let email = emailText.text
        let password = passwordText.text
        let passwordConfirmation = passwordConfirmationText.text
     
        if password!.count > 8{
            if(password == passwordConfirmation){
            Auth.auth().createUser(withEmail: email!, password: passwordConfirmation!) { (result, error) in
                    if let result = result, error == nil{
                         
                            let alert = UIAlertController(title: "Exito", message: "Se Registro Usuario Correctamente", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                            self.navigationController?.pushViewController(CelebrityListViewController(provider: ProviderType.basic), animated: true)
                        }
                            ))
                        self.present(alert, animated: true)
                        
                    //    UserDefaults.standard.setValue(result.user.email, forKey: "user")
                     //   UserDefaults.standard.setValue(ProviderType.basic.rawValue, forKey: "provider")
                    }else {
                        self.showAlert(titulo: "Error Creacion", mensaje: "Hubo un error al crear, Reintentar")
                    }
                }
            }else {
                showAlert(titulo: "Error Contraseñas", mensaje: "Contraseñas No Coinciden")
            }
            
        }else {
            showAlert(titulo: "Contraseña", mensaje: "Contraseña debe ser mayor a 8 digitos")
        }
        
    }
    
    @IBAction func loginActionBUtton(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
 
    func showAlert(titulo:String, mensaje:String){
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil	)
    }
}
