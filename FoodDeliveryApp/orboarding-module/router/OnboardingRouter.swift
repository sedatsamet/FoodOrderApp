//
//  OnboardingRouter.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 16.10.2022.
//

import Foundation

class OnboardingRouter : PresenterToRouterOnboardingProtocol {
    static func createModule(ref: OnboardingViewController) {
        let presenter = OnboardingPresenter()
        
        ref.onboardingPresenterNesnesi = presenter
        
        ref.onboardingPresenterNesnesi?.onboardingInteractor = OnboardingInteractor()
        ref.onboardingPresenterNesnesi?.onboardingView = ref
        
        ref.onboardingPresenterNesnesi?.onboardingInteractor?.onboardingPresenter = presenter
    }
}
