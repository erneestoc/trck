//
//  TrckPickerDataDistance.swift
//  TrckTesting
//
//  Created by Ernesto Cambuston on 2/8/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import UIKit

class TrckPickerDataDistance: TrckPickerData {
  private var distances = [(String, Int)]()
  override func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    reloadData()
    return distances.count
  }

  func pickerView(_ pickerView: UIPickerView,
                  titleForRow rowNumber: Int,
                  forComponent component: Int) -> String? {
    return distances[rowNumber].0
  }

  func pickerView(_ pickerView: UIPickerView,
                  didSelectRow rowNumber: Int,
                  inComponent component: Int) {
    UserDefaults.standard.set(distances[rowNumber].1, forKey: "distanceGoal")
  }

  private func reloadData() {
    distances = [(String, Int)]()
    let unitSystem = UserDefaults.standard.bool(forKey: "unitSystem") ? "km" : "mile"
    for i in 1...100 {
      distances.append(("\(i) \(unitSystem)", i * 2))
    }
  }
}
