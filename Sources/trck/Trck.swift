import CoreLocation
import RxSwift

typealias TrackingData = (location:CLLocation, speed:Double, time:Int, distance:Double)

class Trck {
  private let setup:TrckSetup
  private var time = 0
  private var distance = 0.0
  private var pace = 0.0
  private var locationQueue = [TrackingData]()
  private var lastLocation:CLLocation?

  private let secondsToRecalculate = 3
  private let logRequiredAccuracy = 42.0

  private var metric = true
  private unowned let locationManager = TrckLocationManager.sharedInstance()
  private let scheduler:SchedulerType

  private let feedback:TrckFeedback

  init(setup:TrckSetup, scheduler: SchedulerType = MainScheduler.instance) {
    self.scheduler = scheduler
    self.setup = setup
    self.feedback = TrckFeedback()
  }
  init(scheduler: SchedulerType = MainScheduler.instance) {
    self.scheduler = scheduler
    self.setup = TrckSetup()
    self.feedback = TrckFeedback()
  }

  public func start()->Observable<(TrackingData?, String?)> {
    return Observable<Int>.interval(1.0, scheduler: scheduler)
      .map(updateTimeAndGetCoordinate)
      .map(calculateMetrics)
      .map(checkVoiceFeedback)
  }

  private func updateTimeAndGetCoordinate(_ ticksSinceLastStart:Int)->CLLocation? {
    time += 1
    if time % secondsToRecalculate == 0 {
      return locationManager.currentLocation(time)
    } else {
      return nil
    }
  }

  private func calculateMetrics(currentLocation:CLLocation?)->TrackingData? {
    var data:TrackingData?
    if let currentLocation = currentLocation {
      if let lastLocation = lastLocation {
        let distanceToAdd = currentLocation.distance(from: lastLocation)
        distance += distanceToAdd
        let currentSpeed = distanceToAdd / Double(secondsToRecalculate)
        pace = distance / Double(time)
        data = (currentLocation, currentSpeed, time, distance)
        locationQueue.append(data!)
      } else {
        data = (currentLocation, 0.0, time, distance)
        locationQueue.append(data!)
      }
      lastLocation = currentLocation
    }
    return locationQueue.last
  }

  private func checkVoiceFeedback(trackingData:TrackingData?)->(trackingData:TrackingData?, feedback:String?) {
    guard let trackingData = trackingData else { return (nil, nil) }
    return (trackingData, feedback.feedbackFor(distance: trackingData.3, time:trackingData.2))
  }

  private func tick(_ time:Event<TrackingData?>) {
    // print(time)
  }
}
