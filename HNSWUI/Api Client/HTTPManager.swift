//
//  HTTPManager.swift
//  FilmProject
//
//  Created by Emir on 28.08.2020.
//  Copyright © 2020 Emir Beytekin. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire


final class HTTPManager: Alamofire.SessionManager {

    static let shared: HTTPManager = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        let manager = HTTPManager(configuration: configuration)
        return manager
    }()
}
