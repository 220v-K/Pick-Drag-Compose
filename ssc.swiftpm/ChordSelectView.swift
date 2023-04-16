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
                // 1. Display current chord status
                Text(chord.text)
                    .font(.system(size: 30, weight: .bold))
                    .padding(.vertical, 20)
                
                // 2. Buttons to choose the base note
                HStack {
                    ForEach(["C", "D", "E", "F", "G", "A", "B"], id: \.self) { note in
                        Button(action: {
                            chord.changeRoot(root: Root(rawValue: note)!)
                        }) {
                            Text(note)
                                .frame(width: 50, height: 25)
                                .padding()
                                .background(chord.root == Root(rawValue: note)! ? Color.gray : Color.white)
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
                                .frame(width: 50, height: 25)
                                .padding()
                                .background(chord.half == Half(rawValue: half)! ? Color.gray : Color.white)
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
                                .frame(width: 50, height: 25)
                                .padding()
                                .background(chord.seventh == Seventh(rawValue: seven)! ? Color.gray : Color.white)
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
                                .frame(width: 50, height: 25)
                                .padding()
                                .background(chord.third == Third(rawValue: third)! ? Color.gray : Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 1))
                        }
                    }
                }
                .padding(.top)
                
                // 6. 6, 9, 11코드
                HStack {
                    ForEach(["", "9", "M9", "11", "M11", "13", "M13"], id: \.self) { extend in
                        Button(action: {
                            chord.changeExtend(extend: Extend(rawValue: extend)!)
                        }) {
                            Text(extend)
                                .frame(width: 50, height: 25)
                                .padding()
                                .background(chord.extend == Extend(rawValue: extend)! ? Color.gray : Color.white)
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
                        playChord(chord: chord)
                        withAnimation {
                            isChordSelecting = false
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
