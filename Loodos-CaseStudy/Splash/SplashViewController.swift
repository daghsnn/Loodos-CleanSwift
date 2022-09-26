//
//  SplashViewController.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
// 

import UIKit

protocol SplashDisplayLogic: AnyObject {
    func configureSplashText(_ text:String)
    func handleError(_ message:String)
}

final class SplashViewController: UIViewController {
    var interactor: SplashBusinessLogic?
    var router: SplashRoutingLogic?
    
    private lazy var mainLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "blueTint")
        label.makeShadow(color: UIColor(named: "blueTint") ?? .systemBlue, offSet: CGSize(width: 0, height: 4), radius: 5, opacity: 0.7)
        return label
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let interactor = SplashInteractor()
        let presenter = SplashPresenter()
        let router = SplashRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        checkNetwork()
        configureUI()
    }
    
    private func checkNetwork(){
        if NetworkListener.shared.isConnected {
            LottieHud.shared.show()
            self.interactor?.getFirebaseConfiguration()
        } else {
            handleError("hata")
        }
    }
    
    private func configureUI(){
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
// MARK:- Display Logic
extension SplashViewController: SplashDisplayLogic {
    func configureSplashText(_ text:String) {
        DispatchQueue.main.async {
            LottieHud.shared.hide()
            self.mainLabel.text = text
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.router?.routeToHomeScreen()
        }
    }
    
    func handleError(_ message:String) {
        showConfigError(message: message, backGroundColor: .red)
    }

}
