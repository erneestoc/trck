import CoreLocation
import RxSwift

class Trck {
  public var text = "Hello, World!"
  private let setup:TrckSetup
  private var time = 0
  private var distance = 0.0
  private var locationBuffer = [CLLocation]()
  init(setup:TrckSetup) {
    self.setup = setup
  }
  init() {
    self.setup = TrckSetup()
  }

  public func start() {
    
  }
}
