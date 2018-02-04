import XCTest
@testable import Trck

class TrckLocationManagerTests: XCTestCase {
  func testSingleton() {
    let instance1 = TrckLocationManager.sharedInstance(true)
    let instance2 = TrckLocationManager.sharedInstance()
    XCTAssertEqual(instance1, instance2)
  }

  func testGPXLocationManager() {
    let gpxString = loadGPX()
    let instance = TrckLocationManager.sharedInstance(true)
    instance.load(gpxString)
    let location1 = instance.currentLocation(0)!
    XCTAssertEqual(location1.coordinate.latitude, 56.16419)

    let location2 = instance.currentLocation(1)!
    XCTAssertNotEqual(location2.coordinate.latitude, 56.16419)
  }

  static var allTests = [
    ("testSingleton", testSingleton),
    ("testGPXLocationManager", testGPXLocationManager)
  ]

  private func loadGPX()->NSString {
    let fileManager = FileManager.default
    let path = "\(fileManager.currentDirectoryPath)/Tests/trckTests/gpx/"
    return try! NSString(contentsOfFile: "\(path)/Stirling_Marathon_Rough.gpx", encoding: 4)
  }
}
