import SwiftUI
import MusicalInstrument
import MusicSymbol
import MusicKit

struct PianoView: View {
//    @StateObject var conductor = PianoConductor()

    var body: some View {
        Button(action: {
            // create a piano, and play middle C for a second.
            let piano = Piano.default
            piano.pedalOn()
            
            piano.play(at: "C4")
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                piano.play(at: "E4", with: .velocity(100))
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                piano.play(at: "G4")
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                piano.stopAll()
//                piano.stop(at: "E4")
//                piano.stop(at: "G4")
//                piano.pedalOff()
            }
            

        }, label: {
            Text("Play Piano Sound")
        })
    }
}
