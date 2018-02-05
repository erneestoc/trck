import XCTest
@testable import Trck

class TrckTypesAndHelpersTests: XCTestCase {

  func testTimeConverterZero() {
    let time = 0
    let tuple = convertTimeToTimeTuple(time)
    XCTAssertEqual(tuple.0, 0)
    XCTAssertEqual(tuple.1, 0)
    XCTAssertEqual(tuple.2, 0)
  }

  func testTimeConverterOneMinute() {
    let time = 60
    let tuple = convertTimeToTimeTuple(time)
    XCTAssertEqual(tuple.0, 0)
    XCTAssertEqual(tuple.1, 1)
    XCTAssertEqual(tuple.2, 0)
  }

  func testTimeConverterOneHour() {
    let time = 3600
    let tuple = convertTimeToTimeTuple(time)
    XCTAssertEqual(tuple.0, 1)
    XCTAssertEqual(tuple.1, 0)
    XCTAssertEqual(tuple.2, 0)
  }

  func testTimeConverterMinuteAndHalf() {
    let time = 90
    let tuple = convertTimeToTimeTuple(time)
    XCTAssertEqual(tuple.0, 0)
    XCTAssertEqual(tuple.1, 1)
    XCTAssertEqual(tuple.2, 30)
  }

  func testTimeConverterTwoHoursAndMinuteAndHalf() {
    let time = 7290
    let tuple = convertTimeToTimeTuple(time)
    XCTAssertEqual(tuple.0, 2)
    XCTAssertEqual(tuple.1, 1)
    XCTAssertEqual(tuple.2, 30)
  }

