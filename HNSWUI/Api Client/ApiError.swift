//
//  ApiError.swift
//  FilmProject
//
//  Created by Emir on 28.08.2020.
//  Copyright © 2020 Emir Beytekin. All rights reserved.
//

import UIKit

final class APIError: Error {
    let type: APIErrorType
    let message: String
    
    init(with type: APIErrorType, message: String) {
        self.type = type
        self.message = message
    }
}


final class ErrorResponse: Codable {
    let message: [String]?
    let success: Bool?

    public init(message: [String]?, success: Bool?) {
        self.message = message
        self.success = success
    }

    
}
