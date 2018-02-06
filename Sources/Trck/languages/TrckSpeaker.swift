#if !TEST
import AVFoundation

class TrckSpeaker:NSObject {
  private typealias TrckSpeech = (speech:String, language:String)
  private let speechSynthesizer = AVSpeechSynthesizer()
  private var audioSession = AVAudioSession.sharedInstance()
  private let utteranceRate = AVSpeechUtteranceDefaultSpeechRate
  private var speechQueue = [TrckSpeech]()
  override init() {
    super.init()
    speechSynthesizer.delegate = self
  }
  public func speak(string:String, language:String) {
    speechQueue.append((string, language))
    flush()
  }

  private func flush() {
    if !speechSynthesizer.isSpeaking {
      startDucking()
      sayNext()
    }
  }

  private func sayNext() {
    let nextSpeech = speechQueue.remove(at: 0)
    speechSynthesizer.stopSpeaking(at: .immediate)
    let utterance = getUtteranceFor(nextSpeech)
    speechSynthesizer.speak(utterance)
  }

  private func getUtteranceFor(_ speech:TrckSpeech) -> AVSpeechUtterance {
    let utterance = AVSpeechUtterance(string: speech.0)
    utterance.voice = AVSpeechSynthesisVoice(language: speech.1)
    utterance.rate = utteranceRate
    utterance.preUtteranceDelay = 0.5
    utterance.postUtteranceDelay = 0.5
    return utterance
  }

  private func startDucking() {
    audioSession = AVAudioSession.sharedInstance()
    print("[TrckSpeaker] - start audio ducking")
    do {
      try audioSession.setCategory(AVAudioSessionCategoryPlayback, with: .duckOthers)
      try audioSession.setActive(true)
    } catch let error as NSError {
      print(error)
    }
  }
  private func stopDucking() {
    print("[TrckSpeaker] - stop audio ducking")
    do {
      try audioSession.setCategory(AVAudioSessionCategoryPlayback, with: .mixWithOthers)
      try audioSession.setActive(false)
    } catch let error as NSError {
      print(error)
    }
  }
}

extension TrckSpeaker: AVSpeechSynthesizerDelegate {
  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
    if speechQueue.isEmpty {
      let when = DispatchTime.now() + 1
      DispatchQueue.main.asyncAfter(deadline: when) { [weak self] in
        self?.stopDucking()
      }
    } else {
      sayNext()
    }
  }
}
#endif
