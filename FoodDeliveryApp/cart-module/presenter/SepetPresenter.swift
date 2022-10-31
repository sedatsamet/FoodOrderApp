//
//  SepetPresenter.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 20.10.2022.
//

import Foundation

class SepetPresenter : ViewToPresenterSepetProtocol {
    var sepetInteractor: PresenterToInteractorSepetProtocol?
    
    var sepetView: PresenterToViewSepetProtocol?
    
    func sepetYemekleriAl(kullanici_adi: String) {
        sepetInteractor?.tumSepetYemekleriAl(kullanici_adi: kullanici_adi)
    }
    
    func YemekSil(sepet_yemek_id: Int, kullanici_adi: String) {
        sepetInteractor?.sepetYemekSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
}
extension SepetPresenter : InteractorToPresenterSepetProtocol {
    func presenteraVeriGonder(sepetListesi: [SepetYemekModel]) {
        sepetView?.vieweVeriGonder(sepetListesi: sepetListesi)
    }
}
