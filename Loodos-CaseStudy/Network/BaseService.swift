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
    var baseUrl : String { get }
    var method : Alamofire.HTTPMethod{ get}
    var encoding : Alamofire.ParameterEncoding?{ get }
    var headers : HTTPHeaders { get }
    var params : Parameters? {get set}
}

class BaseService : APIConfiguration {
    
    var baseUrl: String = NetworkConstants.baseUrl
    var headers: HTTPHeaders = HTTPHeaders.default
    var params: Parameters?
    var encoding: ParameterEncoding? = URLEncoding.default
    var method: HTTPMethod = .get
    var path: String?
    
    @discardableResult
    func addParameterToUrlPath(_ parameterString : String) -> Self {
        if let path = path {
            self.path = path + "\(parameterString)"
        }
        return self
    }
    
    
    func sendRequest(completion: @escaping(Data?, ErrorType?) -> Void ) {
        if NetworkListener.shared.isConnected {
            showLoading()
        } else {
            completion(nil,.unReachable)
        }
        if let path = path {
            baseUrl += path
        }
        
        AF.request(baseUrl,method: self.method,parameters: self.params,encoding: self.encoding!, headers: self.headers).responseJSON { (response) in
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
