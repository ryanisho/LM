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
    
    init(launchAtLoginManager: LaunchAtLoginManager, lidStateMonitor: LidStateMonitor) {
        self.launchAtLoginManager = launchAtLoginManager
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
        let launchAtLoginItem = NSMenuItem (
            title: "Launch at Login",
            action: #selector(MenuBuilder.toggleLaunchAtLogin(_:)),
            keyEquivalent: ""
        )
        
        launchAtLoginItem.target = self
        launchAtLoginItem.state = launchAtLoginManager.isEnabled ? .on : .off
        menu.addItem(launchAtLoginItem)
        
        menu.addItem(NSMenuItem.separator())
        
        // about item
        menu.addItem(NSMenuItem(
            title: "About LidMute",
            action: #selector(MenuBuilder.showAbout(_:)),
            keyEquivalent: ""
        ))
        
        // quit item
        menu.addItem(NSMenuItem(
            title: "Quit",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        ))
        
        return menu
    }
    
    @objc private func toggleEnabled(_ sender: NSMenuItem) {
        lidStateMonitor.toggleEnabled()
        sender.state = lidStateMonitor.isEnabled ? .on : .off
    }
    
    @objc private func toggleLaunchAtLogin(_ sender: NSMenuItem) {
        launchAtLoginManager.isEnabled.toggle()
        sender.state = launchAtLoginManager.isEnabled ? .on : .off
    }
    
    @objc private func showAbout(_ sender: Any) {
        NSApp.orderFrontStandardAboutPanel(sender)
    }
}
