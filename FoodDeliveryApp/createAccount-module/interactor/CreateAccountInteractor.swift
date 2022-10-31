//
//  CreateAccountInteractor.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 22.10.2022.
//

import Foundation
import Firebase

class CreateAccountInteractor : PresenterToInteractorCreateAccountProtocol{
    var createPresenter: InteractorToPresenterCreateAccountProtocol?
    
    func yeniKayitYap(emailText: String, passwordText: String) {
        var kayitKontrol = false
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { authdata,error in
            if error != nil {
                // Signup failed
                self.createPresenter?.presenteraVeriGonder(kayitKontrol: kayitKontrol, errorText: error!.localizedDescription)
            }else{
                // Signup successful
                kayitKontrol = true
                self.createPresenter?.presenteraVeriGonder(kayitKontrol: kayitKontrol, errorText: "")
            }
        }
    }
}
