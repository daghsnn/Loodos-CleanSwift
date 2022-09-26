//
//  HomeWorker.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 26.09.2022.
//

import Foundation

final class HomeWorker {
    
    func getMovies(request:HomeRequestModel, completion: @escaping (HomeResponseModel?, ErrorType?) ->()){
        let service = BaseService.shared
        service.params = request.dictionary
        service.sendRequest { (data, error) in
            if let error = error {
                completion(nil, ErrorType.some(error.localizedDescription))
            }
            if let data = data {
                do {
                    let homeResponseModel = try JSONDecoder().decode(HomeResponseModel.self, from: data)
                    completion(homeResponseModel,nil)
                } catch {
                    completion(nil, ErrorType.some(error.localizedDescription))
                }
                
            }
        }
    }
}
