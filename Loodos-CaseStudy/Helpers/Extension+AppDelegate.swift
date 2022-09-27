//
//  Extension+AppDelegate.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 27.09.2022.
//
import IQKeyboardManagerSwift

extension AppDelegate {
    
    func configureIQKeyboardManager(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
