//
//  SplashInteractor.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//

import Foundation

protocol SplashBusinessLogic {
    func getFirebaseConfiguration()
}

final class SplashInteractor: SplashBusinessLogic {
    var presenter: SplashPresentationLogic?
    var worker: SplashWorker?
    
    func getFirebaseConfiguration(){
        worker = SplashWorker()
        worker?.getFirebaseRemoteConfig{ [weak self] (text, error) in
            LottieHud.shared.hide()
            if let error = error {
                self?.presenter?.presentFireBaseError(SplashModel.ErrorModel(text: error.localizedDescription))
            } else {
                self?.presenter?.presentFirebaseConfigt(SplashModel.ViewModel(text: text))
            }
        }
    }
}
