//
//  ReviewHandler.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 7/22/22.
//

import StoreKit
import SwiftUI
import Foundation

class ReviewHandler {
    
    static func requestReview() {
        var count = UserDefaults.standard.integer(forKey: UserDefaultKeys.appStartUpsCountKey)
        count += 1
        UserDefaults.standard.set(count, forKey: UserDefaultKeys.appStartUpsCountKey)
        
        if count == 4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }
        }
    }
}
