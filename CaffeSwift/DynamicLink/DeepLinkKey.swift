//
//  DeppLinkKey.swift
//  CaffeSwift
//

import SwiftUI

struct DeepLinkKey: EnvironmentKey {
  static var defaultValue: DeepLinkHandler.DeepLink? {
    return nil
  }
}

// MARK: - Define a new environment value property
extension EnvironmentValues {
  var deepLink: DeepLinkHandler.DeepLink? {
    get {
        self[DeepLinkKey.self]
    }
    set {
        self[DeepLinkKey.self] = newValue
    }
  }
}
