//
//  ChordSelectView.swift
//  ssc
//
//  Created by 이재원 on 2023/04/16.
//

import SwiftUI



struct ChordSelectionView: View {
    @State var chord: Chord
    
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
                            chord.text = note
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
                    Button(action: {
                        chord.text += "♭"
                    }) {
                        Text("♭")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        chord.text += "♯"
                    }) {
                        Text("♯")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                }
                .padding(.top)
                
                // 4. Buttons for chord types
                HStack {
                    Button(action: {
                        chord.text = chord.text.replacingOccurrences(of: "m7", with: "")
                    }) {
                        Text("x")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        chord.text += "M7"
                    }) {
                        Text("M7")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        chord.text += "m7"
                    }) {
                        Text("m7")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        chord.text += "7"
                    }) {
                        Text("7")
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                }
                .padding(.top)
                
                Spacer()
                
                HStack{
                    Button(action: {
                        
                    }){
                        
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
