//
//  HomeModels.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 26.09.2022.
//

import Foundation


struct HomeRequestModel:Encodable{
    let page:Int?
    let s:String?
    
    var dictionary:[String:Any] {
        var dictionary = [String:Any]()
        if let page = page, let s = s {
            dictionary = ["page" : page, "s":s ] as [String : Any]
        }
        return dictionary
    }
}

struct HomeResponseModel: Codable {
    let search: [HomeModel]?
    let totalResults, response: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

struct HomeModel: Codable {
    let title, year, imdbID, poster, type: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

