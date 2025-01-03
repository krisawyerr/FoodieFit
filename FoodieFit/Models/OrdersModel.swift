//
//  OrdersModel.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/2/25.
//

import Foundation

struct Orders: Decodable {
    var items: [CartItem]
    var total: Float
    var date: String
}
