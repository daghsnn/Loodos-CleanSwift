//
//  HomeModels.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 26.09.2022.
//

import Foundation


struct HomeRequestModel:Encodable{
    var page:Int?
    var s:String?
    
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
    let totalResults, response, serverError: String?
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
        case serverError = "Error"
    }
}

struct HomeModel: Codable {
    let title, year, rated, released, runtime, genre, director, writer, actors, plot, language, country, awards, poster, metascore, imdbRating, imdbVotes, imdbID, type, dvd, boxOffice, production, website, response, serverError: String?
    let ratings: [Rating]?
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        case serverError = "Error"
    }
    
    var logData:[String:Any]? {
        var logData = ["imdbID":imdbID ?? "",
                       "title":title ?? "",
                       "response":response ?? "",
                       "genre":genre,
                       "released":released ?? ""] as? [String : Any]
        return logData
    }
}
struct Rating: Codable {
    let source, value: String?

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}
