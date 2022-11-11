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
    @ObservedObject var data = DataController.sharedInstance

    let audio = AudioController.sharedInstance
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
            if data.isFirstAppRun {
                OnboardingView() { newValue in
                    data.isFirstAppRun = newValue
                }
                .preferredColorScheme(.dark)
            } else {
                RootView()
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
                        perform: audio.pause)
                    .onReceive(
                        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification),
                        perform: audio.resume)
                    .onReceive(NotificationCenter.default.publisher(for: AVAudioSession.interruptionNotification),
                               perform: audio.handleInterruption)
            }
        }
    }
}
