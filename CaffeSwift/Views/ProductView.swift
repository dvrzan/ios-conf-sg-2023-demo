//
//  ProductView.swift
//  CaffeSwift
//

import SwiftUI

struct ProductView: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: 10) {
            Image(product.image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 50)
                .cornerRadius(12.0)
            
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text("$\(product.price, specifier: "%.2f")")
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: Product.example)
    }
}
