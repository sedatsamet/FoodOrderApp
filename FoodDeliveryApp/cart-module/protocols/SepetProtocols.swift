//
//  SepetProtocols.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 20.10.2022.
//

import Foundation

protocol ViewToPresenterSepetProtocol {
    var sepetInteractor:PresenterToInteractorSepetProtocol? {get set}
    var sepetView: PresenterToViewSepetProtocol? {get set}
    
    func sepetYemekleriAl(kullanici_adi:String)
    func YemekSil(sepet_yemek_id:Int, kullanici_adi:String)
}

protocol PresenterToInteractorSepetProtocol {
    var sepetPresenter:InteractorToPresenterSepetProtocol? {get set}
    
    func tumSepetYemekleriAl(kullanici_adi:String)
    func sepetYemekSil(sepet_yemek_id:Int, kullanici_adi:String)
}

protocol InteractorToPresenterSepetProtocol {
    func presenteraVeriGonder(sepetListesi:[SepetYemekModel])
}

protocol PresenterToViewSepetProtocol {
    func vieweVeriGonder(sepetListesi:[SepetYemekModel])
}

protocol PresenterToRouterSepetProtocol {
    static func createModule(ref:SepetViewController)
}
