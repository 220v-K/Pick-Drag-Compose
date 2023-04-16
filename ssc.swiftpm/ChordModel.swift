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
    var seven: Seventh = Seventh.none
}

enum Seventh{
    case none
    case dom7
    case maj7
    case min7
}

enum Triad{
    // none = Major
    case none
    case min
    case aug
    case dim
    case sus2
    case sus4
    // 6 chord
    case six
}

enum Root{
    case C
    case D
    case E
    case F
    case G
    case A
    case B
}

enum Half{
    case none
    case flat
    case sharp
}
