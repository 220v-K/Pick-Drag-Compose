//
//  ChordSelectView_Basic.swift
//  ssc
//
//  Created by 이재원 on 2023/04/20.
//

import SwiftUI

struct ChordSelectionView_Basic: View {
    @Binding var chord: Chord
    @Binding var isChordSelecting: Bool
    @State var isColoredStr: String = ""
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        isChordSelecting = false
                    }
                }
            VStack {
                ZStack{
                    switch chord.inversion{
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
                    if(chord.octave != 4){
                        Text("Oct. \(chord.octave)").font(.system(size: 13, weight: .bold))
                            .padding(.horizontal, 10).foregroundColor(.gray).offset(x:20, y:-36)
                    }
                Text(chord.text)
                    .font(.system(size: 30, weight: .bold))
                    .padding(.vertical, 20).padding(.top, 20)
                    
                    HStack{
                        if(chord.extend_nineth||chord.extend_eleventh||chord.extend_thirteenth){
                            Text("add").font(.system(size: 13, weight: .bold))
                                .padding(.trailing, 1).foregroundColor(.gray)
                        }
                        if(chord.extend_nineth){
                            Text("9").font(.system(size: 13, weight: .bold))
                                .padding(.trailing, 1).foregroundColor(.gray)
                        }
                        if(chord.extend_eleventh){
                            Text("11").font(.system(size: 13, weight: .bold))
                                .padding(.trailing, 1).foregroundColor(.gray)
                        }
                        if(chord.extend_thirteenth){
                            Text("13").font(.system(size: 13, weight: .bold))
                                .padding(.trailing, 1).foregroundColor(.gray)
                        }
                    }.offset(x:-25, y:30)
                }
                
                // Change Chord's Inversion
                HStack{
                    Spacer()
                    Button(action: {
                        if(chord.inversion > 0){
                            chord.inversion -= 1
                        }
                    }){
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 30, weight: .medium))
                            .padding()
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                            .frame(width: 23, height: 23)
                    }
                    Text("Inversion :  ").font(.system(size: 24, weight: .bold))
                        .padding(.horizontal, 10)
                    switch chord.inversion{
                    case 1:
                        Text("1st").font(.system(size: 24, weight: .bold))
                            .padding(.horizontal, 10)
                    case 2:
                        Text("2nd").font(.system(size: 24, weight: .bold))
                            .padding(.horizontal, 10)
                    case 3:
                        Text("3rd").font(.system(size: 24, weight: .bold))
                            .padding(.horizontal, 10)
                    default:
                        Text("none").font(.system(size: 24, weight: .bold))
                            .padding(.horizontal, 10)
                    }
                    Button(action: {
                        if(chord.inversion < 3){
                            chord.inversion += 1
                        }
                    }){
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30, weight: .medium))
                            .padding()
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                            .frame(width: 20, height: 20)
                    }
                }
                
                // Change Chord's octave
                // default: C4(60th. octave 4.)
                HStack{
                    Spacer()
                    Button(action: {
                        if(chord.octave > 0){
                            chord.octave -= 1
                        }
                    }){
                        Image(systemName: "minus.circle.fill")
                            .font(.system(size: 30, weight: .medium))
                            .padding()
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                            .frame(width: 20, height: 20)
                    }
                    Text("Octave :  ").font(.system(size: 24, weight: .bold))
                        .padding(.horizontal, 10)
                    Text("\(chord.octave)").font(.system(size: 24, weight: .bold))
                        .padding(.horizontal, 10)
                    Button(action: {
                        if(chord.octave < 7){
                            chord.octave += 1
                        }
                    }){
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30, weight: .medium))
                            .padding()
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                            .frame(width: 20, height: 20)
                    }
                }
                
                // 2. Buttons to choose the base note
                HStack {
                    ForEach(["C", "D", "E", "F", "G", "A", "B"], id: \.self) { note in
                        Button(action: {
                            chord.changeRoot(root: Root(rawValue: note)!)
                            chord.changeHalf(half: .none)
                        }) {
                            Text(note)
                                .font(.system(size:20, weight:.bold))
                                .frame(width: 50, height: 25)
                                .padding()
                                .background((chord.root == Root(rawValue: note)! && chord.half == .none) ? Color.gray.opacity(0.4) : Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1))
                        }.padding(.horizontal, 3)
                    }
                }
                .padding(.top)
                
                // 3. Buttons for sharp and flat
                HStack {
                    // C sharp
                    Button(action: {
                        chord.changeRoot(root: Root(rawValue: "C")!)
                        chord.changeHalf(half: Half(rawValue: "♯")!)
                    }) {
                        Text("C♯/D♭")
                            .font(.system(size:20, weight:.bold))
                            .frame(width: 60, height: 25)
                            .padding()
                            .background((chord.root == .C && chord.half == .sharp) || (chord.root == .D && chord.half == .flat) ? Color.gray.opacity(0.4) : Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1))
                    }
                    // D sharp
                    Button(action: {
                        chord.changeRoot(root: Root(rawValue: "D")!)
                        chord.changeHalf(half: Half(rawValue: "♯")!)
                    }) {
                        Text("D♯/E♭")
                            .font(.system(size:20, weight:.bold))
                            .frame(width: 60, height: 25)
                            .padding()
                            .background((chord.root == .D && chord.half == .sharp) || (chord.root == .E && chord.half == .flat) ? Color.gray.opacity(0.4) : Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1))
                    }.padding(.trailing, 80)
                    // F sharp
                    Button(action: {
                        chord.changeRoot(root: Root(rawValue: "F")!)
                        chord.changeHalf(half: Half(rawValue: "♯")!)
                    }) {
                        Text("F♯/G♭")
                            .font(.system(size:20, weight:.bold))
                            .frame(width: 60, height: 25)
                            .padding()
                            .background((chord.root == .F && chord.half == .sharp) || (chord.root == .G && chord.half == .flat) ? Color.gray.opacity(0.4) : Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1))
                    }
                    // G sharp
                    Button(action: {
                        chord.changeRoot(root: Root(rawValue: "G")!)
                        chord.changeHalf(half: Half(rawValue: "♯")!)
                    }) {
                        Text("G♯/A♭")
                            .font(.system(size:20, weight:.bold))
                            .frame(width: 60, height: 25)
                            .padding()
                            .background((chord.root == .G && chord.half == .sharp) || (chord.root == .A && chord.half == .flat) ? Color.gray.opacity(0.4) : Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1))
                    }
                    // A sharp
                    Button(action: {
                        chord.changeRoot(root: Root(rawValue: "A")!)
                        chord.changeHalf(half: Half(rawValue: "♯")!)
                    }) {
                        Text("A♯/B♭")
                            .font(.system(size:20, weight:.bold))
                            .frame(width: 60, height: 25)
                            .padding()
                            .background((chord.root == .A && chord.half == .sharp) || (chord.root == .B && chord.half == .flat) ? Color.gray.opacity(0.4) : Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1))
                    }
                }
                .padding(.top).padding(.bottom)
                
                Divider().frame(minHeight: 4).background(.black)
                
                HStack {
                    ForEach(["", "m", "m7", "7", "M7"], id: \.self) { op in
                        Button(action: {
                            resetChord()
                            if (op == "m"){
                                chord.changeThird(third: .min)
                            } else if (op == "m7") {
                                chord.changeSeventh(seventh: .dom7)
                                chord.changeThird(third: .min)
                            } else if (op == "7") {
                                chord.changeSeventh(seventh: .dom7)
                            } else if (op == "M7") {
                                chord.changeSeventh(seventh: .maj7)
                            } else {
                                resetChord()
                            }
                            isColoredStr = op
                        }) {
                            Text("\(chord.root.rawValue + op)")
                                .font(.system(size:20, weight:.bold))
                                .frame(width: 70, height: 25)
                                .padding()
                                .background(isColoredStr == op ? .red.opacity(0.3) : Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1))
                        }
                    }
                }
                .padding(.top)
                
                HStack {
                    ForEach(["sus2", "sus4", "dim", "aug", "add9"], id: \.self) { op in
                        Button(action: {
                            resetChord()
                            if (op == "sus2"){
                                chord.changeThird(third: .sus2)
                            } else if (op == "sus4") {
                                chord.changeThird(third: .sus4)
                            } else if (op == "dim") {
                                chord.changeThird(third: .dim)
                            } else if (op == "aug") {
                                chord.changeThird(third: .aug)
                            } else if (op == "add9") {
                                chord.extend_nineth = true
                            }
                            isColoredStr = op
                        }) {
                            Text("\(chord.root.rawValue + op)")
                                .font(.system(size:20, weight:.bold))
                                .frame(width: 70, height: 25)
                                .padding()
                                .background(isColoredStr == op ? .red.opacity(0.3) : Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1))
                        }
                    }
                }
                .padding(.top)
                
                Spacer()
                
                // 완료 버튼
                HStack{
                    Button(action: {
                        closeSelect()
                    }){
                        Text("OK")
                            .font(.system(size: 23, weight: .bold))
                            .padding(.vertical, 20).padding(.horizontal, 40)
                            .background(.blue.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.vertical, 30)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .padding()
            .frame(maxWidth: 900, maxHeight:500)
            .edgesIgnoringSafeArea(.bottom)
        }.onAppear{initResetChord()}
    }
    
    func initResetChord(){
        let s = chord.seventh != .none
        let t = chord.third != .none
        let n = chord.extend_nineth
        let ee = chord.extend_eleventh
        let et = chord.extend_thirteenth
        let six = chord.seventh == .sixth
        
        // 해당 2개 이상 or add11 or add13이면 초기화
        if([s, t, n, ee, et].filter { $0 == true }.count > 1 || ee || et || six){
            self.chord.changeSeventh(seventh: .none)
            self.chord.changeThird(third: .none)
            self.chord.extend_nineth = false
            self.chord.extend_eleventh = false
            self.chord.extend_thirteenth = false
        }
    }
    
    func resetChord(){
        self.chord.changeSeventh(seventh: .none)
        self.chord.changeThird(third: .none)
        self.chord.extend_nineth = false
        self.chord.extend_eleventh = false
        self.chord.extend_thirteenth = false
    }
    
    func closeSelect(){
        playChord(chord: chord, tempoSec: 1.5)
        withAnimation {
            isChordSelecting = false
            chord.isSelected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                withAnimation{
                    chord.isSelected = false
                }
            })
        }
    }
}
