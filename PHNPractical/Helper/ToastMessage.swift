//
//  ToastMessage.swift
//  PHNPractical
//
//  Created by Snehal on 13/10/23.
//

import Foundation
import UIKit

extension UIViewController {
    func disappearingAlert(title: String, message: String, complition: @escaping(Bool) -> Void){
        // the alert view
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            complition(true)
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
            
        }
    }
}
