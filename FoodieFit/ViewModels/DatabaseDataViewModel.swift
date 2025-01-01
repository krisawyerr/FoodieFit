//
//  DatabaseData.swift
//  FoodieFit
//
//  Created by Kris Sawyerr on 12/31/24.
//

import Foundation

class DatabaseData {
    static let shared = DatabaseData()
    
    private init() {}
    
    var categories: [Category] = []
    var featuredItems: [Product] = []
    
    func fetchProductData() {
        guard let categoriesFile = Bundle.main.url(forResource: "Categories", withExtension: "json"),
              let featuredFile = Bundle.main.url(forResource: "Featured", withExtension: "json") else {
            return
        }
        
        do {
            let categoriesData = try Data(contentsOf: categoriesFile)
            let featuredData = try Data(contentsOf: featuredFile)
            
            self.categories = try JSONDecoder().decode([Category].self, from: categoriesData)
            self.featuredItems = try JSONDecoder().decode([Product].self, from: featuredData)
            
            print("Product data loaded")
        } catch {
            print("Error decoding JSON: \(error)")
            return
        }
    }
}
