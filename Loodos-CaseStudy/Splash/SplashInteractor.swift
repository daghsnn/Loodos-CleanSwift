//
//  SplashInteractor.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//

import UIKit

protocol SplashBusinessLogic : AnyObject {
    func doSomething()
}



final class SplashInteractor: SplashBusinessLogic {
    var presenter: SplashPresentationLogic?
    var worker: SplashWorker?
    
    func doSomething(){
        worker = SplashWorker()
        worker?.doSomeWork()
        
        //    let response = Splash.Something.Response()
        //    presenter?.presentSomething(response: response)
    }
}
