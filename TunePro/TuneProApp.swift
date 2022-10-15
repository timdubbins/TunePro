//
//  TuneProApp.swift
//  TunePro
//
//  Created by Timothy Dubbins on 25/06/2022.
//

import AVFoundation
import SwiftUI

@main
struct TuneProApp: App {
    let audio = Audio.sharedInstance
    let theme = ThemeManager.sharedInstance

    init() {
#if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            UIView.setAnimationsEnabled(false)
        }
#endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(theme)
                .preferredColorScheme(.dark)
                .onReceive(
                    NotificationCenter.default.publisher(for: AVAudioSession.routeChangeNotification),
                    perform: audio.handleRouteChange)
                .onReceive(
                    // Automatically pause when we detect that we are no longer
                    // the foreground app. Use this rather than the scene phase
                    // API so we can port to macOS, where scene phase cannot
                    // detect our app losing focus as of macOS 11.1.
                    NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
                    perform: pause)
                .onReceive(
                    NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification),
                    perform: resume)
                .onReceive(NotificationCenter.default.publisher(for: AVAudioSession.interruptionNotification),
                           perform: handleInterruption)
        }
    }

    private func handleInterruption(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt else { return }
        guard let type = AVAudioSession.InterruptionType(rawValue: typeValue) else { return }

        if type == .began {
            pause(notification)
        }
        else if type == .ended {
            guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }

            let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)

            if options.contains(.shouldResume) {
                resume(notification)
            }
        }
    }

    private func pause(_ note: Notification) {
        audio.engine.stop()
        print("pause")
    }

    private func resume(_ notification: Notification) {
        try? audio.engine.start()
        print("resume")
    }
}
