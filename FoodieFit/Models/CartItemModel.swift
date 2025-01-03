//
//  CartItemModel.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 1/2/25.
//

struct CartItem: Decodable {
    var name: String
    var price: Float
    var quantity: Int
}
