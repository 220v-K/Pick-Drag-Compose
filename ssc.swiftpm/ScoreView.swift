//
//  ScoreView.swift
//  ssc
//
//  Created by 이재원 on 2023/04/16.
//
//
import SwiftUI


struct ScoreView: View {
    @ObservedObject var ChordOB: ChordList = ChordList(count: 8)
    @State var isChordSelecting: Bool = false
    @State var changingChordIndex: Int = 0
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        Spacer(minLength: geometry.size.height * 0.2)
                        ForEach(0..<Int(ceil(Double(ChordOB.chords.count / 4)))) { sectionIndex in
                            SectionView(ChordOB: ChordOB, SectionIndex: sectionIndex, isChordSelecting: $isChordSelecting)
                                .frame(height: geometry.size.height * 0.8 / (geometry.size.width > geometry.size.height ? 3 : 5))
                        }
                    }
                }
            }
            
            if (isChordSelecting){
                ChordSelectionView(chord: Chord())
                    .transition(.opacity)
                    .animation(.easeInOut)
            }
        }
    }
}

class ChordList: ObservableObject {
    @Published var chords: [Chord] = []
    
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
            
            
            ChordView(chord: $ChordOB.chords[SectionIndex * 4 + 0], isChordSelecting: $isChordSelecting)
                .frame(width: geometry.size.width / 4, height: geometry.size.height / 2)
                .position(x: CGFloat(0) * geometry.size.width / 4 + geometry.size.width / 8, y: geometry.size.height / 2)
            ChordView(chord: $ChordOB.chords[SectionIndex * 4 + 1], isChordSelecting: $isChordSelecting)
                .frame(width: geometry.size.width / 4, height: geometry.size.height / 2)
                .position(x: CGFloat(1) * geometry.size.width / 4 + geometry.size.width / 8, y: geometry.size.height / 2)
            ChordView(chord: $ChordOB.chords[SectionIndex * 4 + 2], isChordSelecting: $isChordSelecting)
                .frame(width: geometry.size.width / 4, height: geometry.size.height / 2)
                .position(x: CGFloat(2) * geometry.size.width / 4 + geometry.size.width / 8, y: geometry.size.height / 2)
            ChordView(chord: $ChordOB.chords[SectionIndex * 4 + 3], isChordSelecting: $isChordSelecting)
                .frame(width: geometry.size.width / 4, height: geometry.size.height / 2)
                .position(x: CGFloat(3) * geometry.size.width / 4 + geometry.size.width / 8, y: geometry.size.height / 2)
            
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
    @Binding var chord: Chord
    @Binding var isChordSelecting: Bool
    
    var body: some View {
        
        Button(action: {
            withAnimation {
                isChordSelecting.toggle()
            }
        }) {
            Text(chord.text)
                .font(.system(size: 30))
                .foregroundColor(.black)
        }
        
    }
}




