//
//  LottieHud.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//

import UIKit
import Lottie

final class LottieHud {
    
    static let shared = LottieHud()
    
    lazy var activityView : AnimationView = {
        let animation = AnimationView(name: "loading")
        animation.animationSpeed = 0.5
        animation.contentMode = .scaleAspectFill
        animation.loopMode = .loop
        animation.play()
        return animation
    }()
    
    private init(){}
    
    func show(){
        let windowsFirst = UIApplication.shared.windows.first { $0.isKeyWindow }
        guard let window = windowsFirst else { return }
        window.addSubview(activityView)
        activityView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        activityView.play()
    }
    
    func hide(){
        UIView.animate(withDuration: 0.4, delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: .curveLinear, animations: {
            self.activityView.removeFromSuperview()
        })
    }
}
