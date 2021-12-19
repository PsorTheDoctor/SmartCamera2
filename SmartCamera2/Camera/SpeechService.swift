//
//  SpeechService.swift
//  SmartCamera2
//
//  Created by USER on 19/12/2021.
//

import SwiftUI
import AVFoundation

class SpeechService: ObservableObject {
    
    func speak(text: String) {
        let synthesizer = AVSpeechSynthesizer()
        let utterence = AVSpeechUtterance(string: text)
        utterence.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterence)
    }
}
