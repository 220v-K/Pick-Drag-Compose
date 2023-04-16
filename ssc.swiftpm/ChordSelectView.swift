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
                        
                    }
                }
            VStack {
                // 1. Display current chord status
                Text(chord.text)
                    .font(.system(size: 24, weight: .bold))
                
                // 2. Buttons to choose the base note
                HStack {
                    ForEach(["C", "D", "E", "F", "G", "A", "B"], id: \.self) { note in
                        Button(action: {
                            chord.changeRoot(root: Root(rawValue: note)!)
                        }) {
                            Text(note)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.top)
                
                // 3. Buttons for sharp and flat
                HStack {
                    ForEach(["♭", "♯"], id: \.self) { half in
                        Button(action: {
                            chord.changeHalf(half: Half(rawValue: half)!)
                        }) {
                            Text(half)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.top)
                
                // 4. Buttons for chord types
                HStack {
                    ForEach(["7", "m7", "M7"], id: \.self) { seven in
                        Button(action: {
                            chord.changeSeventh(seventh: Seventh(rawValue: seven)!)
                        }) {
                            Text(seven)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.top)
                
                // 5. Buttons for Triad Changing
                HStack {
                    ForEach(["m", "aug", "dim", "sus2", "sus4", "6"], id: \.self) { triad in
                        Button(action: {
                            chord.changeTriad(triad: Triad(rawValue: triad)!)
                        }) {
                            Text(triad)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.top)
                
                Spacer()
                
                // 완료 버튼
                HStack{
                    Button(action: {
                        isChordSelecting = false
                    }){
                        Text("확인")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .padding()
       
            .frame(maxWidth: 700, maxHeight:500)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
