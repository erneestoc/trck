class TrckEnglishFeedback {
  var setup:TrckSetup
  init(setup:TrckSetup) {
    self.setup = setup
  }
}

extension TrckEnglishFeedback: TrckFeedbackProtocol {
  func feedbackFor(distance:Double, time:Int, pace:Double) -> String {
    return "\(distanceString(distance)), \(timeString(time)), \(paceString(pace))"
  }

  func descendingFeedbackFor(distance:Double, time:Int, pace:Double) -> String {
    return ""
  }

  private func distanceString(_ distance:Double) -> String {
    let distanceTuple = convertDistanceToDistanceTuple(distance, unitSystem: setup.unitSystem)
    if distanceTuple.0 == 0 && distanceTuple.1 == 0 {
      let unitSystemString = pluralUnitSystemString(setup.unitSystem)
      return "distance, zero, point, zero, \(unitSystemString), completed"
    } else if distanceTuple.0 == 1 && distanceTuple.1 == 0 {
      let unitSystemString = setup.unitSystem == .metric ? "kilometer" : "mile"
      return "distance, \(distanceTuple.0), \(unitSystemString), completed"
    } else if distanceTuple.0 == 0 && distanceTuple.1 != 0 {
      let unitSystemString = pluralUnitSystemString(setup.unitSystem)
      return "distance, point, \(distanceTuple.1), \(unitSystemString), completed"
    } else if distanceTuple.0 != 0 && distanceTuple.1 == 0 {
      let unitSystemString = pluralUnitSystemString(setup.unitSystem)
      return "distance, \(distanceTuple.0), \(unitSystemString), completed"
    } else {
      let unitSystemString = pluralUnitSystemString(setup.unitSystem)
      return "distance, \(distanceTuple.0), point, \(distanceTuple.1), \(unitSystemString), completed"
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
