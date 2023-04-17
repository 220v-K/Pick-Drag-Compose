//
//  playSound.swift
//  ssc
//
//  Created by 이재원 on 2023/04/17.
//

import Foundation
import MusicalInstrument
import MusicSymbol

//func stopSong(){
//    Piano.default.stopAll()
//}

func playSong(chords: [Chord], chords2: [Chord]){
//    let piano = Piano.default
    var currentIndex = 0

    test()
    
    func test(){
        playBar(chord: chords[currentIndex])
        currentIndex += 1
        if currentIndex == chords.count {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: test)
    }
    
}

func playBar(chord: Chord){
    let piano = Piano.default
    let noteDict: [String: Int] = ["C": 0, "D": 1, "E": 2, "F": 3, "G": 4, "A": 5, "B": 6]
    // root음 설정
    var rootPitch: Int = noteDict[chord.root.rawValue] ?? 0
    rootPitch += 60
    switch chord.half{
    case .none:
        break
    case .flat:
        rootPitch -= 1
    case .sharp:
        rootPitch += 1
    }
    
    // root음 1, 2옥타브 밑을 근음으로 연주
    piano.pedalOn()
    piano.play(at: Pitch(rawValue: rootPitch-12))
    piano.play(at: Pitch(rawValue: rootPitch-24))
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.9, execute: {
        piano.stop(at: Pitch(rawValue: rootPitch-12))
        piano.stop(at: Pitch(rawValue: rootPitch-24))
    })
    
    
    
    var counter = 0 // 반복 횟수
    
    test2()
    
    func test2(){
        // 1초마다 연주
        playChord(chord: chord)
        
        // 반복 횟수가 4번 이상이면 종료
        counter += 1
        if counter >= 4 {
            piano.pedalOff()
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: test2)
    }

    
}

func playChord(chord: Chord){
    let piano = Piano.default
    let noteDict: [String: Int] = ["C": 0, "D": 1, "E": 2, "F": 3, "G": 4, "A": 5, "B": 6]
    var pitchList : [Int] = []
    
    // root음 넣고(Half 따라 조절)
    var rootPitch: Int = noteDict[chord.root.rawValue] ?? 0
    rootPitch += 60
//    print(rootPitch)
//    piano.play(at: Pitch(rawValue: rootPitch))
    switch chord.half{
    case .none:
        break
    case .flat:
        rootPitch -= 1
    case .sharp:
        rootPitch += 1
    }
    pitchList.append(rootPitch)
    
    // 3, 5음 넣기
    switch chord.third{
    case .none:
        pitchList.append(rootPitch+4)
        pitchList.append(rootPitch+7)
    case .min:
        pitchList.append(rootPitch+3)
        pitchList.append(rootPitch+7)
    case .sus2:
        pitchList.append(rootPitch+2)
        pitchList.append(rootPitch+7)
    case .sus4:
        pitchList.append(rootPitch+5)
        pitchList.append(rootPitch+7)
    case .aug:
        pitchList.append(rootPitch+5)
        pitchList.append(rootPitch+8)
    case .dim:
        pitchList.append(rootPitch+3)
        pitchList.append(rootPitch+6)
    }
        
    // 7th, 6th음
    switch chord.seventh{
    case .none:
        break
    case .dom7:
        pitchList.append(rootPitch+10)
    case .maj7:
        pitchList.append(rootPitch+11)
    case .sixth:
        pitchList.append(rootPitch+9)
    }
    
    for i in pitchList{
        piano.play(at: Pitch(midiNote: i))
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
        for i in pitchList{
            piano.stop(at: Pitch(midiNote: i))
        }
    })

}
