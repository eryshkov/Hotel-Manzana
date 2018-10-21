//
//  Rooms.swift
//  Hotel Manzana
//
//  Created by Evgeniy Ryshkov on 21/10/2018.
//  Copyright © 2018 Evgeniy Ryshkov. All rights reserved.
//

import Foundation

struct Rooms {
    static var content = Rooms()
    
    var rooms = [RoomType]()
    
    private init() {
        rooms.append(RoomType(id: 1, name: "Single room", shortName: "Single", price: 100))
        rooms.append(RoomType(id: 2, name: "Double room", shortName: "Double", price: 200))
        rooms.append(RoomType(id: 3, name: "Family room", shortName: "Family", price: 300))
        rooms.append(RoomType(id: 4, name: "Surerior Double room", shortName: "Surerior Double", price: 250))
        rooms.append(RoomType(id: 5, name: "Deluxe Single room", shortName: "Deluxe Single", price: 350))
        rooms.append(RoomType(id: 6, name: "Pent House room", shortName: "Pent House", price: 400))
    }
}
