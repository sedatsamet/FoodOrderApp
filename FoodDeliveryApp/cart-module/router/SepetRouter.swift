//
//  SeperRouter.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 20.10.2022.
//

import Foundation

class SepetRouter : PresenterToRouterSepetProtocol {
    static func createModule(ref: SepetViewController) {
        let presenter = SepetPresenter()
        
        ref.sepetPresenterNesnesi = presenter
        
        ref.sepetPresenterNesnesi?.sepetInteractor = SepetInteractor()
        ref.sepetPresenterNesnesi?.sepetView = ref
        
        ref.sepetPresenterNesnesi?.sepetInteractor?.sepetPresenter = presenter
    }
}
