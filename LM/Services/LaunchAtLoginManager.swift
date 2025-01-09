//
//  LaunchAtLoginManager.swift
//  LM
//
//  Created by r on 12/30/24.
//

import ServiceManagement

class LaunchAtLoginManager {
    private let defaults = UserDefaults.standard
    private let launchAtLoginKey = "launchAtLogin"
    
    var isEnabled: Bool {
        get { defaults.bool(forKey: launchAtLoginKey) }
        set {
            defaults.set(newValue, forKey: launchAtLoginKey)
            setLaunchAtLogin(newValue)
        }
    }
    
    private func setLaunchAtLogin(_ enabled: Bool) {
        if #avaliable(macOS 13, *) {
            do {
                if enable {
                    try SMAppService.mainApp.register()
                } else {
                    try SMAppService.mainApp.unregister()
                }
            } catch {
                Logger.log("Failed to set launch at login: \(error.localizedDescription)")
            }
        }
    }
}
