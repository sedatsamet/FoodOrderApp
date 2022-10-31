//
//  CreateAccountRouter.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 22.10.2022.
//

import Foundation

class CreateAccountRouter : PresenterToRouterCreateAccountProtocol{
    static func createModule(ref: CreateAccountViewController) {
        let presenter = CreateAccountPresenter()
        
        ref.createPresenterNesnesi = presenter
        
        ref.createPresenterNesnesi?.createInteractor = CreateAccountInteractor()
        ref.createPresenterNesnesi?.createView = ref
        
        ref.createPresenterNesnesi?.createInteractor?.createPresenter = presenter
    }
}
