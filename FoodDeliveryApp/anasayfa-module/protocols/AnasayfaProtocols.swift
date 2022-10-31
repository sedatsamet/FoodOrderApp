//
//  AnasayfaProtocols.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 19.10.2022.
//

import Foundation

protocol ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor:PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView: PresenterToViewAnasayfaProtocol? {get set}
    
    func yemekleriAl()
}

protocol PresenterToInteractorAnasayfaProtocol {
    var anasayfaPresenter:InteractorToPresenterAnasayfaProtocol? {get set}
    
    func tumYemekleriAl()
}

protocol InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(yemekListesi:[YemekModel])
}

protocol PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yemekListesi:[YemekModel])
}

protocol PresenterToRouterAnasayfaProtocol {
    static func createModule(ref:AnasayfaViewController)
}
