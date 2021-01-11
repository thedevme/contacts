//
//  Constants.swift
//  Contacts
//
//  Created by Craig Clayton on 1/7/21.
//

import Foundation

struct Constants {
    static let limit = "limit"
    static let search = "search"
    static let orderName  = "orders[name]"
    
    enum SortType: String {
        case desc = "DESC"
        case asc = "ASC"
    }
    
    struct ApiKeys {
        static let activeCampaignKey = "9b5d6641aa55e368f678ff47eda44a1fc12e6ee8912ddf92cb381558edbd9af0e91ab449"
        
    }
    
    struct APIPaths {
        static let contacts = "/api/3/contacts"
    }
}
