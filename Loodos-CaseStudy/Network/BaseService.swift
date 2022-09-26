//
//  BaseService.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//

import Alamofire

enum ErrorType: Error {
    case unReachable
    case decoding
    case some(String)
}

protocol APIConfiguration {
    var method : Alamofire.HTTPMethod{ get}
    var encoding : Alamofire.ParameterEncoding?{ get }
    var headers : HTTPHeaders { get }
    var params : Parameters? {get set}
}

class BaseService : APIConfiguration {
    static let shared = BaseService()
    var headers: HTTPHeaders = HTTPHeaders.default
    var params: Parameters?
    var encoding: ParameterEncoding? = URLEncoding.default
    var method: HTTPMethod = .get
    
    private init(){}
    func sendRequest(completion: @escaping(Data?, ErrorType?) -> Void ) {
        if NetworkListener.shared.isConnected {
            showLoading()
        } else {
            completion(nil,.unReachable)
        }

        guard let url = URL(string: String(format: "%@?apikey=%@", NetworkConstants.baseUrl, NetworkConstants.apiKey)) else {return}
        
        AF.request(url,method: self.method,parameters: self.params,encoding: self.encoding!, headers: self.headers).responseJSON { (response) in
            if let statusCode = response.response?.statusCode {
                self.hideLoading()
                switch statusCode {
                case 200...299:
                    if let data = response.data {
                        completion(data, nil)
                    }
                default:
                    completion(nil,ErrorType.unReachable)
                }
            }
        }
    }
    
    private func hideLoading(){
        DispatchQueue.main.async {
            LottieHud.shared.hide()
        }
    }
    
    private func showLoading(){
        DispatchQueue.main.async {
            LottieHud.shared.show()
        }
    }
}
