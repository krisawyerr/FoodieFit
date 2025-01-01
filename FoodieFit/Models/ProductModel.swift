//
//  ProductModel.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

struct Product: Decodable {
    var status: String
    var image_url: String
    var name: String
    var price: Float
}
