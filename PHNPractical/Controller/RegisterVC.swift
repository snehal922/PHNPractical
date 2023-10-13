//
//  RegisterVC.swift
//  PHNPractical
//
//  Created by Snehal on 12/10/23.
//

import UIKit
import RealmSwift

class RegisterVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var RegisterBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func RegisterBtnTapped(_ sender: Any) {
        
        if let name = nameTF.text,
           let email = emailTF.text,
           let password = passwordTF.text,
           let confirmPass = confirmPassTF.text,
           name != "", email != "", password != "", confirmPass != "" {
            
            registerUser(name: name, email: email, password: password, confirmPass: confirmPass)
            
            disappearingAlert(title: "Sucess", message: "register successfully!", complition: { status in
                if status {
                    print("alert Dismiss")
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                   
                }
            })
        } else {
            disappearingAlert(title: "error", message: "all fields are required", complition: { status in
                if status {
                    print("alert Dismiss")
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                }
            })
        }
        
    }
    
}

func registerUser(name: String, email: String, password: String, confirmPass: String) {
    
    do {
        let realm = try Realm()
        
        // check if user is already register
        if realm.objects(UserRegistration.self).filter("email == %@", email).isEmpty {
            
            // create new user registration
            let newUser = UserRegistration()
            newUser.name = name
            newUser.email = email
            newUser.password = password
            newUser.confirmPassword = confirmPass
            
            // confirm password
            if password == confirmPass {
                print(password)
            } else {
                print("confirm your password correctly")
                return
            }
            
            // write to realm database
            try realm.write {
                realm.add(newUser)
            }
            print("User registerd Successfully")
            print(newUser)
        } else {
            print("email is already registerd")
        }
        
        
    } catch let error as NSError {
        print("error registration user: \(error.localizedDescription)")
    }
    
}

