//
//  LoginInteractor.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 22.10.2022.
//

import Foundation
import Firebase
class LoginInteractor : PresenterToInteractorLoginProtocol{
    var loginPresenter: InteractorToPresenterLoginProtocol?
    
    func kullaniciGirisYap(emailText: String, passwordText: String) {
        var girisKontrol = false
        Auth.auth().signIn(withEmail: emailText, password: passwordText) {authdata,error in
            if error != nil {
                // Login failed
                self.loginPresenter?.presenteraVeriGonder(girisKontrol: girisKontrol, errorText: error!.localizedDescription)
            }else{
                // Login successful
                girisKontrol = true
                self.loginPresenter?.presenteraVeriGonder(girisKontrol: girisKontrol, errorText: "")
            }
        }
    }
    
    
}
