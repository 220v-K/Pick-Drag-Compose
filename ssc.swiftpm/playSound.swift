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

func playSong(chords: [Chord], chords2: [Chord], ChordOB: ChordList, howAccompany: HowAccompany){
//    let piano = Piano.default
    var currentIndex = 0

    playBars()
    
    func playBars(){
        playBar(chord: chords[currentIndex], chord2: chords2[currentIndex], howAccompany: howAccompany)
        currentIndex += 1
        if currentIndex == ChordOB.barCnt {
            return
        }
        // Recursion Call로 2초마다 재생 구현
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: playBars)
    }
    
}

func playBar(chord: Chord, chord2: Chord, howAccompany: HowAccompany){
    let piano = Piano.default
    let noteDict: [String: Int] = ["C": 0, "D": 2, "E": 4, "F": 5, "G": 7, "A": 9, "B": 11]
    // root음 설정
    var rootPitch: Int = noteDict[chord.root.rawValue] ?? 0
    var rootPitch2: Int = noteDict[chord2.root.rawValue] ?? 0
    rootPitch += 12*(chord.octave+1)
    rootPitch2 += 12*(chord.octave+1)
    switch chord.half{
    case .none:
        break
    case .flat:
        rootPitch -= 1
    case .sharp:
        rootPitch += 1
    }
    switch chord2.half{
    case .none:
        break
    case .flat:
        rootPitch2 -= 1
    case .sharp:
        rootPitch2 += 1
    }
    
    // 페달링
    if (chord2.isEnabled){
        piano.pedalOn()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.95, execute: {
            piano.pedalOff()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.99, execute: {
            piano.pedalOn()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.95, execute: {
            piano.pedalOff()
        })
    } else {
        piano.pedalOn()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.95, execute: {
            piano.pedalOff()
        })
    }
    
    // 왼손 반주
    // Basic => 왼손 옥타브, 오른손 코드 정직하게 박마다 한번
    // Arpeggio => 왼손 2박땐 1-5-8 / 4박땐 1-5-8-9-10 아르페지오, 오른손 코드 박마다 한번
    if(howAccompany == .Basic){
        //왼손 반주
        if (chord2.isEnabled){
            // root음 1, 2옥타브 밑을 근음으로 연주
            // 2박까지 앞 코드
            piano.play(at: Pitch(rawValue: rootPitch-12))
            piano.play(at: Pitch(rawValue: rootPitch-24))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.95, execute: {
                piano.stop(at: Pitch(rawValue: rootPitch-12))
                piano.stop(at: Pitch(rawValue: rootPitch-24))
                piano.pedalOff()
            })
            
            // 3~4박은 뒷 코드
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                piano.play(at: Pitch(rawValue: rootPitch2-12))
                piano.play(at: Pitch(rawValue: rootPitch2-24))
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.95, execute: {
                piano.stop(at: Pitch(rawValue: rootPitch2-12))
                piano.stop(at: Pitch(rawValue: rootPitch2-24))
            })
        }else{
            // root음 1, 2옥타브 밑을 근음으로 연주
            piano.play(at: Pitch(rawValue: rootPitch-12))
            piano.play(at: Pitch(rawValue: rootPitch-24))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.95, execute: {
                piano.stop(at: Pitch(rawValue: rootPitch-12))
                piano.stop(at: Pitch(rawValue: rootPitch-24))
            })
        }
    } else if (howAccompany == .Arpeggio){
        var playedList: [Int] = []
        if (chord2.isEnabled){
            // Chord 1
            piano.play(at: Pitch(rawValue: rootPitch-12))   // 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {   // 5
                if (chord.third == .aug) {
                    piano.play(at: Pitch(rawValue: rootPitch-4))
                    playedList.append(rootPitch-4)
                } else if (chord.third == .dim) {
                    piano.play(at: Pitch(rawValue: rootPitch-6))
                    playedList.append(rootPitch-6)
                } else {
                    piano.play(at: Pitch(rawValue: rootPitch-5))
                    playedList.append(rootPitch-5)
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {    // 8
                piano.play(at: Pitch(rawValue: rootPitch))
                playedList.append(rootPitch)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.95, execute: {   // stop
                for i in playedList {
                    piano.stop(at: Pitch(rawValue: i))
                }
            })
            // Chord 2
            playedList = []
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {   // 1
                piano.play(at: Pitch(rawValue: rootPitch2-12))
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25, execute: {   // 5
                if (chord.third == .aug) {
                    piano.play(at: Pitch(rawValue: rootPitch2-4))
                    playedList.append(rootPitch2-4)
                } else if (chord.third == .dim) {
                    piano.play(at: Pitch(rawValue: rootPitch2-6))
                    playedList.append(rootPitch2-6)
                } else {
                    piano.play(at: Pitch(rawValue: rootPitch2-5))
                    playedList.append(rootPitch2-5)
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {    // 8
                piano.play(at: Pitch(rawValue: rootPitch2))
                playedList.append(rootPitch2)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.95, execute: {   // stop
                for i in playedList {
                    piano.stop(at: Pitch(rawValue: i))
                }
            })
        } else {
            piano.play(at: Pitch(rawValue: rootPitch-12))   // 1
            playedList.append(rootPitch-12)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {   // 5
                if (chord.third == .aug) {
                    piano.play(at: Pitch(rawValue: rootPitch-4))
                    playedList.append(rootPitch-4)
                } else if (chord.third == .dim) {
                    piano.play(at: Pitch(rawValue: rootPitch-6))
                    playedList.append(rootPitch-6)
                } else {
                    piano.play(at: Pitch(rawValue: rootPitch-5))
                    playedList.append(rootPitch-5)
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {    // 8
                piano.play(at: Pitch(rawValue: rootPitch))
                playedList.append(rootPitch)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: {   // 9
                piano.play(at: Pitch(rawValue: rootPitch+2))
                playedList.append(rootPitch+2)
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {    // 10
                if (chord.third == .min || chord.third == .dim) {
                    piano.play(at: Pitch(rawValue: rootPitch+3))
                    playedList.append(rootPitch+3)
                } else {
                    piano.play(at: Pitch(rawValue: rootPitch+4))
                    playedList.append(rootPitch+4)
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.95, execute: {   // stop
                for i in playedList {
                    piano.stop(at: Pitch(rawValue: i))
                }
            })
        }
    } else{
        // 이후 연주법 추가를 위해 남겨둠
    }
    
    
    // 오른손 반주
    // Basic => 기본 박마다 1번씩 총 2번 / 4번
    // Arpeggio => 2박마다 1번씩. 1-5-8에서는 1과 같은 박, 1-5-8-9-10에서는 1, 10과 같은 박.
    if (howAccompany == .Basic){
        if (chord2.isEnabled){
            playTwice(chord: chord)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                playTwice(chord: chord2)
            })
        } else {
            playFourTimes(chord: chord)
        }
    } else if (howAccompany == .Arpeggio) {
        if (chord2.isEnabled){
            playChord(chord: chord)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                playChord(chord: chord2)
            })
        } else {
            playChord(chord: chord)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                playChord(chord: chord)
            })
        }
    } else {
        // for Later..
    }
    
    
    func playTwice(chord: Chord){
        // 1초마다 연주
        playChord(chord: chord)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            playChord(chord: chord)
        })
        
        
    }

    func playFourTimes(chord: Chord){
        playChord(chord: chord)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            playChord(chord: chord)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            playChord(chord: chord)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            playChord(chord: chord)
        })
    }
}



