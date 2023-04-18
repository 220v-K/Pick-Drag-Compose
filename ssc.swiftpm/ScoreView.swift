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
    @ObservedObject var ChordOB: ChordList = ChordList(count: 8, isEnable: true)
    @ObservedObject var ChordOB2: ChordList = ChordList(count: 8, isEnable: false)
    @State var isChordSelecting: Bool = false
    // swiftui 너무 화난다.. 아니 뭔 성능때문에 안되는게존재해;
    @State var isSecondChordSelecting: Bool = false
    @State var howAccompany: HowAccompany = .Basic
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        HStack{
                            Button(action: {
                                playSong(chords: ChordOB.chords, chords2: ChordOB2.chords)
                            }){
                                Text("Play!")
                                    .padding()
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
                                    .background(RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.black, lineWidth: 2))
                                    .cornerRadius(10)
                            }
                            //                            Button(action: {
                            //                                stopSong()
                            //                            }){
                            //                                Text("Stop")
                            //                                    .padding()
                            //                                    .font(.system(size: 30))
                            //                                    .foregroundColor(.black)
                            //                                    .background(RoundedRectangle(cornerRadius: 10)
                            //                                    .strokeBorder(Color.black, lineWidth: 2))
                            //                                    .cornerRadius(10)
                            //                            }
                        }
                        
                        HStack{
                            Spacer()
                            Text("How to Play? : ").font(.system(size: 20)).foregroundColor(.black)
                            Menu(howAccompany.rawValue) {
                                Button(action: { howAccompany = .Basic }) {
                                    Text("Basic").font(.system(size: 20)).foregroundColor(.black)
                                }
                                Button(action: { howAccompany = .Arpeggio }) {
                                    Text("Arpeggio").font(.system(size: 20)).foregroundColor(.black)
                                }
                            }.padding()
                                .foregroundColor(.black)
                                .font(.system(size: 22))
                                .background(RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.black, lineWidth: 2))
                                .cornerRadius(10)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                        }
                        Spacer(minLength: geometry.size.height * 0.1)
                        ForEach(0..<Int(ceil(Double(ChordOB.barCnt / 4))), id: \.self) { sectionIndex in
                            SectionView(ChordOB: ChordOB, ChordOB2:ChordOB2, SectionIndex: sectionIndex, isChordSelecting: $isChordSelecting, isSecondChordSelecting: $isSecondChordSelecting)
                                .frame(height: geometry.size.height * 0.8 / (geometry.size.width > geometry.size.height ? 3 : 5))
                        }
                        HStack{
                            if(Int(ceil(Double(ChordOB.barCnt / 4))) != 2){
                                // 4마디 삭제 버튼
                                Button(action: {
                                    withAnimation{
                                        ChordOB.removeBar4()
                                        ChordOB2.removeBar4()
                                    }
                                }) {
                                    Image(systemName: "minus")
                                        .font(.system(size: 24, weight: .bold))
                                        .padding()
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                        .frame(width: 50, height: 50)
                                }.padding()
                            }
                            // 4마디 추가 버튼
                            Button(action: {
                                withAnimation{
                                    ChordOB.addBar4(isEnable: true)
                                    ChordOB2.addBar4(isEnable: false)
                                }
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .bold))
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .frame(width: 50, height: 50)
                            }.padding()
                        }
                        
                    }
                }
            }
            
            if (isChordSelecting){
                ChordSelectionView(chord: $ChordOB.chords[ChordOB.changingChordIndex], isChordSelecting: $isChordSelecting)
                    .transition(.opacity)
                    .animation(.easeInOut)
            }
            if (isSecondChordSelecting){
                ChordSelectionView(chord: $ChordOB2.chords[ChordOB2.changingChordIndex], isChordSelecting: $isSecondChordSelecting)
                    .transition(.opacity)
                    .animation(.easeInOut)
            }
        }
    }
}

