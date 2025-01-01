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
    
    func fetchCategories() {
        guard let file = Bundle.main.url(forResource: "Categories", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: file)
            self.categories = try JSONDecoder().decode([Category].self, from: data)
            print("Cats loaded")
        } catch {
            print("Error decoding JSON: \(error)")
            return
        }
    }
}
