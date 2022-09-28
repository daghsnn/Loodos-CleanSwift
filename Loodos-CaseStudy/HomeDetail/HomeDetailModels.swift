//
//  HomeDetailModels.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 28.09.2022.
//

import Foundation

struct HomeDetailRequestModel:Encodable{
    var i:String?
    
    var dictionary:[String:Any] {
        var dictionary = [String:Any]()
        if let i = i {
            dictionary = ["i":i ] as [String : Any]
        }
        return dictionary
    }
}
