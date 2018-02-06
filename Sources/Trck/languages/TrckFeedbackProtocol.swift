protocol TrckFeedbackProtocol {
  var setup:TrckSetup {get set}
  func feedbackFor(distance:Double, time:Int, pace:Double) -> String
  func descendingFeedbackFor(distance:Double, time:Int, pace:Double) -> String
  func goalCompletedFeedbackFor(distance:Double, time:Int, pace:Double) -> String
}
