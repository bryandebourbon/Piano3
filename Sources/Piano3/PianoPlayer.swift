import SwiftUI
import AVFoundation

public class PianoPlayer: ObservableObject {
    
    private var audioEngine: AVAudioEngine
    private var sampler: AVAudioUnitSampler
    
    public enum Note: UInt8, CaseIterable {
        case A0 = 21, ASharp0, B0
        case C1, CSharp1, D1, DSharp1, E1, F1, FSharp1, G1, GSharp1, A1, ASharp1, B1
        case C2, CSharp2, D2, DSharp2, E2, F2, FSharp2, G2, GSharp2, A2, ASharp2, B2
        case C3, CSharp3, D3, DSharp3, E3, F3, FSharp3, G3, GSharp3, A3, ASharp3, B3
        case C4, CSharp4, D4, DSharp4, E4, F4, FSharp4, G4, GSharp4, A4, ASharp4, B4
        case C5, CSharp5, D5, DSharp5, E5, F5, FSharp5, G5, GSharp5, A5, ASharp5, B5
        case C6, CSharp6, D6, DSharp6, E6, F6, FSharp6, G6, GSharp6, A6, ASharp6, B6
        case C7, CSharp7, D7, DSharp7, E7, F7, FSharp7, G7, GSharp7, A7, ASharp7, B7
        case C8
        
        var frequency: Double {
            return Note.frequencies[Int(self.rawValue - Note.A0.rawValue)]
        }
        
        private static let frequencies: [Double] = [
            27.5000, 29.1352, 30.8677, 32.7032, 34.6478, 36.7081, 38.8909, 41.2034, 43.6535, 46.2493, 48.9994, 51.9131, 55.0000,
            58.2705, 61.7354, 65.4064, 69.2957, 73.4162, 77.7817, 82.4069, 87.3071, 92.4986, 97.9989, 103.826, 110.000,
            116.541, 123.471, 130.813, 138.591, 146.832, 155.563, 164.814, 174.614, 184.997, 195.998, 207.652, 220.000,
            233.082, 246.942, 261.626, 277.183, 293.665, 311.127, 329.628, 349.228, 369.994, 391.995, 415.305, 440.000,
            466.164, 493.883, 523.251, 554.365, 587.330, 622.254, 659.255, 698.456, 739.989, 783.991, 830.609, 880.000,
            932.328, 987.767, 1046.50, 1108.73, 1174.66, 1244.51, 1318.51, 1396.91, 1479.98, 1567.98, 1661.22, 1760.00,
            1864.66, 1975.53, 2093.00, 2217.46, 2349.32, 2489.02, 2637.02, 2793.83, 2959.96, 3135.96, 3322.44, 3520.00,
            3729.31, 3951.07, 4186.01
        ]
    }
    
    public init() {
        audioEngine = AVAudioEngine()
        sampler = AVAudioUnitSampler()
        
        audioEngine.attach(sampler)
        audioEngine.connect(sampler, to: audioEngine.mainMixerNode, format: nil)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
            try audioEngine.start()
            if let soundFontURL = Bundle.main.url(forResource: "example", withExtension: "sf2") {
                try loadPianoSoundFont(from: soundFontURL)
            } else {
                print("SoundFont file not found")
            }
        } catch {
            print("Error starting audio engine: \(error.localizedDescription)")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption), name: AVAudioSession.interruptionNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleRouteChange), name: AVAudioSession.routeChangeNotification, object: nil)
    }
    
     deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func loadPianoSoundFont(from url: URL) throws {
        do {
            try sampler.loadSoundBankInstrument(at: url, program: 0, bankMSB: 0x79, bankLSB: 0x00)
        } catch {
            print("Error loading sound font: \(error.localizedDescription)")
            throw error
        }
    }
    
    public func play(note: Note, velocity: UInt8 = 64) {
        sampler.startNote(note.rawValue, withVelocity: velocity, onChannel: 0)
    }
    
    public func stop(note: Note) {
        sampler.stopNote(note.rawValue, onChannel: 0)
    }
    
    @objc private func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
            return
        }
        
        if type == .began {
            // Handle interruption began
        } else if type == .ended {
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                try audioEngine.start()
            } catch {
                print("Error restarting audio engine: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
            return
        }
        
        switch reason {
        case .newDeviceAvailable:
            // Handle new device available
            break
        case .oldDeviceUnavailable:
            // Handle old device unavailable
            break
        default:
            break
        }
    }
}
