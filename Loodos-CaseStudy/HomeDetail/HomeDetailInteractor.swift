//
//  HomeDetailInteractor.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 28.09.2022.
//

import Foundation

protocol HomeDetailBusinessLogic{
    func getDetails(request: HomeDetailRequestModel)
}

final class HomeDetailInteractor: HomeDetailBusinessLogic {
    var presenter: HomeDetailPresentationLogic?
    var worker: HomeDetailWorker?
    
    func getDetails(request: HomeDetailRequestModel){
        worker = HomeDetailWorker()
        worker?.getDetails(request: request){ model, error in
            if let model = model {
                self.presenter?.presentModel(model)
            } else if let error = error?.localizedDescription {
                self.presenter?.presentError(error)
            }
        }


    }
}
