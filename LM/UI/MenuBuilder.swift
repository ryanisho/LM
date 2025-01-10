//
//  MenuBuilder.swift
//  LM
//
//  Created by r on 12/30/24.
//

import Cocoa

class MenuBuilder {
    private let launchAtLoginManager: LaunchAtLoginManager
    private let lidStateMonitor: LidStateMonitor
    
    init(laucnAtLoginManager: LaunchAtLoginManager, lidStateMonitor: LidStateMonitor) {
        self.launchAtLoginManager = laucnAtLoginManager
        self.lidStateMonitor = lidStateMonitor
    }
    
    func buildMenu() -> NSMenu {
        let menu = NSMenu()
        
        // enable/disable toggle
        let toggleItem = NSMenuItem (
            title: "Enabled",
            action: #selector(MenuBuilder.toggleEnabled(_:)),
            keyEquivalent: ""
        )
        
        toggleItem.target = self
        toggleItem.state = lidStateMonitor.isEnabled ? .on : .off
        menu.addItem(toggleItem)
        
        // launch at login option
        
    }
}
