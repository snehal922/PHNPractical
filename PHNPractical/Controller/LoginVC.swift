//
//  LoginVC.swift
//  PHNPractical
//
//  Created by Snehal on 12/10/23.
//

import UIKit
import RealmSwift
import Lottie

class LoginVC: UIViewController {
    
    @IBOutlet weak var UsernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var lottieImg: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView = LottieAnimationView()
        animationView.loopMode = .loop
        lottieImg = animationView
        
        guard let url = Bundle.main.url(forResource: "lottietest", withExtension: "json") else { return }
        DotLottieFile.loadedFrom(url: url) { result in
            switch result {
            case .success( let success): animationView.loadAnimation(from: success)
                animationView.play()
            case .failure(let failure):
                print(failure)
            }
        }

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        passwordTF.text = ""
        passwordTF.text = ""
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        guard let username = UsernameTF.text,
                let password = passwordTF.text,
              password != "", password != "" else {
            print("all fields required")
            disappearingAlert(title: "error", message: "all fields required", complition: { status in
                if status {
                    print("alert Dismiss")
                }
            })
            return
        }
        if loginUser(email: username, password: password) == true {

            disappearingAlert(title: "Sucess", message: "login successfully!", complition: { status in
                if status {
                    print("alert Dismiss")
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toHomeVC", sender: self)
                    }
                }
            })
        } else {
            disappearingAlert(title: "error", message: "email or password is incorrect", complition: { status in
                if status {
                    print("alert Dismiss")
                }
            })
        }
            
            
    }
    func loginUser(email: String, password: String) -> Bool {
        do {
            let realm = try Realm()
            
            if let user = realm.objects(UserRegistration.self).filter("email == %@ AND password == %@", email,password).first {
                print("UserLogged in Successfully")
                
                print(user)
                return true
            } else {
                print("invalid email or password")
                return false
            }
            
        } catch let error as NSError {
            print("Error logging in user: \(error.localizedDescription)")
            return true
        }
    }
}
