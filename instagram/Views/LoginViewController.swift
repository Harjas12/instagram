//
//  ViewController.swift
//  instagram
//
//  Created by Harjas Monga on 2/2/18.
//  Copyright © 2018 Harjas Monga. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.autocorrectionType = .no
    }
    func registerUser() {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: "Could not register user", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                self.loginUser()
            }
        }
        
    }
    func loginUser() {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: "Could not login in user", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    func checkFields() -> Bool {
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty {
            let alertController = UIAlertController(title: "Missing username or password", message: "Please enter your username and password", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }
    @IBAction func loginPressed(_ sender: Any) {
        if checkFields() {
            loginUser()
        }
    }
    @IBAction func signUpPressed(_ sender: Any) {
        if checkFields() {
            registerUser()
        }
    }
    @IBAction func screenTapped(_ sender: Any) {
        view.endEditing(true)
    }
    

}

