import XCTest
@testable import Trck

class TrckFeedbackEnglishTests: XCTestCase {

  func testVoiceFeedbackForKilometers() {
    let setup = TrckSetup(unitSystem: .metric, voiceFeedback: .regular, halfsUnits: 2)
    let feedback = TrckFeedback(setup: setup)
    let underKM = feedback.feedbackFor(distance: 900.0, time: 60 * 4)
    XCTAssertEqual(underKM, nil)
    let overKM = feedback.feedbackFor(distance: 1001.0, time: 60 * 5)
    XCTAssertNotEqual(overKM, nil)
    let string = "distance, 1, kilometer, completed, time, 5, minutes, 0, seconds, average pace, 4, 59, per kilometer"
    XCTAssertNotNil(overKM)
    XCTAssertEqual(overKM!, string)
    let overKMAgain = feedback.feedbackFor(distance: 1001.0, time: 60 * 5)
    XCTAssertEqual(overKMAgain, nil)

    let over2ndKM = feedback.feedbackFor(distance: 2001.0, time: 60 * 10)
    XCTAssertNotEqual(over2ndKM, nil)
    let string2 = "distance, 2, kilometers, completed, time, 10, minutes, 0, seconds, average pace, 4, 59, per kilometer"
    XCTAssertNotNil(over2ndKM)
    XCTAssertEqual(over2ndKM!, string2)
  }

  func testVoiceFeedbackForMiles() {
    let setup = TrckSetup(unitSystem: .royal, voiceFeedback: .regular, halfsUnits: 2)
    let feedback = TrckFeedback(setup: setup)
    let underMile = feedback.feedbackFor(distance: 1500.0, time: 60 * 4)
    XCTAssertEqual(underMile, nil)
    let overMile = feedback.feedbackFor(distance: 1610.0, time: 60 * 5)
    XCTAssertNotEqual(overMile, nil)
    let string = "distance, 1, mile, completed, time, 5, minutes, 0, seconds, average pace, 4, 59, per mile"
    XCTAssertEqual(overMile!, string)
    let overMileAgain = feedback.feedbackFor(distance: 1610.0, time: 60 * 5)
    XCTAssertEqual(overMileAgain, nil)

    let over2ndMile = feedback.feedbackFor(distance: 3219.0, time: 60 * 10)
    XCTAssertNotEqual(over2ndMile, nil)
    let string2 = "distance, 2, miles, completed, time, 10, minutes, 0, seconds, average pace, 4, 59, per mile"
    XCTAssertEqual(over2ndMile!, string2)
  }

  func testHalfKilometerConfig() {
    let setup = TrckSetup(unitSystem: .metric, voiceFeedback: .regular, halfsUnits: 1)
    let feedback = TrckFeedback(setup: setup)
    let underKM = feedback.feedbackFor(distance: 490.0, time: 60 * 4)
    XCTAssertEqual(underKM, nil)
    let overKM = feedback.feedbackFor(distance: 501.0, time: 60 * 5)
    XCTAssertNotEqual(overKM, nil)
    let str = "distance, point, 5, kilometers, completed, time, 5, minutes, 0, seconds, average pace, 9, 58, per kilometer"
    XCTAssertNotNil(overKM)
    XCTAssertEqual(overKM!, str)
    let overKMAgain = feedback.feedbackFor(distance: 501.0, time: 60 * 5)
    XCTAssertEqual(overKMAgain, nil)

    let over2ndKM = feedback.feedbackFor(distance: 1001.0, time: 60 * 5)
    XCTAssertNotEqual(over2ndKM, nil)
    let string2 = "distance, 1, kilometer, completed, time, 5, minutes, 0, seconds, average pace, 4, 59, per kilometer"
    XCTAssertNotNil(over2ndKM)
    XCTAssertEqual(over2ndKM!, string2)
  }

  func testHalfMileConfig() {
    let setup = TrckSetup(unitSystem: .royal, voiceFeedback: .regular, halfsUnits: 1)
    let feedback = TrckFeedback(setup: setup)
    let underKM = feedback.feedbackFor(distance: 803.0, time: 60 * 4)
    XCTAssertEqual(underKM, nil)
    let overKM = feedback.feedbackFor(distance: 805.0, time: 60 * 5)
    XCTAssertNotEqual(overKM, nil)
    let str = "distance, point, 5, miles, completed, time, 5, minutes, 0, seconds, average pace, 9, 59, per mile"
    XCTAssertNotNil(overKM)
    XCTAssertEqual(overKM!, str)
    let overKMAgain = feedback.feedbackFor(distance: 1608.0, time: 60 * 5)
    XCTAssertEqual(overKMAgain, nil)

    let over2ndKM = feedback.feedbackFor(distance: 1609.0, time: 60 * 5)
    XCTAssertNotEqual(over2ndKM, nil)
    let string2 = "distance, 1, mile, completed, time, 5, minutes, 0, seconds, average pace, 5, 0, per mile"
    XCTAssertNotNil(over2ndKM)
    XCTAssertEqual(over2ndKM!, string2)
  }

  func testDistanceGoalKMS() {
    let setup = TrckSetup(unitSystem: .metric, voiceFeedback: .distance, halfsUnits: 2, distance: 2500.0)
    let feedback = TrckFeedback(setup: setup)
    let underKM = feedback.feedbackFor(distance: 803.0, time: 60 * 4)
    XCTAssertEqual(underKM, nil)
    let overKM = feedback.feedbackFor(distance: 1000.0, time: 60 * 5)
    let string = "distance, 1, kilometer, completed, time, 5, minutes, 0, seconds, average pace, 5, 0, per kilometer"
    XCTAssertNotNil(overKM)
    XCTAssertEqual(overKM!, string)
    let overKM2 = feedback.feedbackFor(distance: 1000.0, time: 60 * 5)
    XCTAssertEqual(overKM2, nil)
    let string2 = "distance, 1, point, 2, kilometers, to go, time, 7, minutes, 0, seconds, average pace, 5, 36, per kilometer"
    let overKM3 = feedback.feedbackFor(distance: 1250.0, time: 60 * 7)
    XCTAssertNotNil(overKM3)
    XCTAssertEqual(overKM3!, string2)

    let string3 = "distance, point, 5, kilometers, to go, time, 10, minutes, 45, seconds, average pace, 5, 22, per kilometer"
    let overKM4 = feedback.feedbackFor(distance: 2000.0, time: (60 * 10) + 45)
    XCTAssertNotNil(overKM4)
    XCTAssertEqual(overKM4!, string3)

    let string4 = "GOAL, COMPLETED!, distance, 2, point, 5, kilometers, completed, time, 12, minutes, 49, seconds, average pace, 5, 7, per kilometer"
    let overKM5 = feedback.feedbackFor(distance: 2500.0, time: (60 * 12) + 49)
    XCTAssertNotNil(overKM5)
    XCTAssertEqual(overKM5!, string4)

    let overKM6 = feedback.feedbackFor(distance: 2600.0, time: (60 * 12) + 49)
    XCTAssertNil(overKM6)
  }

  static var allTests = [
    ("testVoiceFeedbackForKilometers", testVoiceFeedbackForKilometers),
    ("testVoiceFeedbackForMiles", testVoiceFeedbackForMiles),
    ("testHalfKilometerConfig", testHalfKilometerConfig),
    ("testHalfMileConfig", testHalfMileConfig)
  ]
}
