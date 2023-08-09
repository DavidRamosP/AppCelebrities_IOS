//
//  CelebrityListViewController.swift
//  appCelebrities
//
//  Created by DavidEmanuel on 7/10/23.
//

import UIKit
import FirebaseAuth
import Alamofire
import SwiftyJSON

var listaCelebrities : [Celebrity] = []

enum ProviderType:String{
    case basic
}

class CelebrityListViewController: UIViewController {
    

    
    
    @IBOutlet weak var myTableVIew: UITableView!
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    
    let provider : ProviderType
    
    init(provider: ProviderType) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.isEnabled = true
        navigationItem.hidesBackButton = true

        title = "Alamofire | SwiftJSON"
        myTableVIew.register(UINib(nibName: "CelebrityTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        fetchData()
            
    }
    
   
    @IBAction func logoutActionButton(_ sender: Any) {
        
        do {
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "provider")
            UserDefaults.standard.synchronize()
            try Auth.auth().signOut()
        } catch {
            print("error")
        }
    }
    
   
    func fetchData(){
            Alamofire.request("https://private-0b77e3-celebritiesdavid.apiary-mock.com/celebrity").responseJSON { (response) in
               
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    
                    json.array?.forEach({ (celebrity) in
                        let newCelebrity = Celebrity(name:celebrity["name"].stringValue, email: celebrity["email"].stringValue, mobile: celebrity["mobile"].stringValue, gender: celebrity["gender"].stringValue, image: celebrity["image"].stringValue)
                        listaCelebrities.append(newCelebrity)
                        self.myTableVIew.reloadData()
                    })
                    
                    
                    
                case .failure(let error):print(error.localizedDescription)
                
                }
            }
        
    }
    
 

}


extension CelebrityListViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCelebrities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CelebrityTableViewCell
        
        cell.nameLabel.text = listaCelebrities[indexPath.row].name
        cell.emailLabel.text = listaCelebrities[indexPath.row].email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // declaracion de variables
        
        let urlImage = listaCelebrities[indexPath.row].image
        let name = listaCelebrities[indexPath.row].name
        let email = listaCelebrities[indexPath.row].email
        let mobile = listaCelebrities[indexPath.row].mobile
        let gender = listaCelebrities[indexPath.row].gender
        
        //preparacion : Instancia de View destino
        let viewDetalle = DetailViewController(urlimage: urlImage!, name: name, email: email, mobile: mobile!, gender: gender!)
        
    
        
        self.navigationController?.pushViewController(viewDetalle, animated: true)
        
    }
    
    
}
