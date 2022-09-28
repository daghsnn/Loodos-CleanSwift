//
//  HomeDetailRouter.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 28.09.2022.
//

import UIKit

protocol HomeDetailRoutingLogic {
    func dismissNavigation()
}

final class HomeDetailRouter: HomeDetailRoutingLogic {
    weak var viewController: HomeDetailViewController?
    func dismissNavigation(){
        viewController?.navigationController?.popViewController(animated: true)
    }

}
