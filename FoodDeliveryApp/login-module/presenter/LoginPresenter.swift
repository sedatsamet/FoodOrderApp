//
//  LoginPresenter.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 22.10.2022.
//

import Foundation

class LoginPresenter : ViewToPresenterLoginProtocol{
    var loginInteractor: PresenterToInteractorLoginProtocol?
    var loginView: PresenterToViewLoginProtocol?
    
    func girisYap(emailText: String, passwordText: String) {
        loginInteractor?.kullaniciGirisYap(emailText: emailText, passwordText: passwordText)
    }
}

extension LoginPresenter : InteractorToPresenterLoginProtocol {
    func presenteraVeriGonder(girisKontrol: Bool, errorText: String) {
        loginView?.vieweVeriGonder(girisKontrol: girisKontrol, errorText: errorText)
    }
}
