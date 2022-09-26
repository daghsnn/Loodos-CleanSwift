//
//  HomeViewController.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 26.09.2022.
//

import UIKit

protocol HomeDisplayLogic: AnyObject{
//    func displaySomething(viewModel: Home.Something.ViewModel)
}

final class HomeViewController: UIViewController{
    var interactor: HomeBusinessLogic?
    var router: HomeRoutingLogic?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup(){
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
    }
    // MARK: View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureUI()

    }
    
    private func configureUI(){
        view.backgroundColor = UIColor(named: "backgroundColor")
    }

}

extension HomeViewController:HomeDisplayLogic {
    
}
