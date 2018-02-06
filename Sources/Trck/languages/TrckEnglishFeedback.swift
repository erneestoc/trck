class TrckEnglishFeedback {
  var setup:TrckSetup
  init(setup:TrckSetup) {
    self.setup = setup
  }
}

extension TrckEnglishFeedback: TrckFeedbackProtocol {

  func goalCompletedFeedbackFor(distance:Double, time:Int, pace:Double) -> String {
    return "GOAL, COMPLETED!, \(feedbackFor(distance: distance, time: time, pace: pace))"
  }

  func feedbackFor(distance:Double, time:Int, pace:Double) -> String {
    return "\(distanceString(distance)), completed, \(timeString(time)), \(paceString(pace))"
  }

  func descendingFeedbackFor(distance:Double, time:Int, pace:Double) -> String {
    return "\(distanceString(distance)), to go, \(timeString(time)), \(paceString(pace))"
  }

  private func distanceString(_ distance:Double) -> String {
    let distanceTuple = convertDistanceToDistanceTuple(distance, unitSystem: setup.unitSystem)
    if distanceTuple.0 == 0 && distanceTuple.1 == 0 {
      let unitSystemString = pluralUnitSystemString(setup.unitSystem)
      return "distance, zero, point, zero, \(unitSystemString)"
    } else if distanceTuple.0 == 1 && distanceTuple.1 == 0 {
      let unitSystemString = setup.unitSystem == .metric ? "kilometer" : "mile"
      return "distance, \(distanceTuple.0), \(unitSystemString)"
    } else if distanceTuple.0 == 0 && distanceTuple.1 != 0 {
      let unitSystemString = pluralUnitSystemString(setup.unitSystem)
      return "distance, point, \(secondUnit(distanceTuple.1)), \(unitSystemString)"
    } else if distanceTuple.0 != 0 && distanceTuple.1 == 0 {
      let unitSystemString = pluralUnitSystemString(setup.unitSystem)
      return "distance, \(distanceTuple.0), \(unitSystemString)"
    } else {
      let unitSystemString = pluralUnitSystemString(setup.unitSystem)
      let string1 = "distance, \(distanceTuple.0), point,"
      return "\(string1) \(secondUnit(distanceTuple.1)), \(unitSystemString)"
    }
  }

  private func secondUnit(_ second:Int) -> Int {
    if second < 10 {
      return 0
    } else {
      return Int(Double(second) / 10.0)
    }
  }

  private func pluralUnitSystemString(_ unitSystem:TrckUnitSystem) -> String {
    let string = unitSystem == .metric ? "kilometers" : "miles"
    return string
  }

  private func timeString(_ time:Int) -> String {
    let timeTuple = convertTimeToTimeTuple(time)
    if timeTuple.0 == 0 && timeTuple.1 == 0 {
      return "time, \(timeTuple.2), seconds"
    } else if timeTuple.0 == 0 {
      return "time, \(timeTuple.1), \(minutesPluralized(timeTuple.1)), \(timeTuple.2), seconds"
    } else {
      let hours = "time, \(timeTuple.0), \(hoursPluralized(timeTuple.0)),"
      return "\(hours) \(timeTuple.1), \(minutesPluralized(timeTuple.1)), \(timeTuple.2), seconds"
    }
  }

  private func minutesPluralized(_ minute:Int) -> String {
    return minute == 1 ? "minute" : "minutes"
  }

  private func hoursPluralized(_ hour:Int) -> String {
    return hour == 1 ? "hour" : "hours"
  }

  private func paceString(_ pace:Double) -> String {
    let unitSystemString = setup.unitSystem == .metric ? "kilometer" : "mile"
    let paceTuple = convertTimeAndDistanceToPaceTuple(pace, unitSystem: setup.unitSystem)
    return "average pace, \(paceTuple.0), \(paceTuple.1), per \(unitSystemString)"
  }
}
