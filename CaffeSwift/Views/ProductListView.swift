//
//  ProductListView.swift
//  CaffeSwift
//

import SwiftUI

struct ProductListView: View {
    let products: [Product] = Bundle.main.decode("products.json")
    @EnvironmentObject var orderViewModel: OrderViewModel
    @State private var showSheet = false
    @State var cellSelected: Int?
    
    @Environment(\.deepLink) var deepLink
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List {
                    ForEach(0..<products.count, id: \.self) { index in
                        NavigationLink(
                            destination: ProductDetailView(
                                product: products[index]),
                            tag: index,
                            selection: $cellSelected
                        ) {
                            ProductView(product: products[index])
                                .onTapGesture {
                                    cellSelected = index
                                }
                        }
                    }
                }
                .onChange(of: deepLink) { deepLink in
                    guard let deepLink = deepLink else {
                        return
                    }
                    switch deepLink {
                    case .details(let reference):
                        if let index = products.firstIndex(where: {
                            $0.reference == reference
                        }) {
                            proxy.scrollTo(index, anchor: .bottom)
                            cellSelected = index
                        }
                    case .home:
                        break
                    }
                }
            }
            .navigationBarTitle("Caffe Swift")
            .toolbar {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "cart.fill")
                        .accentColor(Color("secondary"))
                }
            }
            .sheet(isPresented: $showSheet) {
                NavigationView {
                    CartView(showSheet: $showSheet)
                        .environmentObject(orderViewModel)
                }
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
