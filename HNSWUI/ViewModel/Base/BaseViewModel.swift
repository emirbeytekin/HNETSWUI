//
//  BaseResponse.swift
//  RxMvvm
//
//  Created by Emir Beytekin on 7/14/19.
//  Copyright © 2019 Emir Beytekin. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewModel {
    let disposeBag = DisposeBag()
    var isLoading : Variable<Bool?> = Variable(nil)
}

final class BaseResponse<T : Codable>: Codable {
    
    let code: Int?
    let message: [String]?
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
    }
    
    public init(code: Int?, message: [String]?, data: T?) {
        self.code = code
        self.message = message
        self.data = data
    }
    
    init() {
        self.code = nil
        self.message = nil
        self.data = nil
    }
}

class Message: Codable {
    
    let type: AlertType?
    let title: String?
    let content: String?
    let action: String?

    init(type: AlertType?, title: String?, content: String?, action: String?) {
        self.type = type
        self.title = title
        self.content = content
        self.action = action
    }
    
    enum AlertType : String , Codable{
        case successToast = "1"
        case errorToast = "2"
        case successPopup = "3"
        case errorPopup = "4"
        case newConfirm = "5"
    }
}


class BaseModel : Codable {
    
}

class SuccessMessageModel : Codable {
    var message : String?
}
