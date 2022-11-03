//
//  Audio.swift
//  TunePro
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import AudioKit
import AudioKitEX
import AVFoundation
import SoundpipeAudioKit

/// An environment singleton responsible for managing the audio engine.
class AudioController: ObservableObject {
    // MARK: - Properties

    /// Creates the shared instance of the audio controller.
    static var sharedInstance: AudioController = {
        let audio = AudioController()

        do {
            try audio.engine.start()
            #if DEBUG
            AudioKit.Log("AudioKit Started")
            #endif
        } catch {
            fatalError("Failed to start the audio engine: \(error.localizedDescription)")
        }

        // Initializes the pitch tap and assigns the output of the tap.
        audio.pitchTap = PitchTap(audio.pitchNode) { frequency, amplitude in
            audio.pitchTapData = (amplitude[0], frequency[0])
        }

        return audio
    }()

    /// A tuple that holds the current amplitude and frequency of the pitch tap.
    @Published var pitchTapData: (amplitude: Float, frequency: Float) = (0, 0)

    /// Whether or not a headphone jack is detected.
    @Published var headphonesConnected: Bool = false

    /// Whether or not a headset microphone is detected.
    @Published var headsetMicConnected: Bool = false

    /// The audio engine, which is a wrapper for AVAudioEngine.
    let engine = AudioEngine()

    /// The input for the audio engine, connecting the engine to the input device.
    private var input: AudioEngine.InputNode!

    /// A tap that handles the frequency and amplitude of the output of a node.
    var pitchTap: PitchTap!

    /// A node that can be tapped (used for pitch tap).
    var pitchNode: Fader

    /// A node with output gain of zero.
    var silenceNode: Fader

    // MARK: - Methods

    /// Initializes the audio controller and starts the audio engine.
    private init() {
        #if DEBUG
        AudioKit.Settings.enableLogging = true
        AudioKit.Log("Logging is ON")

        #else
        AudioKit.Log("Logging is OFF")
        #endif

        do {
            try AudioKit.Settings.setSession(
                category: .playAndRecord,
                with: [.defaultToSpeaker, .allowBluetooth, .mixWithOthers]
            )
        } catch {
            AudioKit.Log("Could not set session category: \(error)")
        }

        input = engine.input
        pitchNode = Fader(input)
        silenceNode = Fader(pitchNode, gain: 0)
        engine.output = silenceNode
    }

    /// Restarts the audio engine when the audio route changes.
    @objc func handleRouteChange(note: Notification) {
        engine.stop()
        let currentRoute = Settings.session.currentRoute

        if hasHeadsetMic(in: currentRoute) {
            headsetMicConnected = true
        } else {
            headsetMicConnected = false
        }

        if hasHeadphones(in: currentRoute) {
            headphonesConnected = true
        } else {
            headphonesConnected = false
        }

        try? engine.start()
    }

    func hasHeadphones(in routeDescription: AVAudioSessionRouteDescription) -> Bool {
        // Filter the outputs to only those with a port type of headphones.
        return !routeDescription.outputs.filter({$0.portType == .headphones}).isEmpty
    }

    func hasHeadsetMic(in routeDescription: AVAudioSessionRouteDescription) -> Bool {
        // Filter the inputs to only those with a port type of headset microphones.
        return !routeDescription.inputs.filter({$0.portType == .headsetMic}).isEmpty
    }

    func handleInterruption(_ notification: Notification) {
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

    var microphonePermissionStatus: Bool {
        AVCaptureDevice.authorizationStatus(for: AVMediaType.audio) == .authorized
    }

    func pause(_ note: Notification) {
        engine.stop()
    }

    func resume(_ notification: Notification) {
        try? engine.start()
    }
}
