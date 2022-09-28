//
//  AppDelegate.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//

import UIKit
import SnapKit
import FirebaseCore
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        configureIQKeyboardManager()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()
        LottieHud.shared.show()
        return true
    }
}

