import XCTest
import RxCocoa
import RxSwift
import RxTest
import CoreLocation
@testable import Trck

class TrckTests: XCTestCase {

  func testHalfMarathon() {
    let gpxString = loadGPX()
    let instance = TrckLocationManager.sharedInstance(true)
    instance.load(gpxString)

    let scheduler = TestScheduler(initialClock: 300)

    let trck = Trck(scheduler: scheduler)

    let res = scheduler.start(disposed: 7502) {
      trck.start()
    }

    trck.stop()
    let distance = res.events.last!.value.element!!.3
    XCTAssertEqualWithAccuracy(distance, 20100.0, accuracy: 100.0)
  }

  static var allTests = [
    ("testHalfMarathon", testHalfMarathon)
  ]

  private func loadGPX()->NSString {
    let fileManager = FileManager.default
    let path = "\(fileManager.currentDirectoryPath)/Tests/trckTests/gpx/"
    return try! NSString(contentsOfFile: "\(path)/Stirling_Marathon_Rough.gpx", encoding: 4)
  }

}
