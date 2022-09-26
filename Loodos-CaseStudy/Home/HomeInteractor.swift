//
//  HomeInteractor.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 26.09.2022.
//

import Foundation

protocol HomeBusinessLogic{
    func getSearchedMovies(request:HomeRequestModel)
}


final class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
    func getSearchedMovies(request:HomeRequestModel){
        worker = HomeWorker()
        worker?.getMovies(request: request){model,error in
            if let model = model {
                self.presenter?.presentModel(model)
            } else if let error = error?.localizedDescription {
                self.presenter?.presentError(error)
            }
        }
    }

}
