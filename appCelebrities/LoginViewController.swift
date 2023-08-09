//
//  ViewController.swift
//  appCelebrities
//
//  Created by DavidEmanuel on 7/10/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var authStack: UIStackView!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
  
    
    @IBOutlet weak var signUpButton: UIButton!
    
    let internSaved = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Inicio de Sesion"
       
        
        //funcion para mostrar/ocultar views
        hiddenViews(bool: false)
        
        // revisar si ya esta logueado con userDefaults e ingresar
        if let emailSaved = internSaved.value(forKey: "user") as? String,
           let providerSaved = internSaved.value(forKey: "provider") as? String{
            
            //funcion para mostrar/ocultar vistas
            self.hiddenViews(bool: true)
            
            //pasar a la pantalla  como logueado
            self.navigationController?.pushViewController(CelebrityListViewController(provider: ProviderType(rawValue: providerSaved)!), animated: true)
        }
    }


    @IBAction func loginActionButton(_ sender: Any) {
        let email = emailText.text
        let password = passwordText.text
        
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            if let result = result , error == nil{
                self.navigationController?.pushViewController(CelebrityListViewController(provider: ProviderType.basic), animated: true)
                
                //guardar en UserDefault se usa variable //
                self.internSaved.setValue(result.user.email, forKey: "user")
                self.internSaved.setValue(ProviderType.basic.rawValue, forKey: "provider")
                
            }else{
                self.showAlert(titulo: "Alerta", mensaje: "Usuario no registrado")
            }
        }
    }
    
    
    @IBAction func signUpActionButton(_ sender: Any) {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    
    func showAlert(titulo:String, mensaje:String){
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func hiddenViews(bool :Bool){
        logoImg.isHidden = bool
        authStack.isHidden = bool
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loginButton.round()
        hiddenViews(bool: false)
    }
    
}

