//
//  OnboardingInteractor.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 16.10.2022.
//

import Foundation
import UIKit
import Lottie

class OnboardingInteractor : PresenterToInteractorOnboardingProtocol{
    var onboardingPresenter: InteractorToPresenterOnboardingProtocol?
    
    var liste : [OnboardingItem] = [OnboardingItem(title: "Yeni Lezzetler Keşfet!", description: "Seni heyecanlandıracak yeni lezzetleri dene.", animation: LottieAnimationView(name: "cakeCookiesFruitAnimation")),
                                    OnboardingItem(title: "Ustası'nın Elinden!", description: "En başarılı Cheff'lerin mutfağından yemek siparişi ver.", animation: LottieAnimationView(name: "grillAnimation")),
                                    OnboardingItem(title: "Kısa Sürede!", description: "En hızlı gerçekleşen sipariş teslimi ile bekleme.", animation: LottieAnimationView(name: "deliveryAnimation"))]
    
    func onboardingTumunuYukle() {
        onboardingPresenter?.presenteraVeriGonder(onboardingListe: liste)
    }
    
    
}
