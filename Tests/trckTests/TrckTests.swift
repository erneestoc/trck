import XCTest
import RxCocoa
import RxSwift
import RxTest
@testable import Trck

class TrckTests: XCTestCase {

  func testTrackingFunctionality() {
    let gpxString = loadGPX()
    let instance = TrckLocationManager.sharedInstance(true)
    instance.load(gpxString)

    let scheduler = TestScheduler(initialClock: 0)
    let trck = Trck(scheduler: scheduler)
    trck.start()
    
    let xs = scheduler.createHotObservable([
            next(150, 1),  // first argument is virtual time, second argument is element value
            next(210, 2),
            next(220, 3),
            next(230, 4),
            next(240, 5),
            completed(300) // virtual time when completed is sent
            ])

    let res = scheduler.start {
      xs.map { $0 * 2 } //Observable<Int64>.interval(100, scheduler: scheduler)
    }

    print(res.events)
    trck.stop()
  }

  static var allTests = [
    ("testTrackingFunctionality", testTrackingFunctionality)
  ]

  private func loadGPX()->NSString {
    let fileManager = FileManager.default
    let path = "\(fileManager.currentDirectoryPath)/Tests/trckTests/gpx/"
    return try! NSString(contentsOfFile: "\(path)/Stirling_Marathon_Rough.gpx", encoding: 4)
  }
}
