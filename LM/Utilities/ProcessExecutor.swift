//
//  ProcessExecutor.swift
//  LM
//
//  Created by r on 12/30/24.
//

import Foundation

struct ProcessExecutor {
    struct ProcessResult {
        let output: String
        let error: String
        let exitCode: Int32
    }
    
    static func execute(command: String, arguments: [String]) -> ProcessResult {
        let task = Process()
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        
        task.launchPath = command
        task.arguments = arguments
        task.standardOutput = outputPipe
        task.standardError = errorPipe
        
        task.launch()
        task.waitUntilExit()
        
        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
        
        let output = String(data: outputData, encoding: .utf8) ?? ""
        let error = String(data: errorData, encoding: .utf8) ?? ""
        
        return ProcessResult (
            output: output,
            error: error,
            exitCode: task.terminationStatus
        )
    }
}
