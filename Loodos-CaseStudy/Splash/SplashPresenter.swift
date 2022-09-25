//
//  SplashPresenter.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//



import UIKit

protocol SplashPresentationLogic : AnyObject {
    func configureSplash(_ connected:Bool)
}

final class SplashPresenter: SplashPresentationLogic {
    weak var viewController: SplashDisplayLogic?
    
    func configureSplash(_ connected:Bool){
        connected ? viewController?.configureUI : viewController?.handleError
    }
}