func playChord(chord: Chord){
    let piano = Piano.default
    let noteDict: [String: Int] = ["C": 0, "D": 2, "E": 4, "F": 5, "G": 7, "A": 9, "B": 11]
    var pitchList : [Int] = []
    
    // root음 넣고(Half 따라 조절)
    var rootPitch: Int = noteDict[chord.root.rawValue] ?? 0
    rootPitch += 12*(chord.octave+1)
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
    if (chord.inversion < 1){
        pitchList.append(rootPitch)
    } else {
        // 1st inversion 이상 -> root음 한옥타브 up.
        pitchList.append(rootPitch+12)
    }
    
    // 3, 5음 넣기
    var thirdPitch: Int = rootPitch+4
    var fifthPitch: Int = rootPitch+7
    switch chord.third{
    case .none:
        break
    case .min:
        thirdPitch -= 1
    case .sus2:
        thirdPitch -= 2
    case .sus4:
        thirdPitch += 1
    case .aug:
        fifthPitch += 1
    case .dim:
        thirdPitch -= 1
        fifthPitch -= 1
    }
    
    switch chord.inversion{
    case 2:
        pitchList.append(thirdPitch+12)
        pitchList.append(fifthPitch)
    case 3:
        pitchList.append(thirdPitch+12)
        pitchList.append(fifthPitch+12)
    default:
        pitchList.append(thirdPitch)
        pitchList.append(fifthPitch)
    }
        
    // 7th, 6th음
    // 7th, 6th 텐션음이 추가될 시 오른손 Root음 제거
    switch chord.seventh{
    case .none:
        break
    case .dom7:
        pitchList.removeFirst()
        pitchList.append(rootPitch+10)
    case .maj7:
        pitchList.removeFirst()
        pitchList.append(rootPitch+11)
    case .sixth:
        pitchList.removeFirst()
        pitchList.append(rootPitch+9)
    }
    print(pitchList)
    print(chord)
    
    // playChord's piano Pedal
//    piano.pedalOn()
    for i in pitchList{
        piano.play(at: Pitch(midiNote: i))
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
        for i in pitchList{
            piano.stop(at: Pitch(midiNote: i))
        }
//        piano.pedalOff()
    })

}
