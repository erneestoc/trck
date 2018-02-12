//
//  TrckPickerDataTime.swift
//  TrckTesting
//
//  Created by Ernesto Cambuston on 2/8/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import UIKit

class TrckPickerDataTime: TrckPickerData {
  private var time = [(String, Int)]()
  override func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    reloadData()
    return time.count
  }
  
  func pickerView(_ pickerView: UIPickerView,
                  titleForRow rowNumber: Int,
                  forComponent component: Int) -> String? {
    return time[rowNumber].0
  }
  
  func pickerView(_ pickerView: UIPickerView,
                  didSelectRow rowNumber: Int,
                  inComponent component: Int) {
    UserDefaults.standard.set(time[rowNumber].1, forKey: "timeGoal")
  }

  private func reloadData() {
    time = [(String, Int)]()
    for i in 1...100 {
      if i % 2 == 0 {
        time.append(("\(Int(i / 2)):00 mins", i))
      }
    }
  }
}
