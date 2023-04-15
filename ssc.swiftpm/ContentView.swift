import SwiftUI
import MusicalInstrument
import MusicSymbol
import MusicKit

struct ContentView: View {
    var body: some View {
//        Button(action: {
//            // create a piano, and play middle C for a second.
//            let piano = Piano.default
//            piano.pedalOn()
//            piano.play(at: "C4")
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                piano.stopAll()
//            }
//        }, label: {
//            Text("Play Piano Sound")
//        })
        ScoreView()
    }
}
