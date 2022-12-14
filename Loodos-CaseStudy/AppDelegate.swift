//
//  AppDelegate.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//

import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureFireBase(application)

        configureIQKeyboardManager()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
        LottieHud.shared.show()
        return true
    }
}

