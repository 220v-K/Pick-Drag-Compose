//
//  ScoreView.swift
//  ssc
//
//  Created by 이재원 on 2023/04/16.
//
//
import SwiftUI
import MusicalInstrument

struct ScoreView: View {
    @ObservedObject var ChordOB: ChordList = ChordList(count: 8)
    @State var isChordSelecting: Bool = false
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        Button(action: {
                            playSong(chords: ChordOB.chords)
                        }){
                            Text("for test").foregroundColor(.black)
                        }
                        Spacer(minLength: geometry.size.height * 0.1)
                        ForEach(0..<Int(ceil(Double(ChordOB.chords.count / 4)))) { sectionIndex in
                            SectionView(ChordOB: ChordOB, SectionIndex: sectionIndex, isChordSelecting: $isChordSelecting)
                                .frame(height: geometry.size.height * 0.8 / (geometry.size.width > geometry.size.height ? 3 : 5))
                        }
                    }
                }
            }
            
            if (isChordSelecting){
                ChordSelectionView(chord: $ChordOB.chords[ChordOB.changingChordIndex], isChordSelecting: $isChordSelecting)
                .transition(.opacity)
                .animation(.easeInOut)
            }
        }
    }
}

class ChordList: ObservableObject {
    @Published var chords: [Chord] = []
    @Published var changingChordIndex: Int = 0
    
    init(count: Int) {
        for _ in 0..<count {
            chords.append(Chord())
        }
    }
}


struct SectionView: View {
    @ObservedObject var ChordOB : ChordList
    @State var SectionIndex: Int
    @Binding var isChordSelecting: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for i in 0..<4 {
                    let xOffset = CGFloat(i) * geometry.size.width / 4
                    if i > 0 {
                        path.move(to: CGPoint(x: xOffset, y: geometry.size.height / 4))
                        path.addLine(to: CGPoint(x: xOffset, y: geometry.size.height * 3 / 4))
                    }
                }
            }
            .stroke(Color.black, lineWidth: 2)
            
            ForEach(0..<4){ index in
                ChordView(ChordOB: ChordOB, isChordSelecting: $isChordSelecting, chordIndex: SectionIndex * 4 + index)
                    .frame(width: geometry.size.width / 4, height: geometry.size.height / 2)
                    .position(x: CGFloat(index) * geometry.size.width / 4 + geometry.size.width / 8, y: geometry.size.height / 2)
            }
            
            Path { path in
                path.move(to: CGPoint(x: 20, y: geometry.size.height / 4))
                path.addLine(to: CGPoint(x: geometry.size.width - 20, y: geometry.size.height / 4))
                path.move(to: CGPoint(x: 20, y: geometry.size.height * 3 / 4))
                path.addLine(to: CGPoint(x: geometry.size.width - 20, y: geometry.size.height * 3 / 4))
            }
            .stroke(Color.black, lineWidth: 2)
        }
    }
}

struct ChordView: View {
    @ObservedObject var ChordOB : ChordList
    @Binding var isChordSelecting: Bool
    @State var chordIndex: Int
    
    var body: some View {
        Button(action: {
            withAnimation {
                ChordOB.changingChordIndex = chordIndex
                isChordSelecting.toggle()
            }
        }) {
            Text(ChordOB.chords[chordIndex].text)
                .font(.system(size: 30))
                .foregroundColor(.black)
        }
    }
}




