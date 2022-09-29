//
//  HomeDetailViewController.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 28.09.2022.
//

import UIKit
import FirebaseAnalytics

protocol HomeDetailDisplayLogic: AnyObject{
    func displayModel(_ model:HomeModel)
    func handleError(_ message:String)
}

final class HomeDetailViewController: UIViewController {
    var interactor: HomeDetailBusinessLogic?
    var router: HomeDetailRoutingLogic?
    var requestModel : HomeDetailRequestModel?
    
    // MARK: Object lifecycle
    private var viewPage = HomeDetailView()
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
        let interactor = HomeDetailInteractor()
        let presenter = HomeDetailPresenter()
        let router = HomeDetailRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureNavBar()
        configureUI()
        if let requestModel = requestModel {
            self.interactor?.getDetails(request: requestModel)
        }
    }
    
    private func configureUI(){
        view.addSubview(viewPage)
        viewPage.snp.makeConstraints { $0.edges.equalToSuperview()}
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewPage.didTappedBackButton = {
            self.router?.dismissNavigation()
        }
    }
    
    private func configureNavBar(){
        navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func sendDataToAnalytics(_ params:[String:Any]) {
        Analytics.logEvent("model_logs", parameters: params)
    }

}

extension HomeDetailViewController:HomeDetailDisplayLogic{
    
    func displayModel(_ model: HomeModel) {
        if let params = model.logData {
            sendDataToAnalytics(params)
        }
        viewPage.model = model
    }
    
    func handleError(_ message: String) {
        self.showToast(message: message, backGroundColor: .red)
    }
    
    
}
