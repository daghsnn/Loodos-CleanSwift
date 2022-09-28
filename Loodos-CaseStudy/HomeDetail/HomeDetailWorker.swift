//
//  HomeDetailWorker.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 28.09.2022.
//

import UIKit

final class HomeDetailWorker{
    func getDetails(request:HomeDetailRequestModel, completion: @escaping (HomeModel?, ErrorType?) ->()){
        let service = BaseService.shared
        service.params = request.dictionary
        service.sendRequest { (data, error) in
            if let error = error {
                completion(nil, ErrorType.some(error.localizedDescription))
            }
            if let data = data {
                do {
                    let homeModel = try JSONDecoder().decode(HomeModel.self, from: data)
                    completion(homeModel,nil)
                } catch {
                    completion(nil, ErrorType.some(error.localizedDescription))
                }
                
            }
        }
    }
}
