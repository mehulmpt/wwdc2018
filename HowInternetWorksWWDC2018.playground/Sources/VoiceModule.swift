import Foundation
import AVFoundation

public class VoiceModule {
    private static let synth = AVSpeechSynthesizer()
    private static let clickSound = Bundle.main.url(forResource: "click", withExtension: "mp3")
    private static let mainSound = Bundle.main.url(forResource: "mainbg", withExtension: "mp3")
    private static let learnSound = Bundle.main.url(forResource: "learnbg", withExtension: "mp3")
    private static var clickSoundPlayer: AVAudioPlayer! = nil
    private static var mainbgPlayer: AVAudioPlayer! = nil
    private static var learningPlayer: AVAudioPlayer! = nil
    
    public static func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synth.speak(utterance)
    }
    
    public static func stop() {
        if(synth.isSpeaking) {
            synth.stopSpeaking(at: AVSpeechBoundary.immediate)
        }
    }
    
    
    public static func click() {
        do {
            clickSoundPlayer = try AVAudioPlayer(contentsOf: clickSound!)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            clickSoundPlayer.volume = 0.2
            clickSoundPlayer.play()
        } catch {
            print(error)
        }
    }
    
    public static func mainbgPlay() {
        if(mainbgPlayer == nil) {
            do {
                mainbgPlayer = try AVAudioPlayer(contentsOf: mainSound!)
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
                try AVAudioSession.sharedInstance().setActive(true)
                mainbgPlayer.volume = 0.8
                mainbgPlayer.play()
                mainbgPlayer.numberOfLoops = -1
            } catch {
                print(error)
            }
        }
    }
    
    public static func mainbgPause() {
        if(mainbgPlayer != nil && mainbgPlayer.isPlaying) {
            mainbgPlayer.stop()
            mainbgPlayer = nil
        }
    }
    
    public static func learnPlay() {
        if(learningPlayer == nil) {
            do {
                learningPlayer = try AVAudioPlayer(contentsOf: learnSound!)
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
                try AVAudioSession.sharedInstance().setActive(true)
                learningPlayer.volume = 0.2
                learningPlayer.play()
                learningPlayer.numberOfLoops = -1
            } catch {
                print(error)
            }
        }
    }
    
    public static func learnPause() {
        if(learningPlayer != nil && learningPlayer.isPlaying) {
            learningPlayer.stop()
            learningPlayer = nil
        }
    }
}
