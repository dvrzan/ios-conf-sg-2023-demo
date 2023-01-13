//
//  ProductDetailView.swift
//  CaffeSwift
//

import SwiftUI
import FirebaseDynamicLinks

struct ProductDetailView: View {
    @EnvironmentObject var orderViewModel: OrderViewModel
    @ObservedObject var dynamicLinkManager = DynamicLinkManager()
    @State private var isShareSheetShowing = false
    
    var product: Product
    let screen = UIScreen.main.bounds

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .frame(width: screen.width, height: 300, alignment: .center)
                .clipped()
            HStack {
                Text("\(product.calories) Cals")
                    .padding()
                Divider()
                Text("$\(product.price, specifier: "%.2f")")
                    .fontWeight(.semibold)
                    .padding()
            }
            .frame(width: screen.width, height: 30, alignment: .center)
            
            Text(product.description)
                .font(.body)
                .foregroundColor(.secondary)
                .padding()
            
            Divider()
            
            Button {
                orderViewModel.add(product: product)
            } label: {
                Text("Add to cart")
                Image(systemName: "cart")
            }
            .font(.title3)
            .padding()
            .foregroundColor(Color("secondary"))
            
            Button {
                dynamicLinkManager.shareDynamicLinkFor(product: product)
            } label: {
                Text("Share")
                Image(systemName: "square.and.arrow.up")
            }
            .font(.title3)
            .padding()
            .foregroundColor(Color("secondary"))
            
            Spacer()
        }
        .navigationBarTitle(Text(product.name), displayMode: .inline)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static let orderViewModel = OrderViewModel()
    static var previews: some View {
        NavigationView {
            ProductDetailView(
                dynamicLinkManager: DynamicLinkManager(),
                product: Product.example
            )
            .environmentObject(orderViewModel)
        }
    }
}
