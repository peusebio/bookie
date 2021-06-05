//
//  AppStoreReview.swift
//  hipHopFm
//
//  Created by Pedro Eusébio on 05/06/2021.
//

import Foundation
import StoreKit

class AppStoreReview {
    
    private static let configKey: String = "numberOfTimesAppOpened"
    private static var defaults: UserDefaults = UserDefaults.standard
    private static var numberOfTimesAppOpened: Int = defaults.integer(forKey: configKey)
    
    static func showReviewDialogIfNecessary(){
        numberOfTimesAppOpened += 1
        defaults.set(numberOfTimesAppOpened, forKey: configKey)
        if numberOfTimesAppOpened % 10 == 0 {
            if let windowScene = UIApplication.shared.windows.first?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}
