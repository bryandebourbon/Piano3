import SwiftUI
import AVFoundation

struct ContentView: View {
    public init() {}  // public initializer
 
    @StateObject private var pianoPlayer = PianoPlayer()
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                ForEach(PianoPlayer.Note.allCases, id: \.self) { note in
                    Button(action: {
                        pianoPlayer.play(note: note)
                    }) {
                        Text(note.description)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
    }
}

extension PianoPlayer.Note: CustomStringConvertible {
    public var description: String {
        switch self {
        case .A0: return "A0"
        case .ASharp0: return "A#0"
        case .B0: return "B0"
        case .C1: return "C1"
        case .CSharp1: return "C#1"
        case .D1: return "D1"
        case .DSharp1: return "D#1"
        case .E1: return "E1"
        case .F1: return "F1"
        case .FSharp1: return "F#1"
        case .G1: return "G1"
        case .GSharp1: return "G#1"
        case .A1: return "A1"
        case .ASharp1: return "A#1"
        case .B1: return "B1"
        case .C2: return "C2"
        case .CSharp2: return "C#2"
        case .D2: return "D2"
        case .DSharp2: return "D#2"
        case .E2: return "E2"
        case .F2: return "F2"
        case .FSharp2: return "F#2"
        case .G2: return "G2"
        case .GSharp2: return "G#2"
        case .A2: return "A2"
        case .ASharp2: return "A#2"
        case .B2: return "B2"
        case .C3: return "C3"
        case .CSharp3: return "C#3"
        case .D3: return "D3"
        case .DSharp3: return "D#3"
        case .E3: return "E3"
        case .F3: return "F3"
        case .FSharp3: return "F#3"
        case .G3: return "G3"
        case .GSharp3: return "G#3"
        case .A3: return "A3"
        case .ASharp3: return "A#3"
        case .B3: return "B3"
        case .C4: return "C4"
        case .CSharp4: return "C#4"
        case .D4: return "D4"
        case .DSharp4: return "D#4"
        case .E4: return "E4"
        case .F4: return "F4"
        case .FSharp4: return "F#4"
        case .G4: return "G4"
        case .GSharp4: return "G#4"
        case .A4: return "A4"
        case .ASharp4: return "A#4"
        case .B4: return "B4"
        case .C5: return "C5"
        case .CSharp5: return "C#5"
        case .D5: return "D5"
        case .DSharp5: return "D#5"
        case .E5: return "E5"
        case .F5: return "F5"
        case .FSharp5: return "F#5"
        case .G5: return "G5"
        case .GSharp5: return "G#5"
        case .A5: return "A5"
        case .ASharp5: return "A#5"
        case .B5: return "B5"
        case .C6: return "C6"
        case .CSharp6: return "C#6"
        case .D6: return "D6"
        case .DSharp6: return "D#6"
        case .E6: return "E6"
        case .F6: return "F6"
        case .FSharp6: return "F#6"
        case .G6: return "G6"
        case .GSharp6: return "G#6"
        case .A6: return "A6"
        case .ASharp6: return "A#6"
        case .B6: return "B6"
        case .C7: return "C7"
        case .CSharp7: return "C#7"
        case .D7: return "D7"
        case .DSharp7: return "D#7"
        case .E7: return "E7"
        case .F7: return "F7"
        case .FSharp7: return "F#7"
        case .G7: return "G7"
        case .GSharp7: return "G#7"
        case .A7: return "A7"
        case .ASharp7: return "A#7"
        case .B7: return "B7"
        case .C8: return "C8"
        }
    }
}



