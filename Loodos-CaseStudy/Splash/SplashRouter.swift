//
//  SplashRouter.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//  

import UIKit

protocol SplashRoutingLogic : AnyObject{
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

final class SplashRouter: NSObject, SplashRoutingLogic {
    weak var viewController: SplashViewController?
    
}
