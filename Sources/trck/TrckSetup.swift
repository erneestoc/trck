import Foundation

public enum TrckType {
  case regular
  case distance
  case time
  case pace
  case nofeedback
}

public struct TrckSetup {
  let unitSystem:TrckUnitSystem
  let voiceFeedback:TrckType

  let halfsUnits:Int

  let distance:Double
  let time:Int
  let language:String

  public init() {
    unitSystem = .metric
    voiceFeedback = .nofeedback
    distance = 0.0
    time = 0
    halfsUnits = 0
    language = Locale.current.languageCode ?? ""
  }

  public init(unitSystem:TrckUnitSystem,
              voiceFeedback:TrckType,
              halfsUnits:Int = 0,
              distance:Double = 0.0,
              time:Int = 0,
              language:String? = Locale.current.languageCode) {
    self.unitSystem = unitSystem
    self.voiceFeedback = voiceFeedback
    self.distance = distance
    self.time = time
    self.halfsUnits = halfsUnits
    self.language = language ?? ""
  }
}
