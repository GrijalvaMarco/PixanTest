//
//  MessagesViewController.swift
//  harvx
//
//  Created by Marco Grijalva on 7/17/18.
//  Copyright © 2018 Marco Grijalva. All rights reserved.
//

import UIKit

class AlertMessages: UIViewController {
    
    static func createMessage(_ message: String, in vc: UIViewController){
        let alert = UIAlertController(title: message, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    //Create Two Options
    static func createTwoOptionsGeneral(_ title: String, _ message: String,_ optionSubmit: String, _ optionCancel: String, _ idSegue: String, in vc: UIViewController){
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: optionCancel, style: .cancel, handler: { (action) -> Void in
            print("You selected the Cancel action.")
            
        })
        let submitAction = UIAlertAction(title: optionSubmit, style: .default, handler: { (action) -> Void in
            print("You selected the submit action.")
            vc.performSegue(withIdentifier: idSegue, sender: nil)
            
            alertController.dismiss(animated: true, completion: { () -> Void in
                
            })
        })
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        
        vc.present(alertController, animated: true, completion: nil)
    }
    
    
}

