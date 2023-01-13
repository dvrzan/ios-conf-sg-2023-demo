//
//  Product.swift
//  CaffeSwift
//

import Foundation

struct Product: Codable, Equatable, Identifiable, Hashable {
    var id = UUID()
    let reference: String
    let name: String
    let price: Double
    let image: String
    let calories: Int
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case reference, name, price, image, calories, description
    }
    
#if DEBUG
    static let example = Product(
        reference: "001-567",
        name: "Chocolate Chip Cookie",
        price: 0.99,
        image: "chocolate-chip-cookie",
        calories: 238,
        description: "Perfectly sweet.")
#endif
}
