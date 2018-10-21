//
//  RoomType.swift
//  Hotel Manzana
//
//  Created by Evgeniy Ryshkov on 21/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import Foundation

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
