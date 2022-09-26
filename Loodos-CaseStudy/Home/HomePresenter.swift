//
//  HomePresenter.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 26.09.2022.
//

import UIKit

protocol HomePresentationLogic : AnyObject {
//    func presentSomething(response: Home.Something.Response)
}

final class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
}
