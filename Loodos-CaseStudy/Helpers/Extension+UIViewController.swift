//
//  Extension+UIViewController.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//

import UIKit

extension UIViewController {
    
    func showConfigError(message : String, backGroundColor: UIColor) {
        
        let toastLabel = UILabel()
        toastLabel.backgroundColor = backGroundColor
        toastLabel.textColor = UIColor(named: "textColor")
        toastLabel.font = UIFont.boldSystemFont(ofSize: 14)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        toastLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func showToast(message : String, backGroundColor: UIColor) {
        
        let toastLabel = UILabel()
        toastLabel.backgroundColor = backGroundColor
        toastLabel.textColor = UIColor(named: "textColor")
        toastLabel.font = UIFont.boldSystemFont(ofSize: 14)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        toastLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
