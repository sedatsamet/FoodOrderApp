//
//  OnboardingProtocols.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 16.10.2022.
//

import Foundation

protocol ViewToPresenterOnboardingProtocol {
    var onboardingInteractor:PresenterToInteractorOnboardingProtocol? {get set}
    var onboardingView: PresenterToViewOnboardingProtocol? {get set}
    
    func onboardingYukle()
}

protocol PresenterToInteractorOnboardingProtocol {
    var onboardingPresenter: InteractorToPresenterOnboardingProtocol? {get set}
    
    func onboardingTumunuYukle()
}

protocol InteractorToPresenterOnboardingProtocol {
    func presenteraVeriGonder(onboardingListe:[OnboardingItem])
}

protocol PresenterToViewOnboardingProtocol {
    func vieweVeriGonder(onboardingListesi:[OnboardingItem])
}

protocol PresenterToRouterOnboardingProtocol {
    static func createModule(ref:OnboardingViewController)
}
