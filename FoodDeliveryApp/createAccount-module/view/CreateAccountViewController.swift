//
//  CreateAccountViewController.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 18.10.2022.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var emailTextLabel: UITextField!
    @IBOutlet weak var phoneTextLabel: UITextField!
    @IBOutlet weak var passwordTextLabel: UITextField!
    
    var createPresenterNesnesi : ViewToPresenterCreateAccountProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CreateAccountRouter.createModule(ref: self)
        
        let endEditingGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(endEditingGesture)
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    // MARK: Signup
    @IBAction func createAccountButtonClicked(_ sender: Any) {
        if emailTextLabel.text != "" && passwordTextLabel.text != "" && phoneTextLabel.text != "" {
            createPresenterNesnesi?.kayitYap(emailText: emailTextLabel.text!, passwordText: passwordTextLabel.text!)
        }else{
            makeAlert(titleInput: "Hata", messageInput: "Lütfen tüm alanları doldurunuz.")
        }
    }
}
// MARK: Signup Control
extension CreateAccountViewController : PresenterToViewCreateAccountProtocol {
    func vieweVeriGonder(kayitKontrol: Bool, errorText:String) {
        if errorText != "" && kayitKontrol == false {
            self.makeAlert(titleInput: "Hata", messageInput: errorText)
        }else{
            self.performSegue(withIdentifier: "createToNavigationController", sender: nil)
        }
    }
}
// MARK: Alert Function to call from anywhere
extension CreateAccountViewController {
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
