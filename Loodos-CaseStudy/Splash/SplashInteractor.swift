//
//  SplashInteractor.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//

import UIKit

protocol SplashBusinessLogic {
    func getFirebaseConfiguration()
}

final class SplashInteractor: SplashBusinessLogic {
    var presenter: SplashPresentationLogic?
    var worker: SplashWorker?
    
    func getFirebaseConfiguration(){
        worker = SplashWorker()
        print(NetworkListener.shared.isConnected)
    }
}
