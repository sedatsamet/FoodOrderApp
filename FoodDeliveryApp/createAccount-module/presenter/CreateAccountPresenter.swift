//
//  CreateAccountPresenter.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 22.10.2022.
//

import Foundation

class CreateAccountPresenter : ViewToPresenterCreateAccountProtocol{
    var createInteractor: PresenterToInteractorCreateAccountProtocol?
    
    var createView: PresenterToViewCreateAccountProtocol?
    
    func kayitYap(emailText: String, passwordText: String) {
        createInteractor?.yeniKayitYap(emailText: emailText, passwordText: passwordText)
    }
}

extension CreateAccountPresenter : InteractorToPresenterCreateAccountProtocol {
    func presenteraVeriGonder(kayitKontrol: Bool, errorText:String) {
        createView?.vieweVeriGonder(kayitKontrol: kayitKontrol, errorText: errorText)
    }
}
