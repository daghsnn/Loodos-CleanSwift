//
//  SplashRouter.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//  

import UIKit

protocol SplashRoutingLogic {
    func routeToHomeScreen()
}

final class SplashRouter: SplashRoutingLogic {
    
    weak var viewController: SplashViewController?
    func routeToHomeScreen(){
        let destination = HomeViewController()
        var navigation = UINavigationController(rootViewController: destination)
        navigation.modalTransitionStyle = .crossDissolve
        navigation.modalPresentationStyle = .fullScreen
        configureNavigationController(&navigation)
        viewController?.present(navigation, animated: true)

    }
    
    func configureNavigationController(_ navController: inout UINavigationController){
        navController.navigationBar.barTintColor = UIColor(named: "backgroundColor")
    }
}
