//
//  HomeDetailPresenter.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 28.09.2022.
//  

import Foundation

protocol HomeDetailPresentationLogic : AnyObject {
    func presentModel(_ model: HomeModel)
    func presentError(_ message: String)
}

final class HomeDetailPresenter: HomeDetailPresentationLogic {
  weak var viewController: HomeDetailDisplayLogic?
  
    func presentModel(_ model: HomeModel) {
        if let error = model.serverError {
            self.viewController?.handleError(error)
        } else {
            self.viewController?.displayModel(model)
        }
    }
    
    func presentError(_ message: String) {
        viewController?.handleError(message)
    }
}
