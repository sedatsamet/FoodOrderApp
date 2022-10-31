//
//  CreateAccountProtocols.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 22.10.2022.
//

import Foundation

protocol ViewToPresenterCreateAccountProtocol {
    var createInteractor : PresenterToInteractorCreateAccountProtocol? {get set}
    var createView : PresenterToViewCreateAccountProtocol? {get set}
    
    func kayitYap(emailText:String, passwordText:String)
}

protocol PresenterToInteractorCreateAccountProtocol {
    var createPresenter : InteractorToPresenterCreateAccountProtocol? {get set}
    
    func yeniKayitYap(emailText:String, passwordText:String)
}

protocol InteractorToPresenterCreateAccountProtocol {
    func presenteraVeriGonder(kayitKontrol:Bool, errorText:String)
}

protocol PresenterToViewCreateAccountProtocol {
    func vieweVeriGonder(kayitKontrol:Bool, errorText:String)
}

protocol PresenterToRouterCreateAccountProtocol {
    static func createModule(ref:CreateAccountViewController)
}
