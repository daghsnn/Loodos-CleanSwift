//
//  SplashViewController.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
// 

import UIKit
import Lottie

protocol SplashDisplayLogic: AnyObject {
    func configureUI()
    func handleError()
}

final class SplashViewController: UIViewController {
    var interactor: SplashBusinessLogic?
    var router: SplashRoutingLogic?
    
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

        print(Bundle.main.object(forInfoDictionaryKey: "ApiKey") as! String)
        view.backgroundColor = UIColor(named: "backgroundColor")
        LottieHud.shared.show()

    }
    
    private func checkNetwork(){
        if NetworkListener.shared.isConnected {
            self.interactor?.getFirebaseConfiguration()
        } else {
            handleError()
        }

    }

}
// MARK:- Display Logic
extension SplashViewController: SplashDisplayLogic {
    func configureUI() {
        // Remote config req
    }
    
    func handleError() {
        // display error
    }

}
