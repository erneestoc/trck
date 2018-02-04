import XCTest
@testable import Trck

class TrckFeedbackEnglishTests: XCTestCase {

  func testVoiceFeedbackForKilometers() {
    let feedback = TrckFeedback()
    let underKM = feedback.feedbackFor(distance: 900.0, time: 60 * 4)
    XCTAssertEqual(underKM, nil)
    let overKM = feedback.feedbackFor(distance: 1001.0, time: 60 * 5)
    XCTAssertNotEqual(overKM, nil)
    XCTAssertEqual(overKM!, "1 kilometer, completed, time, 5 minutes, 0 seconds, average pace, 5, 0, per kilometer")
    let overKMAgain = feedback.feedbackFor(distance: 1001.0, time: 60 * 5)
    XCTAssertEqual(overKMAgain, nil)

    let over2ndKM = feedback.feedbackFor(distance: 2001.0, time: 60 * 10)
    XCTAssertNotEqual(over2ndKM, nil)
    XCTAssertEqual(over2ndKM!, "2 kilometers, completed, time, 10 minutes, 0 seconds, average pace, 5, 0, per kilometer")
  }

  func testVoiceFeedbackForMiles() {
    let feedback = TrckFeedback()
    let underMile = feedback.feedbackFor(distance: 1500.0, time: 60 * 4)
    XCTAssertEqual(underMile, nil)
    let overMile = feedback.feedbackFor(distance: 1610.0, time: 60 * 5)
    XCTAssertNotEqual(overMile, nil)
    XCTAssertEqual(overMile!, "1 mile, completed, time, 5 minutes, 0 seconds, average pace, 5, 0, per kilometer")
    let overMileAgain = feedback.feedbackFor(distance: 1610.0, time: 60 * 5)
    XCTAssertEqual(overMileAgain, nil)

    let over2ndMile = feedback.feedbackFor(distance: 3219.0, time: 60 * 10)
    XCTAssertNotEqual(over2ndMile, nil)
    XCTAssertEqual(over2ndMile!, "2 miles, completed, time, 10 minutes, 0 seconds, average pace, 5, 0, per mile")
  }

  func testHalfKilometerConfig() {
    let feedback = TrckFeedback()
    let underKM = feedback.feedbackFor(distance: 490.0, time: 60 * 4)
    XCTAssertEqual(underKM, nil)
    let overKM = feedback.feedbackFor(distance: 501.0, time: 60 * 5)
    XCTAssertNotEqual(overKM, nil)
    XCTAssertEqual(overKM!, "point, 5, kilometers, completed, time, 5 minutes, 0 seconds, average pace, 5, 0, per kilometer")
    let overKMAgain = feedback.feedbackFor(distance: 501.0, time: 60 * 5)
    XCTAssertEqual(overKMAgain, nil)

    let over2ndKM = feedback.feedbackFor(distance: 1001.0, time: 60 * 5)
    XCTAssertNotEqual(over2ndKM, nil)
    XCTAssertEqual(over2ndKM!, "1 kilometer, completed, time, 5 minutes, 0 seconds, average pace, 5, 0, per kilometer")
  }

  func testHalfMileConfig() {
    let feedback = TrckFeedback()
    let underKM = feedback.feedbackFor(distance: 803.0, time: 60 * 4)
    XCTAssertEqual(underKM, nil)
    let overKM = feedback.feedbackFor(distance: 805.0, time: 60 * 5)
    XCTAssertNotEqual(overKM, nil)
    XCTAssertEqual(overKM!, "point, 5, kilometers, completed, time, 5 minutes, 0 seconds, average pace, 5, 0, per kilometer")
    let overKMAgain = feedback.feedbackFor(distance: 1608.0, time: 60 * 5)
    XCTAssertEqual(overKMAgain, nil)

    let over2ndKM = feedback.feedbackFor(distance: 1609.0, time: 60 * 5)
    XCTAssertNotEqual(over2ndKM, nil)
    XCTAssertEqual(over2ndKM!, "1 kilometer, completed, time, 5 minutes, 0 seconds, average pace, 5, 0, per kilometer")
  }

  static var allTests = [
    ("testVoiceFeedbackForKilometers", testVoiceFeedbackForKilometers),
    ("testVoiceFeedbackForMiles", testVoiceFeedbackForMiles),
    ("testHalfKilometerConfig", testHalfKilometerConfig),
    ("testHalfMileConfig", testHalfMileConfig)
  ]
}