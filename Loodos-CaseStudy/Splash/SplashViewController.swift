//
//  SplashViewController.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
// 

import UIKit
import Lottie

protocol SplashDisplayLogic: AnyObject {
    func displaySomething()
}

final class SplashViewController: UIViewController, SplashDisplayLogic {
    weak var interactor: SplashBusinessLogic?
    weak var router: SplashRoutingLogic?
        
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
        doSomething()
        view.backgroundColor = UIColor(named: "backgroundColor")
        let animation = AnimationView(name: "loading")
        animation.animationSpeed = 0.5
        animation.loopMode = .loop
        animation.play()
        view.addSubview(animation)
        animation.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
    
    func doSomething(){
        //    let request = Splash.Something.Request()
        //    interactor?.doSomething(request: request)
    }
    
    func displaySomething(){
        //nameTextField.text = viewModel.name
    }
}
