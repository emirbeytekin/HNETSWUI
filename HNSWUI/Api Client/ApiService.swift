//
//  ApiService.swift
//  FilmProject
//
//  Created by Emir on 27.08.2020.
//  Copyright © 2020 Emir Beytekin. All rights reserved.
//

import UIKit
import RxSwift
import RxAlamofire
import Alamofire

class ApiService: ApiClient {
    
    func getHomeFeed() -> Single<BaseResponse<HomeFeedResponse>?> {
        let response = try! JSONDecoder().decode(BaseResponse<HomeFeedResponse>.self, from: HomeCacheJSON().data)
        return Single.just(response)
    }

}

enum AppEndPoint: String {
    
    case search = "/"
    
    var url: URL {
        return URL(string: Config.baseURL + self.rawValue)!
    }
}

class ApiClient : NSObject {
    
    private let manager = HTTPManager.shared
    private var headers: [String: String] = ["Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"]
    private var jsonHeaders: [String: String] = ["Content-Type": "application/json; charset=UTF-8"]
    private var emptyHeaders = [String: String]()
    private let SUCCESS = 200
    
//    var alertManager = AlertManager.shared
    
    enum ApiServiceHeaderType {
        case none(customHeader : [String : String]? = nil)
        
        func getHeaders() -> [String  : String] {
            var apiHeader = [String : String]()
            switch self
            {
            case .none(customHeader: let customHeader):
                customHeader?.forEach { apiHeader[$0] = $1 }
            }
            return apiHeader
        }
    }
        
    fileprivate func request<T: Codable>(methodType: HTTPMethod, url: URL, parameters: [String: Any]? = nil, encoding : ParameterEncoding = JSONEncoding.default, headerType : ApiServiceHeaderType, needCacheResponse : Bool = false) -> Single<T?> {
            
            URLCache.shared.removeAllCachedResponses()
        
//            alertManager.checkConnection()
            
            let currentTime = Date()
            
            let apiHeader = headerType.getHeaders()
            
            let request = manager.rx.request(methodType, url, parameters: parameters, encoding: encoding, headers: apiHeader)
                .asObservable()
                .validate(statusCode: [200 , 201 , 202 ,  203 , 204 , 300, 500])
                .responseString()
                .asSingle()
                .flatMap { json -> Single<T?> in
                    let statusCode = json.0.statusCode
                    let jsonString = json.1
                    guard let data = jsonString.data(using: .utf8) else { return Single.just(nil) }
                    let executionTime = Date().timeIntervalSince(currentTime)
                    print("Api URL : " + url.absoluteString + " Duration : \(executionTime)")
                    print("Api Params : \(String(describing: parameters))")
                    print("Headers data: \(apiHeader)")
                    print("Comin data: \(jsonString)")
                    
                    if statusCode == self.SUCCESS || statusCode == 201 || statusCode == 204 {
                        do {
                            let response = try JSONDecoder().decode(T.self, from: data)
                            return Single.just(response)
                        } catch  {
                            print(error)
                            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                            let errorType = APIErrorType.badRequest
                            let customError = APIError(with: errorType, message: errorResponse.message?[0] ?? "--")
                            return Single.error(customError)
                        }
                    }
                    
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    let errorType = APIErrorType.badRequest
                    let error = APIError(with: errorType, message : errorResponse.message?[0] ?? "--")
                    return Single.error(error)
            }
            
            return request

        }
}


enum APIErrorType: Int, Error {
    /// Status code 400
    case badRequest = 400
    
    /// Status code 403
    case forbidden = 403
    
    /// Status code 406
    case notAcceptable = 406
    
    /// Standart status code 204 but we use 417 for return result
    case noContent = 417
    
    /// Unknown error occured
    case unknown = -1
    
    /// Mapping error occured
    case mapping = 0
    
    static let allValues = [badRequest, forbidden, notAcceptable, noContent, unknown, mapping]
}




