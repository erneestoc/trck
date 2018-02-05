public enum TrckUnitSystem {
  case metric
  case royal
}

public typealias TimeTuple = (hours:Int, minutes:Int, seconds:Int)
public typealias DistanceTuple = (firstUnit:Int, secondUnit:Int)
public typealias PaceTuple = (firstUnit:Int, secondUnit:Int)

func convertTimeToTimeTuple(_ time:Int) -> TimeTuple {
  if time < 60 {
    return (0, 0, time)
  } else {
    let seconds = time % 60
    let minutes = Int(Double(time) / 60.0)
    if time < 3600 {
      return (0, minutes, seconds)
    } else {

      let  _mins = minutes % 60
      return (Int(minutes / 60), _mins, seconds)
    }
  }
}

func convertDistanceToDistanceTuple(_ distance:Double, unitSystem:TrckUnitSystem) -> DistanceTuple {
  let conversion = (unitSystem == .metric ? 1000.0 : 1609.0)
  if distance >= conversion {
    let _mainUnit = distance / conversion
    let mainUnit = Int(_mainUnit)
    let enMiles = distance.remainder(dividingBy: conversion)
    let _secondaryUnit = Int(enMiles / (conversion / 100.0))
    return (mainUnit, _secondaryUnit)
  } else {
    return (0, Int(distance / (conversion / 100)))
  }
}

func convertTimeAndDistanceToPaceTuple(_ pace:Double,
                                       unitSystem:TrckUnitSystem) -> PaceTuple {
  let conversion = (unitSystem == .metric ? 1000.0 : 1609.0)
  let averagePaceFloat = pace * (conversion / 60.0)
  let firstUnit = Int(averagePaceFloat)
  let divider = (Double(firstUnit) > 0.0 ? Double(firstUnit) : 1.0)
  let secondDigit = (averagePaceFloat.remainder(dividingBy: divider)) * 60.0
  return (firstUnit, Int(secondDigit))
}