class ChordList: ObservableObject {
    @Published var chords: [Chord] = []
    @Published var changingChordIndex: Int = 0
    @Published var barCnt: Int = 0
    
    init(count: Int, isEnable: Bool) {
        for _ in 0..<count {
            chords.append(Chord(isEnabled: isEnable))
            barCnt += 1
        }
    }
    
    func addBar4(isEnable: Bool) {
        // 이미 생성했다가 줄을 지워서 리스트가 지닌 것이 더 많을 때 (Index out of range 임시해결)
        if (barCnt != chords.count){
            for _ in 0..<4 {
                chords[barCnt-1] = Chord(isEnabled: isEnable)
                barCnt += 1
            }
        } else {
            for _ in 0..<4 {
                chords.append(Chord(isEnabled: isEnable))
                barCnt += 1
            }
        }
    }
    
    func removeBar4(){
        barCnt -= 4
    }
}


struct SectionView: View {
    @ObservedObject var ChordOB : ChordList
    @ObservedObject var ChordOB2 : ChordList
    @State var SectionIndex: Int
    @Binding var isChordSelecting: Bool
    @Binding var isSecondChordSelecting: Bool
    
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
                let chord2Enabled = ChordOB2.chords[SectionIndex*4+index].isEnabled
                if chord2Enabled == false {
                    ChordView(ChordOB: ChordOB, isChordSelecting: $isChordSelecting, chordIndex: SectionIndex * 4 + index)
                        .frame(width: geometry.size.width / 4, height: geometry.size.height / 2)
                        .position(x: CGFloat(index) * geometry.size.width / 4 + geometry.size.width / 8, y: geometry.size.height / 2)

                } else {
                    
                        ChordView(ChordOB: ChordOB, isChordSelecting: $isChordSelecting, chordIndex: SectionIndex * 4 + index)
                            .frame(width: geometry.size.width / 4, height: geometry.size.height / 2)
                            .position(x: CGFloat(index) * geometry.size.width / 4 + geometry.size.width / 8 - 40, y: geometry.size.height / 2)
                        ChordView(ChordOB: ChordOB2, isChordSelecting: $isSecondChordSelecting, chordIndex: SectionIndex * 4 + index)
                            .frame(width: geometry.size.width / 4, height: geometry.size.height / 2)
                            .position(x: CGFloat(index) * geometry.size.width / 4 + geometry.size.width / 8 + 40, y: geometry.size.height / 2)
                    
                }
                Button(action: {
                    if(chord2Enabled) {
                        ChordOB2.chords[SectionIndex*4+index].isEnabled = false
                    } else{
                        ChordOB2.chords[SectionIndex*4+index].isEnabled = true
                    }
                }){
                    Image(systemName: chord2Enabled ? "minus.circle.fill" : "plus.circle.fill")
                        .font(.system(size: 25, weight: .medium))
                        .padding()
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                        .frame(width: 20, height: 20)
                }.position(x: CGFloat(index) * geometry.size.width / 4 + geometry.size.width / 8 + 80, y: geometry.size.height / 2 - 30)
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
            ZStack{
                Text(ChordOB.chords[chordIndex].text)
                    .font(.system(size: 30))
                    .foregroundColor(.black)
                switch ChordOB.chords[chordIndex].inversion{
                case 1:
                    Text("1st").font(.system(size: 13, weight: .bold))
                        .padding(.horizontal, 10).foregroundColor(.gray).offset(x:20, y:-20)
                case 2:
                    Text("2nd").font(.system(size: 13, weight: .bold))
                        .padding(.horizontal, 10).foregroundColor(.gray).offset(x:20, y:-20)
                case 3:
                    Text("3rd").font(.system(size: 13, weight: .bold))
                        .padding(.horizontal, 10).foregroundColor(.gray).offset(x:20, y:-20)
                        
                default:
                    Text("").font(.system(size: 13, weight: .bold))
                        .padding(.horizontal, 10)
                }
            }
        }
    }
}


