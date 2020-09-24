//
//  HomeFeed.swift
//  RxMvvm
//
//  Created by Emir on 19.01.2020.
//  Copyright © 2020 Emir Beytekin. All rights reserved.
//

import UIKit

class EmptyResponse: Codable {

    let code: Int?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case message
        case code
    }

    init(message : String?, code : Int?) {
        self.message = message
        self.code = code
    }
}

class HomeFeedResponse: Codable {
    
    var categories: [Categories]?
    var campaigns: [Campaigns]?
    var weeksDeals: [WeeksDeals]?
    
    var recipes: [WeeksRecipes]?

    init(categories: [Categories]?, campaigns: [Campaigns]?, weeksDeals: [WeeksDeals]?, recipes: [WeeksRecipes]?) {
        self.categories = categories
        self.campaigns = campaigns
        self.weeksDeals = weeksDeals
        self.recipes = recipes
    }
    
    init() {
        self.campaigns = nil
        self.categories = nil
        self.weeksDeals = nil
        self.recipes = nil
    }
}

class WeeksRecipes: Codable {
    var id: String?
    var title: String?
    var imageUrl: String?
    var duration: String?
    var service: String?
    var shareCode: String?
    var createTime: String?
    var price: String?
    var user: String?
    var videoUrl: String?
    var coverUrl: String?

    init(id: String?, title: String?, imageUrl: String?, duration: String?, service: String?, shareCode: String?, createTime: String?, price: String?, user: String?, videoUrl: String?, coverUrl: String?) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.duration = duration
        self.service = service
        self.shareCode = shareCode
        self.createTime = createTime
        self.price = price
        self.user = user
        self.videoUrl = videoUrl
        self.coverUrl = coverUrl
    }
    init() {
        self.id = nil
        self.title = nil
        self.imageUrl = nil
        self.duration = nil
        self.service = nil
        self.shareCode = nil
        self.createTime = nil
        self.price = nil
        self.user = nil
        self.videoUrl = nil
        self.coverUrl = nil
    }
}

class WeeksDeals: Codable {
    var id: String?
    var categoryId: String?
    var productCategoryId: String?
    var price: String?
    var storeLogo: String?
    var imageUrl: String?
    var productTitle: String?
    var categoryTitle: String?

    init(id: String?, categoryId: String?, productCategoryId: String?, price: String?, storeLogo: String?, imageUrl: String?, productTitle: String?, categoryTitle: String?) {
        self.id = id
        self.categoryId = categoryId
        self.productCategoryId = productCategoryId
        self.price = price
        self.storeLogo = storeLogo
        self.imageUrl = imageUrl
        self.productTitle = productTitle
        self.categoryTitle = categoryTitle
    }
    
    init() {
        self.id = nil
        self.categoryId = nil
        self.productCategoryId = nil
        self.price = nil
        self.storeLogo = nil
        self.imageUrl = nil
        self.productTitle = nil
        self.categoryTitle = nil
    }

    
    
}

class CampaignContents: Codable {
    var id: String?
    var imageUrl: String?
    var sortOrder: Int?
    var status: Bool?

    init(id: String?, imageUrl: String?, sortOrder: Int?, status: Bool?) {
        self.id = id
        self.imageUrl = imageUrl
        self.sortOrder = sortOrder
        self.status = status
    }
}

class CampaignDetailResponse: Codable {
    var id: String?
    var storeId: String?
    var status: Bool?
    var title: String?
    var imageUrl: String?
    var documentUrl: String?
    var document: String?
    var pageCount: Int?
    var startDate: String?
    var endDate: String?
    var endDateFormatted: String?
    var createTime: String?
    var campaignContents: [CampaignContents]?

    init(id: String?, storeId: String?, status: Bool?, title: String?, imageUrl: String?, documentUrl: String?, document: String?, pageCount: Int?, startDate: String?, endDate: String?, endDateFormatted: String?, createTime: String?, campaignContents: [CampaignContents]?) {
        self.id = id
        self.storeId = storeId
        self.status = status
        self.title = title
        self.imageUrl = imageUrl
        self.documentUrl = documentUrl
        self.document = document
        self.pageCount = pageCount
        self.startDate = startDate
        self.endDate = endDate
        self.endDateFormatted = endDateFormatted
        self.createTime = createTime
        self.campaignContents = campaignContents
    }
}

class Campaigns: Codable {
    
    var id: String?
    var store: String?
    var status: Bool?
    var title: String?
    var imageUrl: String?
    var documentUrl: String?
    var pageCount: Int?
    var dayLeft: String?
    var dayLeftColor: String?
    var date: String?
    
    init() {
        self.id          = nil
        self.store       = nil
        self.status      = nil
        self.title       = nil
        self.imageUrl    = nil
        self.documentUrl = nil
        self.pageCount   = nil
        self.dayLeft     = nil
        self.date        = nil
    }

    init(id: String?, store: String?, status: Bool?, title: String?, imageUrl: String?, documentUrl: String?, pageCount: Int?, dayLeft: String?, dayLeftColor: String?, date: String?) {
        self.id             = id
        self.store          = store
        self.status         = status
        self.title          = title
        self.imageUrl       = imageUrl
        self.documentUrl    = documentUrl
        self.pageCount      = pageCount
        self.dayLeft        = dayLeft
        self.dayLeftColor   = dayLeftColor
        self.date           = date
    }
}

class Categories: Codable {
    
    var id: String?
    var title: String?
    var imageUrl: String?
    var status: Bool?
    var sortOrder: Int?
    var image: String?
    var isSelected: Bool?

    init(id: String?, title: String?, imageUrl: String?, status: Bool?, sortOrder: Int?, image: String?, isSelected: Bool?) {
        self.id = id
        self.title          = title
        self.imageUrl       = imageUrl
        self.status         = status
        self.sortOrder      = sortOrder
        self.image          = image
        self.isSelected     = isSelected
    }
    
    init() {
        self.id         = ""
        self.title      = ""
        self.imageUrl   = ""
        self.status     = false
        self.sortOrder  = 0
        self.image      = ""
        self.isSelected = false
    }
}
