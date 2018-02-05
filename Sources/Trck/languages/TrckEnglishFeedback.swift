class TrckEnglishFeedback {
  var setup:TrckSetup
  init(setup:TrckSetup) {
    self.setup = setup
  }
}

extension TrckEnglishFeedback: TrckFeedbackProtocol {
  func feedbackFor(distance:Double, time:Int, pace:Double) -> String {
    return ""
  }

  func descendingFeedbackFor(distance:Double, time:Int, pace:Double) -> String {
    return ""
  }
}
