//
//  SplashWorker.swift
//  Loodos-CaseStudy
//
//  Created by Hasan Dag on 25.09.2022.
// 

import UIKit
import FirebaseRemoteConfig

final class SplashWorker {
    func getFirebaseRemoteConfig(_ completion: @escaping (String?, ErrorType?) ->()) {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                remoteConfig.activate { changed, error in
                    completion(remoteConfig.configValue(forKey: "loodosText").stringValue,nil)
                }
            } else {
                completion(nil, ErrorType.some(error?.localizedDescription ?? ""))
            }
        }
    }
}
