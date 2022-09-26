//
//  SplashPresenter.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//

import UIKit

protocol SplashPresentationLogic : AnyObject {
    func presentFirebaseConfigt(_ model: SplashModel.ViewModel)
    func presentFireBaseError(_ message: SplashModel.ErrorModel)
}

final class SplashPresenter: SplashPresentationLogic {
    weak var viewController: SplashDisplayLogic?
    func presentFirebaseConfigt(_ model: SplashModel.ViewModel){
        guard let text = model.text else {return}
        viewController?.configureSplashText(text)
    }
    
    func presentFireBaseError(_ message: SplashModel.ErrorModel){
        guard let errorMessage = message.text else {return}
        viewController?.handleError(errorMessage)
    }

}
