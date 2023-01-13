//
//  CartView.swift
//  CaffeSwift
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var orderViewModel: OrderViewModel
    @Binding var showSheet: Bool
    
    var body: some View {
        List {
            Section {
                ForEach(orderViewModel.products) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Text("$\(item.price, specifier: "%.2f")")
                    }
                }
                .onDelete(perform: orderViewModel.deleteItems)
            }
            Section {
                NavigationLink(
                    destination: CheckoutView(showSheet: $showSheet)) {
                        Text("Place Order")
                    }
            }
            .disabled(orderViewModel.products.isEmpty)
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Cart")
        .toolbar {
            if orderViewModel.products.count != 0 {
                EditButton()
            }
        }
    }
    
    // MARK: - Functions
    // Delete items
    func deleteItems(at offsets: IndexSet) {
        orderViewModel.products.remove(atOffsets: offsets)
    }
}

struct CartView_Previews: PreviewProvider {
    static let orderViewModel = OrderViewModel()
    static var previews: some View {
        NavigationView {
            CartView(showSheet: .constant(true))
                .environmentObject(orderViewModel)
        }
    }
}
