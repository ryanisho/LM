//
//  AudioController.swift
//  LM
//
//  Created by r on 12/30/24.
//

import Foundation

class AudioController {
    func setMuted(_ muted: Bool) {
        let script = "set volume \(muted ? "with" : "without") output muted"
        _ = ProcessExecutor.execute(command: "/usr/bin/osascript", arguments: ["-e", script])
        Logger.log("Audio \(muted ? "muted" : "unmuted")")
    }
}
