import CoreLocation
import SWXMLHash

class TrckLocationManager:NSObject {

  typealias TrckLocation = (Int) -> CLLocation?
  private var locationLambda:TrckLocation?
  private var date = Date()
  init(_ fakeData:Bool) {
    super.init()
    if fakeData {
      locationLambda = { [unowned self] time in
        let date1 = self.date.addingTimeInterval(Double(time))
        for (date2, lat, lon) in self.fakeTrack where date2 >= date1 {
          self.current = CLLocation(latitude: lat, longitude: lon)
          return self.current
        }
        return self.current
      }
    } else {
      locationLambda = { [unowned self] _ in
        return self.current
      }
    }
  }

  private static var instance:TrckLocationManager?

  public class func sharedInstance(_ fakeData:Bool = false) -> TrckLocationManager {
    if let instance = instance {
      return instance
    } else {
      instance = TrckLocationManager(fakeData)
      return instance!
    }
  }

  private var current:CLLocation?

  public func currentLocation(_ time:Int) -> CLLocation? {
    return locationLambda!(time)
  }

  private var fakeTrack = [(Date, Double, Double)]()

  public func load(_ data:NSString) {
    let gpx = SWXMLHash.parse(data as String)["gpx"]

    let xml = gpx["trk"]["trkseg"]

    _ = xml.all.map { [unowned self] trackSegment in
      trackSegment["trkpt"].all.map { [unowned self] trackPoint in
        let element = trackPoint.element!
        let lat = Double(element.attribute(by: "lat")!.text)!
        let lon = Double(element.attribute(by: "lon")!.text)!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = formatter.date(from: trackPoint["time"].element!.text)!
        self.fakeTrack.append((date, lat, lon))
      }
    }
    date = fakeTrack[0].0
  }

}

extension TrckLocationManager:CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

  }
}
