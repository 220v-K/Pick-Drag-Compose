//
//  ChordSelectView.swift
//  ssc
//
//  Created by 이재원 on 2023/04/16.
//

import SwiftUI

struct ChordSelectionView: View {
    @Binding var chord: Chord
    @Binding var isChordSelecting: Bool
    
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
                // 1. Display current chord status
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
                        }) {
                            Text(note)
                                .font(.system(size:20, weight:.bold))
                                .frame(width: 50, height: 25)
                                .padding()
                                .background(chord.root == Root(rawValue: note)! ? Color.gray.opacity(0.4) : Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1))
                        }
                    }
                }
                .padding(.top)
                
                // 3. Buttons for sharp and flat
                HStack {
                    ForEach(["", "♭", "♯"], id: \.self) { half in
                        Button(action: {
                            chord.changeHalf(half: Half(rawValue: half)!)
                        }) {
                            Text(half)
                                .font(.system(size:20, weight:.bold))
                                .frame(width: 50, height: 25)
                                .padding()
                                .background(chord.half == Half(rawValue: half)! ? Color.gray.opacity(0.4) : Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1))
                        }
                    }
                }
                .padding(.top)
                
                // 4. Buttons for seventh chord
                HStack {
                    ForEach(["", "7", "M7", "6"], id: \.self) { seven in
                        Button(action: {
                            chord.changeSeventh(seventh: Seventh(rawValue: seven)!)
                        }) {
                            Text(seven)
                                .font(.system(size:20, weight:.bold))
                                .frame(width: 50, height: 25)
                                .padding()
                                .background(chord.seventh == Seventh(rawValue: seven)! ? Color.gray.opacity(0.4) : Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1))
                        }
                    }
                }
                .padding(.top)
                
                
                // 5. Buttons for Triad Changing
                HStack {
                    ForEach(["", "m", "sus2", "sus4", "dim", "aug"], id: \.self) { third in
                        Button(action: {
                            chord.changeThird(third: Third(rawValue: third)!)
                        }) {
                            Text(third)
                                .font(.system(size:20, weight:.bold))
                                .frame(width: 50, height: 25)
                                .padding()
                                .background(chord.third == Third(rawValue: third)! ? Color.gray.opacity(0.4) : Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1))
                        }
                    }
                }
                .padding(.top)
                
                // 6. add9, add11, add13코드
                HStack {
                    Button(action: {
                        chord.changeExtend(num: 9)
                    }) {
                        Text("add9")
                            .font(.system(size:20, weight:.bold))
                            .frame(width: 80, height: 25)
                            .padding()
                            .background(chord.extend_nineth ? Color.red.opacity(0.3) : Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1))
                    }
                    Button(action: {
                        chord.changeExtend(num: 11)
                    }) {
                        Text("add11")
                            .font(.system(size:20, weight:.bold))
                            .frame(width: 80, height: 25)
                            .padding()
                            .background(chord.extend_eleventh ? Color.red.opacity(0.3) : Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1))
                    }
                    Button(action: {
                        chord.changeExtend(num: 13)
                    }) {
                        Text("add13")
                            .font(.system(size:20, weight:.bold))
                            .frame(width: 80, height: 25)
                            .padding()
                            .background(chord.extend_thirteenth ? Color.red.opacity(0.3) : Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 1))
                    }
                }
                .padding(.top).padding(.bottom)
                            
                // 완료 버튼
                HStack{
                    Button(action: {
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
        }
    }
}
