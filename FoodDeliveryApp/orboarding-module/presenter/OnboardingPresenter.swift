//
//  OnboardingPresenter.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 16.10.2022.
//

import Foundation

class OnboardingPresenter : ViewToPresenterOnboardingProtocol{
    var onboardingInteractor: PresenterToInteractorOnboardingProtocol?
    
    var onboardingView: PresenterToViewOnboardingProtocol?
    
    func onboardingYukle() {
        onboardingInteractor?.onboardingTumunuYukle()
    }
}

extension OnboardingPresenter : InteractorToPresenterOnboardingProtocol {
    func presenteraVeriGonder(onboardingListe: [OnboardingItem]) {
        onboardingView?.vieweVeriGonder(onboardingListesi: onboardingListe)
    }
}
