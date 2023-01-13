//
//  DeepLinkHandler.swift
//  CaffeSwift
//

import Foundation

class DeepLinkHandler {
    enum DeepLink: Equatable {
        case home
        case details(reference: String)
    }
    
    func parseComponents(from url: URL) -> DeepLink? {
        guard url.scheme == "https" else {
            return nil
        }
        guard url.pathComponents.contains("/") else {
            return .home
        }
        guard let query = url.query else {
            return nil
        }
        let components = query.split(separator: ",").flatMap {
            $0.split(separator: "=")
        }
        guard let idIndex = components.firstIndex(of: Substring("reference")) else {
            return nil
        }
        guard idIndex + 1 < components.count else {
            return nil
        }
        return .details(reference: String(components[idIndex + 1]))
    }
}
