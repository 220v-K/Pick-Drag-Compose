//
//  ChordModel.swift
//  ssc
//
//  Created by 이재원 on 2023/04/16.
//

import Foundation

struct Chord: Identifiable {
    let id = UUID()
    var text: String = "C"
    // C, D, E, F, G, A, B
    var root: Root = Root.C
    // Sharp, Flat
    var half: Half = Half.none
    // maj, min, aug, dim, sus2, sus4, 6..
    var triad: Triad = Triad.none
    // seventh(M7, m7, 7)
    var seventh: Seventh = Seventh.none
    
    var temp: ChordType
    
    mutating func changeRoot(root: Root){
        self.root = root
        changeText()
    }
    mutating func changeHalf(half: Half){
        self.half = half
        changeText()
    }
    mutating func changeTriad(triad: Triad){
        self.triad = triad
        changeText()
    }
    mutating func changeSeventh(seventh: Seventh){
        self.seventh = seventh
        changeText()
    }
    
    /// change Chord's Text Value with root, halt, triad, seventh
    mutating func changeText(){
        self.text = self.root.rawValue
        self.text += self.half.rawValue
        self.text += self.triad.rawValue
        self.text += self.seventh.rawValue
        
    }
}

enum Add : String{
    case none = ""
    case add9 = "add9"
}

enum Triad : String{
    // none = Major
    case none = ""
    case min = "m"
    case aug = "aug"
    case dim = "dim"
    case sus2 = "sus2"
    case sus4 = "sus4"
    // 6 chord
    case six = "6"
    case five = "5"
}

enum Seventh : String{
    case none = ""
    case dom7 = "7"
    case maj7 = "m7"
    case min7 = "M7"
}

enum Root : String{
    case C = "C"
    case D = "D"
    case E = "E"
    case F = "F"
    case G = "G"
    case A = "A"
    case B = "B"
}

enum Half : String{
    case none = ""
    case flat = "♭"
    case sharp = "♯"
}
