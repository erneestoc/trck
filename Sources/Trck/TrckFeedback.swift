class TrckFeedback {

  private let language:TrckFeedbackProtocol
  private let setup:TrckSetup

  private var nextFeedbackDistance = 0.0
  private var nextFeedbackTime = 0
  private var reachedMidpoint = false
  private var reachedGoal = false

  init(setup:TrckSetup) {
    self.setup = setup
    switch setup.language {
    default:
      self.language = TrckEnglishFeedback(setup: setup)
    }
    setupNextFeedbackFor(setup)
  }

  public func feedbackFor(distance:Double, time:Int, speed:Double = 0.0) -> String? {
    switch setup.voiceFeedback {
    case .regular:
    return regularFeedback(distance: distance, time: time)
    case .distance:
    return distanceFeedback(distance: distance, time: time)
    case .time:
    return timeFeedback(distance: distance, time: time)
    case .pace:
    return paceFeedback(distance: distance, time: time, speed: speed)
    default: return nil
    }
  }

  private func regularFeedback(distance:Double, time:Int) -> String? {
    if distance >= nextFeedbackDistance {
      setupNextFeedbackFor(setup)
      return language.feedbackFor(distance: distance, time: time, pace: Double(time) / distance)
    } else {
      return nil
    }
  }

  private func distanceFeedback(distance:Double, time:Int) -> String? {
    if !reachedGoal && distance >= setup.distance {
      reachedGoal = true
      if distance >= nextFeedbackDistance {
        setupNextFeedbackFor(setup)
      }
      return language.goalCompletedFeedbackFor(distance: distance, time: time, pace: Double(time) / distance)
    } else if !reachedMidpoint && distance >= (setup.distance / 2) {
      reachedMidpoint = true
      if distance >= nextFeedbackDistance {
        setupNextFeedbackFor(setup)
      }
      return language.descendingFeedbackFor(distance: setup.distance - distance, time: time, pace: Double(time) / distance)
    } else if distance >= nextFeedbackDistance {
      setupNextFeedbackFor(setup)
      if reachedMidpoint && !reachedGoal {
        return language.descendingFeedbackFor(distance: setup.distance - distance, time: time, pace: Double(time) / distance)
      } else {
        return language.feedbackFor(distance: distance, time: time, pace: Double(time) / distance)
      }
    } else {
      return nil
    }
  }

  private func timeFeedback(distance:Double, time:Int) -> String? {
    return nil
  }

  private func paceFeedback(distance:Double, time:Int, speed:Double) -> String? {
    return nil
  }

  private func setupNextFeedbackFor(_ setup:TrckSetup) {
    switch setup.voiceFeedback {
    case .regular, .distance:
    nextFeedbackDistance += Double(setup.halfsUnits) * (setup.unitSystem == .metric ? 500.0 : 804.5)
    case .time:
    nextFeedbackTime += setup.halfsUnits * 30
    default: break
    }
  }
}
