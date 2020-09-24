//
//  HomeViewModel.swift
//  HNSWUI
//
//  Created by Emir on 17.09.2020.
//  Copyright © 2020 Emir Beytekin. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewModel: BaseViewModel {
    
    let service: ApiService
    var resp: HomeFeedResponse?
    
    init(service: ApiService = ApiService()) {
        self.service = service
    }
    
    func getHomeFeed() -> Single<BaseResponse<HomeFeedResponse>?> {
        return service.getHomeFeed().do(onSuccess: { (response) in
            guard let response = response else { return }
            if let val = response.data {
                print(val)
                self.resp = val
            }
        })
    }

}
