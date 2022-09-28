//
//  HomeRouter.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 26.09.2022.
//  

import UIKit
protocol HomeRoutingLogic{
    func routeToDetailScreen(_ id:String)
}


final class HomeRouter: HomeRoutingLogic {
    weak var viewController: HomeViewController?
    func routeToDetailScreen(_ id: String) {
        let destination = HomeDetailViewController()
        destination.requestModel = HomeDetailRequestModel(i: id)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
    
}
