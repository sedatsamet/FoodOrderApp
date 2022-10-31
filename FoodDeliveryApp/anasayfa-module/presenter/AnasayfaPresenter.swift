//
//  AnasayfaPresenter.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 19.10.2022.
//

import Foundation

class AnasayfaPresenter : ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol?
    var anasayfaView: PresenterToViewAnasayfaProtocol?
    
    func yemekleriAl() {
        anasayfaInteractor?.tumYemekleriAl()
    }
}

extension AnasayfaPresenter : InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(yemekListesi: [YemekModel]) {
        anasayfaView?.vieweVeriGonder(yemekListesi: yemekListesi)
    }
}
