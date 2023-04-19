//
//  ChordModel.swift
//  ssc
//
//  Created by 이재원 on 2023/04/16.
//

import Foundation

struct Chord: Identifiable {
    let id = UUID()
    var isEnabled: Bool = true
    var isSecond: Bool = false
    var isSelected: Bool = false
    var text: String = "C"
    // C, D, E, F, G, A, B
    var root: Root = Root.C
    // Sharp, Flat
    var half: Half = Half.none
    // m, sus2, sus4, aug, dim
    var third: Third = Third.none
    // seventh(M7, 7, 6, M6)
    var seventh: Seventh = Seventh.none
    
    var extend_nineth: Bool = false
    var extend_eleventh: Bool = false
    var extend_thirteenth: Bool = false
    
    var inversion: Int = 0
    
    var beat: Int = 4
    var octave: Int = 4
    
    mutating func changeRoot(root: Root){
        self.root = root
        changeText()
    }
    mutating func changeHalf(half: Half){
        self.half = half
        changeText()
    }
    mutating func changeThird(third: Third){
        self.third = third
        changeText()
    }
    mutating func changeSeventh(seventh: Seventh){
        self.seventh = seventh
        changeText()
    }
    mutating func changeExtend(num: Int){
        if (num == 9){
            self.extend_nineth.toggle()
        } else if (num == 11){
            self.extend_eleventh.toggle()
        } else if (num == 13){
            self.extend_thirteenth.toggle()
        } else {}
    }
    
    /// change Chord's Text Value with root, halt, triad, seventh
    mutating func changeText(){
        self.text = self.root.rawValue
        self.text += self.half.rawValue
        
        if(["", "m", "dim"].contains(self.third.rawValue)){
            self.text += self.third.rawValue
            self.text += self.seventh.rawValue
        } else {
            self.text += self.seventh.rawValue
            self.text += self.third.rawValue
        }
        
//        self.text += self.extend.rawValue
    }
}

enum Third : String{
    // none = Major
    case none = ""
    case min = "m"
    case sus2 = "sus2"
    case sus4 = "sus4"
    case aug = "aug"
    case dim = "dim"
}

// TODO : sharp9, flat9, sharp11, flat11
//enum Extend : String{
//    case none = ""
//    case nineth = "9"
//    case maj9 = "M9"
//    case eleventh = "11"
//    case maj11 = "M11"
//    case thirteenth = "13"
//    case maj13 = "M13"
//}

enum Seventh : String{
    case none = ""
    case dom7 = "7"
    case maj7 = "M7"
    case sixth = "6"
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
