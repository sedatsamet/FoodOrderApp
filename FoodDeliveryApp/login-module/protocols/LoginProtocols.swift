//
//  LoginProtocols.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 22.10.2022.
//

import Foundation

protocol ViewToPresenterLoginProtocol {
    var loginInteractor : PresenterToInteractorLoginProtocol? {get set}
    var loginView : PresenterToViewLoginProtocol? {get set}
    
    func girisYap(emailText:String, passwordText:String)
}

protocol PresenterToInteractorLoginProtocol {
    var loginPresenter : InteractorToPresenterLoginProtocol? {get set}
    
    func kullaniciGirisYap(emailText:String, passwordText:String)
}

protocol InteractorToPresenterLoginProtocol {
    func presenteraVeriGonder(girisKontrol:Bool, errorText:String)
}

protocol PresenterToViewLoginProtocol {
    func vieweVeriGonder(girisKontrol:Bool, errorText:String)
}

protocol PresenterToRouterLoginProtocol {
    static func createModule(ref:LoginViewController)
}
