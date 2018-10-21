//
//  Registration.swift
//  Hotel Manzana
//
//  Created by Evgeniy Ryshkov on 20/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wiFi: Bool
}

struct RoomType {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
}

extension RoomType: Equatable {
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
    
}

