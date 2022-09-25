//
//  NetworkListener.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
//
import Alamofire

final class NetworkListener {
    
    static let shared : NetworkListener = NetworkListener()
    var isConnected: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
