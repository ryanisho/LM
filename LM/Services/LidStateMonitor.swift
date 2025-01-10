//
//  LidStateMonitor.swift
//  LM
//
//  Created by r on 12/30/24.
//

import Foundation

class LidStateMonitor {
    private var timer: Timer?
    private var previousLidState: Bool = true
    private(set) var isEnabled: Bool = true
    var stateChanged: ((Bool) -> Void)?
    
    func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            self?.checkLidState()
        })
    }
    
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }
    
    func toggleEnabled() {
        isEnabled.toggle()
        Logger.log("Monitoring \(isEnabled ? "enabled" : "disabled")")
    }
    
    private func checkLidState() {
        guard isEnabled else {return}
        
        let result = ProcessExecutor.execute(command: "/usr/bin/pmset", arguments: ["-g", "log"])
        let isLidClosed = result.output.lowercased().contains("lid closed")
        
        if isLidClosed != previousLidState {
            previousLidState = isLidClosed
            stateChanged?(isLidClosed)
        }
    }
}
