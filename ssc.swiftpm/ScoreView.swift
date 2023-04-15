//
//  ScoreView.swift
//  ssc
//
//  Created by 이재원 on 2023/04/16.
//
//
import SwiftUI

struct ScoreView: View {
    @State private var selectedChord: Chord?
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        Spacer(minLength: geometry.size.height * 0.2)
                        ForEach(0..<12) { sectionIndex in
                            SectionView(selectedChord: $selectedChord)
                                .frame(height: geometry.size.height * 0.8 / (geometry.size.width > geometry.size.height ? 3 : 5))
                        }
                    }
                }
            }
            
            if let selectedChord = selectedChord {
                ChordSelectionView(chord: selectedChord)
                    .transition(.opacity)
                    .animation(.easeInOut)
            }
        }
    }
}

struct ChordSelectionView: View {
    @State var chord: Chord
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        chord.selected = false
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
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .padding()
       
            .frame(maxWidth: 400)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct Chord: Identifiable {
    let id = UUID()
    var text: String
    var selected: Bool
}

struct SectionView: View {
    @Binding var selectedChord: Chord?
    
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

            ForEach(0..<4) { barIndex in
                ChordView(chord: Chord(text: "Cm7", selected: false), selectedChord: $selectedChord)
                    .frame(width: geometry.size.width / 4, height: geometry.size.height / 2)
                    .position(x: CGFloat(barIndex) * geometry.size.width / 4 + geometry.size.width / 8, y: geometry.size.height / 2)
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
    @State var chord: Chord
    @Binding var selectedChord: Chord?
    
    var body: some View {
        Button(action: {
            withAnimation {
                if let selectedChord = selectedChord, selectedChord.id == chord.id {
                    chord.selected = false
                    self.selectedChord = nil
                } else {
                    chord.selected = true
                    self.selectedChord = chord
                }
            }
        }) {
            Text(chord.text)
                .font(.system(size: 14))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




