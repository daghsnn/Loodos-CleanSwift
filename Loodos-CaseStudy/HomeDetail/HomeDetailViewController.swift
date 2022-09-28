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
    
    private lazy var backButton : UIButton = {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        backButton.contentMode = .scaleAspectFill
        backButton.tintColor = UIColor(named: "redTint")!.withAlphaComponent(0.7)
        return backButton
    }()
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
    
    private func configureNavBar(){
        navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor(named: "redTint")!.withAlphaComponent(0.7)]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.isOpaque = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = UIColor(named: "backgroundColor")
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc private func backButtonClicked(){
        router?.dismissNavigation()
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
        navigationItem.title = model.title
        viewPage.model = model
    }
    
    func handleError(_ message: String) {
        self.showToast(message: message, backGroundColor: .red)
    }
    
    
}
