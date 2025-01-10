//
//  StatusBarController.swift
//  LM
//
//  Created by r on 12/30/24.
//

import Cocoa

class StatusBarController {
    private var statusItem: NSStatusItem!
    private let menuBuilder: MenuBuilder
    
    init(menuBuilder: MenuBuilder) {
        self.menuBuilder = menuBuilder
        setupStatusBar()
    }
    
    private func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "speaker.slash.circle.fill", accessibilityDescription: "LidMute")
        }
        
        statusItem.menu = menuBuilder.buildMenu()
    }
    
    func updateIcon(muted: Bool) {
        if let button = statusItem.button {
            let imageName = muted ? "speaker.slash.circle.fill" : "speaker.circle.fill"
            button.image = NSImage(systemSymbolName: imageName, accessibilityDescription: "LidMute")
        }
    }
}

