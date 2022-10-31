//
//  DetayPresenter.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 20.10.2022.
//

import Foundation

class DetayPresenter : ViewToPresenterDetayProtocol {
    var detayInteractor: PresenterToInteractorDetayProtocol?
    
    func sepetKontrol(yemek: SepetYemekModel) {
        detayInteractor?.sepetiKontrolEt(yemek: yemek)
    }
}
