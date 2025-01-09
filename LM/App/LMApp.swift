//
//  LMApp.swift
//  LM
//
//  Created by r on 12/30/24.
//

import SwiftUI

@main
struct LMApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
