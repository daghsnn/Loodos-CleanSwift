//
//  SplashPresenter.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//



import UIKit

protocol SplashPresentationLogic : AnyObject {
    func presentSomething()
//    func presentSomething(response: Splash.Something.Response)
}

final class SplashPresenter: SplashPresentationLogic {
    weak var viewController: SplashDisplayLogic?
    
    func presentSomething(){
//        let viewModel = Splash.Something.ViewModel()
        viewController?.displaySomething()
    }
}
