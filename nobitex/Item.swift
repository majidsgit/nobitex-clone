//
//  Item.swift
//  nobitex
//
//  Created by Majid Jamali on 2024/6/4.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
