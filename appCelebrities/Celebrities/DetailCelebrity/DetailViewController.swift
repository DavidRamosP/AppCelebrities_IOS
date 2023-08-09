//
//  DetailViewController.swift
//  appCelebrities
//
//  Created by DavidEmanuel on 7/10/23.
//

import UIKit
import FirebaseAuth
import Alamofire
import AlamofireImage
import SwiftyJSON

class DetailViewController: UIViewController {
    
    @IBOutlet weak var fotoImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var mobileLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    let urlImage : String
    let name : String
    let email : String
    let mobile : String
    let gender : String
    
    init(urlimage:String,name:String,email:String,mobile:String,gender:String) {
        self.urlImage = urlimage
        self.name = name
        self.email = email
        self.mobile = mobile
        self.gender = gender
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Alamofire | SwiftJSON | Details"
        dataCharger()
        
    }

    @IBAction func logouActionButton(_ sender: Any) {
        
        do {
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "provider")
            UserDefaults.standard.synchronize()
            
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    
    func dataCharger(){
        nameLabel.text = name
        emailLabel.text = email
        mobileLabel.text = mobile
        genderLabel.text = gender
        
        DispatchQueue.main.async {
            Alamofire.request(self.urlImage).responseImage { (response) in
                switch response.result{
                case .success(let image) : self.fotoImage.image = image
                case .failure(let error) : error.localizedDescription
                }
            }
        }
      
        
        
    }



}