  func testDistanceConverterZeroKMS() {
    let distance = 0.0
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .metric)
    XCTAssertEqual(tuple.0, 0)
    XCTAssertEqual(tuple.1, 0)
  }

  func testDistanceConverterZeroMILES() {
    let distance = 0.0
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .royal)
    XCTAssertEqual(tuple.0, 0)
    XCTAssertEqual(tuple.1, 0)
  }

  func testDistanceConverterOneKM() {
    let distance = 1000.0
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .metric)
    XCTAssertEqual(tuple.0, 1)
    XCTAssertEqual(tuple.1, 0)
  }

  func testDistanceConverterOneMILE() {
    let distance = 1609.0
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .royal)
    XCTAssertEqual(tuple.0, 1)
    XCTAssertEqual(tuple.1, 0)
  }

  func testDistanceConverterTwoKMS() {
    let distance = 2000.0
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .metric)
    XCTAssertEqual(tuple.0, 2)
    XCTAssertEqual(tuple.1, 0)
  }

  func testDistanceConverterTwoMILES() {
    let distance = 3218.0
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .royal)
    XCTAssertEqual(tuple.0, 2)
    XCTAssertEqual(tuple.1, 0)
  }

  func testDistanceConverterHalfKM() {
    let distance = 500.0
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .metric)
    XCTAssertEqual(tuple.0, 0)
    XCTAssertEqual(tuple.1, 50)
  }

  func testDistanceConverterHalfMILE() {
    let distance = 804.5
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .royal)
    XCTAssertEqual(tuple.0, 0)
    XCTAssertEqual(tuple.1, 50)
  }

  func testDistanceConverterThreeKMandThreeQuarters() {
    let distance = 3750.0
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .metric)
    XCTAssertEqual(tuple.0, 3)
    XCTAssertEqual(tuple.1, 75)
  }

  func testDistanceConverterThreeMILEandThreeQuarters() {
    let distance = 6033.75
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .royal)
    XCTAssertEqual(tuple.0, 3)
    XCTAssertEqual(tuple.1, 75)
  }

  func testDistanceConverterDotFiveKMS() {
    let distance = 50.0
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .metric)
    XCTAssertEqual(tuple.0, 0)
    XCTAssertEqual(tuple.1, 5)
  }

  func testDistanceConverterDotFiveMiles() {
    let distance = 80.45
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .royal)
    XCTAssertEqual(tuple.0, 0)
    XCTAssertEqual(tuple.1, 5)
  }

  func testDistanceConverterTwoDotFiveKMS() {
    let distance = 2050.0
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .metric)
    XCTAssertEqual(tuple.0, 2)
    XCTAssertEqual(tuple.1, 5)
  }

  func testDistanceConverterTwoDotFiveMiles() {
    let distance = 3299.0
    let tuple = convertDistanceToDistanceTuple(distance, unitSystem: .royal)
    XCTAssertEqual(tuple.0, 2)
    XCTAssertEqual(tuple.1, 5)
  }

  func testPaceOnZeroKMS() {
    let tuple = convertTimeAndDistanceToPaceTuple(0.0, unitSystem: .metric)
    XCTAssertEqual(tuple.0, 0)
    XCTAssertEqual(tuple.1, 0)
  }

  func testPaceOnZeroMILES() {
    let tuple = convertTimeAndDistanceToPaceTuple(0.0, unitSystem: .royal)
    XCTAssertEqual(tuple.0, 0)
    XCTAssertEqual(tuple.1, 0)
  }

  func testPaceOnePerMile() {
    let time = 60
    let distance = 1609.0
    let tuple = convertTimeAndDistanceToPaceTuple(Double(time) / distance, unitSystem: .royal)
    XCTAssertEqual(tuple.0, 1)
    XCTAssertEqual(tuple.1, 0)
  }

  func testPaceOnePerKm() {
    let time = 60
    let distance = 1000.0
    let tuple = convertTimeAndDistanceToPaceTuple(Double(time) / distance, unitSystem: .metric)
    XCTAssertEqual(tuple.0, 1)
    XCTAssertEqual(tuple.1, 0)
  }

  func testPaceFivePerMile() {
    let time = (60 * 5)
    let distance = 1609.0
    let tuple = convertTimeAndDistanceToPaceTuple(Double(time) / distance, unitSystem: .royal)
    XCTAssertEqual(tuple.0, 5)
    XCTAssertEqual(tuple.1, 0)
  }

  func testPaceFivePerKm() {
    let time = (60 * 5)
    let distance = 1000.0
    let tuple = convertTimeAndDistanceToPaceTuple(Double(time) / distance, unitSystem: .metric)
    XCTAssertEqual(tuple.0, 5)
    XCTAssertEqual(tuple.1, 0)
  }

  static var allTests = [
    ("testTimeConverterZero", testTimeConverterZero),
    ("testTimeConverterOneMinute", testTimeConverterOneMinute),
    ("testTimeConverterOneHour", testTimeConverterOneHour),
    ("testTimeConverterMinuteAndHalf", testTimeConverterMinuteAndHalf),
    ("testTimeConverterTwoHoursAndMinuteAndHalf", testTimeConverterTwoHoursAndMinuteAndHalf),
    ("testDistanceConverterZeroKMS", testDistanceConverterZeroKMS),
    ("testDistanceConverterZeroMILES", testDistanceConverterZeroMILES),
    ("testDistanceConverterOneKM", testDistanceConverterOneKM),
    ("testDistanceConverterOneMILE", testDistanceConverterOneMILE),
    ("testDistanceConverterTwoKMS", testDistanceConverterTwoKMS),
    ("testDistanceConverterTwoMILES", testDistanceConverterTwoMILES),
    ("testDistanceConverterHalfKM", testDistanceConverterHalfKM),
    ("testDistanceConverterHalfMILE", testDistanceConverterHalfMILE),
    ("testDistanceConverterThreeKMandThreeQuarters", testDistanceConverterThreeKMandThreeQuarters),
    ("testDistanceConverterThreeMILEandThreeQuarters", testDistanceConverterThreeMILEandThreeQuarters),
    ("testDistanceConverterDotFiveKMS", testDistanceConverterDotFiveKMS),
    ("testDistanceConverterDotFiveMiles", testDistanceConverterDotFiveMiles),
    ("testDistanceConverterTwoDotFiveKMS", testDistanceConverterTwoDotFiveKMS),
    ("testDistanceConverterTwoDotFiveMiles", testDistanceConverterTwoDotFiveMiles),
    ("testPaceOnZeroKMS", testPaceOnZeroKMS),
    ("testPaceOnZeroMILES", testPaceOnZeroMILES)
  ]
}
