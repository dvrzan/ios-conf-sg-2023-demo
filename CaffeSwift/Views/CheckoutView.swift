//
//  CheckoutView.swift
//  CaffeSwift
//

import SwiftUI

struct CheckoutView: View {
    static let paymentTypes = ["Cash", "Credit Card", "Cocoabucks Points"]
    static let tipAmounts = [10, 15, 20, 0]
    
    @EnvironmentObject var orderViewModel: OrderViewModel
    @Environment(\.dismiss) var dismiss
    
    var totalPrice: Double {
        let total = Double(orderViewModel.total)
        let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }
    
    @State private var paymentType = 0
    @State private var showLoyaltyCardDetails = false
    @State private var loyaltyCardNumber = ""
    @State private var tipAmount = 1
    @State private var showAlert = false
    @Binding var showSheet: Bool
    
    var body: some View {
        Form {
            Section {
                Picker("Choose your payment option", selection: $paymentType) {
                    ForEach(0 ..< Self.paymentTypes.count, id: \.self) {
                        Text(Self.paymentTypes[$0])
                    }
                }
                Toggle(isOn: $showLoyaltyCardDetails.animation()) {
                    Text("Add loyalty card")
                }
                if showLoyaltyCardDetails {
                    TextField("Enter loyalty card number", text: $loyaltyCardNumber)
                }
                
                Section(header: Text("Add a tip?")) {
                    Picker("Percentage:", selection: $tipAmount) {
                        ForEach(0 ..< Self.tipAmounts.count, id: \.self) {
                            Text("\(Self.tipAmounts[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("TOTAL: $\(totalPrice, specifier: "%.2f")").font(.largeTitle)) {
                    Button(action: {
                        showAlert.toggle()
                        orderViewModel.products.removeAll()
                    }, label: {
                        Text("Confirm Order")
                    })
                }
            }
        }
        .accentColor(Color("secondary"))
        .navigationBarTitle(Text("Order"), displayMode: .inline)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Order confirmed"),
                message: Text("Your order has been placed!"),
                dismissButton: .cancel(Text("Awesome")) {
                    showSheet = false
                    dismiss()
                }
            )
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let orderViewModel = OrderViewModel()
    static var previews: some View {
        CheckoutView(showSheet: .constant(true))
            .environmentObject(orderViewModel)
    }
}
