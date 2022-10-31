//
//  DetayProtocols.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 20.10.2022.
//

import Foundation

protocol ViewToPresenterDetayProtocol {
    var detayInteractor:PresenterToInteractorDetayProtocol? {get set}
    
    func sepetKontrol(yemek:SepetYemekModel)
}

protocol PresenterToInteractorDetayProtocol {
    func sepetiKontrolEt(yemek:SepetYemekModel)
}

protocol PresenterToRouterDetayProtocol {
    static func createModule(ref:DetayViewController)
}
