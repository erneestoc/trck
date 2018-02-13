//
//  TrckPickerDataPace.swift
//  TrckTesting
//
//  Created by Ernesto Cambuston on 2/8/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import UIKit

class TrckPickerDataPace: TrckPickerData {

  private var paces = [(String, Double)]()
  private var distances = [(String, Double)]()
  override func numberOfComponents(in pickerView: UIPickerView) -> Int {
    reloadData()
    return 3
  }

  override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component <= 1 {
      return paces.count
    } else {
      return distances.count
    }
  }

  func pickerView(_ pickerView: UIPickerView,
                  titleForRow rowNumber: Int,
                  forComponent component: Int) -> String? {
    if component <= 1 {
     return paces[rowNumber].0
    } else {
      return distances[rowNumber].0
    }
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow rowNumber: Int, inComponent component: Int) {
    switch component {
    case 0: UserDefaults.standard.set(paces[rowNumber].1, forKey: "paceGoal1")
    case 1: UserDefaults.standard.set(paces[rowNumber].1, forKey: "paceGoal2")
    default: UserDefaults.standard.set(paces[rowNumber].1, forKey: "paceGoalDistance")
    }
  }

  private func reloadData() {
    let unitSystem = UserDefaults.standard.bool(forKey: "unitSystem")
    let multiplier = unitSystem ? 1.0 : 1.609
    for minutes in 4...10 {
      for seconds in 10...50 where seconds % 10 == 0 {
        let totalSeconds = (minutes * 60) + seconds
        let speed = Double(totalSeconds) / (1000.0 * multiplier)
        paces.append(("\(minutes)'\(seconds)\"", speed))
      }
    }
    if unitSystem {
      for d in 1...20 {
        let distance = Double(d) * 250.0
        distances.append(("\(Int(distance)) m", distance))
      }
    } else {
      for d in 1...20 {
        let distance = Double(d) * 109.361
        distances.append(("\(d) yards", distance))
      }
    }

  }
}
