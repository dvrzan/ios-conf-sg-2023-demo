//
//  DynamicLinkManager.swift
//  CaffeSwift
//

import Foundation
import FirebaseDynamicLinks
import SwiftUI

@MainActor
class DynamicLinkManager: ObservableObject {
    
    func createDynamicLink(with product: Product) async {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "caffeswift.my.canva.site"
        components.path = "/"
        
        let itemIDQueryItem = URLQueryItem(name: "reference", value: product.reference)
        components.queryItems = [itemIDQueryItem]
        
        guard let linkParameter = components.url else {
            return
        }
        print("I am sharing \(linkParameter.absoluteString)")
        
        let domain = "https://caffeswift.page.link"
        guard let linkBuilder = DynamicLinkComponents(
            link: linkParameter,
            domainURIPrefix: domain
        ) else {
            return
        }

        if let myBundleId = Bundle.main.bundleIdentifier {
            linkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: myBundleId)
        }
        linkBuilder.iOSParameters?.appStoreID = "1481444772"
        
        linkBuilder.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder.socialMetaTagParameters?.title = "\(product.name)"
        linkBuilder.socialMetaTagParameters?.descriptionText = product.description
        linkBuilder.socialMetaTagParameters?.imageURL = URL(
            string: "https://www.danijelavrzan.com/images/conference/caffe-swift.png"
        )!
        
        guard let longURL = linkBuilder.url else {
            return
        }
        print("The long dynamic link is \(longURL.absoluteString)")
        
        do {
            let (url, _) = try await linkBuilder.shorten()
            print("Short link is \(url.absoluteString)")
            share(product: product, with: url)
        } catch {
            return
        }
    }
    
    func share(product: Product, with url: URL) {
        let message = "Check out this tasty \(product.name) I found on Caffe Swift!"
        let activityController = UIActivityViewController(
            activityItems: [message, url],
            applicationActivities: nil
        )
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        guard let firstWindow = firstScene.windows.first else {
            return
        }
        guard let viewController = firstWindow.rootViewController else {
            return
        }
        viewController.present(activityController, animated: true, completion: nil)
    }
    
    func shareDynamicLinkFor(product: Product) {
        Task {
            await createDynamicLink(with: product)
        }
    }
}
