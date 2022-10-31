//
//  LoginViewController.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 18.10.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextLabel: UITextField!
    @IBOutlet weak var passwordTextLabel: UITextField!
    
    var loginPresenterNesnesi : ViewToPresenterLoginProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginRouter.createModule(ref: self)
        
        let endEditingGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(endEditingGesture)
    }
    override func viewWillAppear(_ animated: Bool) {
        emailTextLabel.text = ""
        passwordTextLabel.text = ""
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    // MARK: Login
    @IBAction func loginButtonClicked(_ sender: Any) {
        if emailTextLabel.text != "" && passwordTextLabel.text != "" {
            loginPresenterNesnesi?.girisYap(emailText: emailTextLabel.text!, passwordText: passwordTextLabel.text!)
        }else{
            makeAlert(titleInput: "Hata", messageInput: "Lütfen tüm alanları doldurunuz.")
        }
    }
}

// MARK: Login Control
extension LoginViewController : PresenterToViewLoginProtocol {
    func vieweVeriGonder(girisKontrol: Bool, errorText: String) {
        if errorText != "" && girisKontrol == false {
            self.makeAlert(titleInput: "Hata", messageInput: errorText)
        }else{
            self.performSegue(withIdentifier: "toNavigationController", sender: nil)
        }
    }
}

// MARK: Alert Function to call from anywhere
extension LoginViewController {
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
