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
}
protocol BaseRequestProtocol: Encodable {
    
}

struct BaseRequestModel : BaseRequestProtocol {
    
}

struct BaseResponseModel: Codable {
    
}

protocol APIConfiguration {
    associatedtype RequestModel
    var requestModel : RequestModel { get }
    var baseUrl : String { get }
    var method : Alamofire.HTTPMethod{ get}
    var encoding : Alamofire.ParameterEncoding?{ get }
    var headers : HTTPHeaders { get }
}

class BaseService <BaseRequestModel:BaseRequestProtocol, BaseResponseModel: Decodable > : APIConfiguration {
    
    typealias ResultBlock = (Swift.Result<BaseResponseModel, ErrorType>) -> ()
    typealias responseModel = BaseResponseModel
    
    private var resultBlock: ResultBlock!
    
    var requestModel: BaseRequestModel?

    var baseUrl: String = NetworkConstants.baseUrl
    var headers: HTTPHeaders = HTTPHeaders.default
    var encoding: ParameterEncoding? = URLEncoding.httpBody
    var method: HTTPMethod = .get
    var path: String?
    
    @discardableResult
    func addParameterToUrlPath(_ parameterString : String) -> Self {
        if let path = path {
            self.path = path + "\(parameterString)"
        }
        return self
    }
 
    func response(resultBlock: @escaping ResultBlock) {
        self.resultBlock = resultBlock
        configureRequest()
    }
  
    private func configureRequest() {
        if NetworkListener.shared.isConnected {
            showLoading()
            sendRequest()
        } else {
            let windowsFirst = UIApplication.shared.windows.first { $0.isKeyWindow }
            guard let window = windowsFirst?.rootViewController?.presentedViewController else { return }
            window.showConfigError(message: "Network hatası", backGroundColor: UIColor.red)
        }
    }
    
    private func sendRequest() {
        if let path = path {
            baseUrl += path
        }
        AF.request(baseUrl,method: self.method,encoding: self.encoding!, headers: self.headers).responseJSON { (response) in
            guard let data = response.data else { return}
            self.hideLoading()
            do {
                let baseResponse = try JSONDecoder().decode(BaseResponseModel.self, from: data)
                self.resultBlock(.success(baseResponse))
            } catch  {
                self.resultBlock(.failure(.decoding))
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
