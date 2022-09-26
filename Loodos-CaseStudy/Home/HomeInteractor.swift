//
//  HomeInteractor.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 26.09.2022.
//

import Foundation

protocol HomeBusinessLogic{

}


final class HomeInteractor: HomeBusinessLogic {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
}
