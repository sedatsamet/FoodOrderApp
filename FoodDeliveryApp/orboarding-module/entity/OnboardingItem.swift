//
//  OnboardingItem.swift
//  FoodDeliveryApp
//
//  Created by Sedat Samet Oypan on 16.10.2022.
//

import UIKit
import Lottie

class OnboardingItem {
    var title:String?
    var description:String?
    var animation:LottieAnimationView?
    
    init(title: String, description: String, animation: LottieAnimationView) {
        self.title = title
        self.description = description
        self.animation = animation
    }
}
