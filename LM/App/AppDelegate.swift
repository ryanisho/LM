//
//  AppDelegate.swift
//  LM
//
//  Created by r on 12/30/24.
//

import Cocoa
import ServiceManagement

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusBarController: StatusBarController!
    private var lidStateMonitor: LidStateMonitor!
    private var audioController: AudioController!
    private var launchAtLoginManager: LaunchAtLoginManager!
    
    func applicationDidFinishLaunching(_, aNotification: Notification) {
        setupServices()
        registerForSleepNotifications()
    }
    
    private func setupServices() {
        audioController = AudioController()
        launchAtLoginManager = LaunchAtLoginManager()
        lidStateMonitor = LidStateMonitor()
        
        let menuBuilder = MenuBuilder (
            launchAtLoginManager: launchAtLoginManager,
            lidStateMonitor: lidStateMonitor
        )
        
        statusBarController = StatusBarController(menuBuilder: menuBuilder)
        
        lidStateMonitor.stateChanged = { [weak self] isLidClosed in
            self?.handleLidStateChange(isLidClosed)
        }
        
        lidStateMonitor.startMonitoring()
    }
    
    private func registerForSleepNotifications() {
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(handleSleepNotification(_:)), name: NSWorkspace.willSleepNotification, object: nil)
    }
    
    private func handleLidStateChange(_ isLidClosed: Bool) {
        audioController.setMuted(isLidClosed)
        statusBarController.updateIcon(muted: isLidClosed)
    }
    
    @objc private func handleSleepNotification(_ notification: Notification) {
        audioController.setMuted(true)
    }
}
