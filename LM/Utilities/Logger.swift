//
//  Logger.swift
//  LM
//
//  Created by r on 12/30/24.
//

import os.log

struct Logger {
    private static let logger = OSLog(subsystem: AppConstants.bundleIdentifier, category: "LM")
    
    static func log(_ message: String) {
        os_log("%{public}@", log: logger, type: .default, message)
    }
}
