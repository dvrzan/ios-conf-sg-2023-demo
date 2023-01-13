//
//  CaffeSwiftApp.swift
//  CaffeSwift
//

import SwiftUI
import Firebase

@main
struct CaffeSwiftApp: App {
    var orderViewModel = OrderViewModel()
    @State var deepLink: DeepLinkHandler.DeepLink?
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ProductListView()
                .environmentObject(orderViewModel)
                .onOpenURL { url in
                    print("Incoming URL parameter is: \(url)")
                    let linkHandled = DynamicLinks.dynamicLinks()
                        .handleUniversalLink(url) { dynamicLink, error in
                            guard error == nil else {
                                fatalError("Error handling the incoming dynamic link.")
                            }
                            if let dynamicLink = dynamicLink {
                                // Handle Dynamic Link
                                self.handleDynamicLink(dynamicLink)
                            }
                        }
                    if linkHandled {
                        print("Link Handled")
                    } else {
                        print("No Link Handled")
                    }
                }
                .environment(\.deepLink, deepLink)
        }
    }
    
    // MARK: - Functions
    // Handle incoming dynamic link
    func handleDynamicLink(_ dynamicLink: DynamicLink) {
        guard let url = dynamicLink.url else {
            return
        }
        
        print("Dynamic link: \(url.absoluteString)")
        guard
            dynamicLink.matchType == .unique ||
            dynamicLink.matchType == .default
        else {
            return
        }

        let deepLinkHandler = DeepLinkHandler()
        guard let deepLink = deepLinkHandler.parseComponents(from: url) else {
            return
        }
        self.deepLink = deepLink
        
        print("Deep link: \(deepLink)")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.deepLink = nil
        }
    }
}
