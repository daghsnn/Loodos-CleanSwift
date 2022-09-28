//
//  HomePresenter.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 26.09.2022.
//

import Foundation

protocol HomePresentationLogic : AnyObject {
    func presentModel(_ model: HomeResponseModel)
    func presentError(_ message: String)
}

final class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    func presentModel(_ model: HomeResponseModel) {
        if let results = model.search {
            self.viewController?.displayModel(results)
        } else if let error = model.serverError {
            self.viewController?.handleError(error)
        }
    }
    
    func presentError(_ message: String) {
        viewController?.handleError(message)
    }
    
}
