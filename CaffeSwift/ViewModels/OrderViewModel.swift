//
//  OrderViewModel.swift
//  CaffeSwift
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    var total: Double {
        return products.reduce(0) { $0 + $1.price }
    }
    
    func add(product: Product) {
        products.append(product)
    }
    
    func remove(product: Product) {
        if let index = products.firstIndex(of: product) {
            products.remove(at: index)
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        products.remove(atOffsets: offsets)
    }
}
