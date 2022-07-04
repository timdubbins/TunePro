//
//  TunerApp.swift
//  Tuner
//
//  Created by Timothy Dubbins on 25/06/2022.
//

import AVFoundation
import SwiftUI

@main
struct TunerApp: App {
    let audio = Audio.sharedInstance
    
    init() {
        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            UIView.setAnimationsEnabled(false)
        }
        #endif
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
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
        }
    }

    func pause(_ note: Notification) {
        audio.engine.stop()
    }

    func resume(_ notification: Notification) {
        try? audio.engine.start()
    }
}



