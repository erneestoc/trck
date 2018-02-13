//
//  TrckingSegue.swift
//  TrckTesting
//
//  Created by Ernesto Cambuston on 2/7/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import UIKit
import Trck

class TrckingSetupSegue:UIStoryboardSegue {
  override func perform() {
    guard let source = source as? TrckTypePickerViewController,
          let destination = destination as? TrckingViewController else {return}

    let defaults = UserDefaults.standard
    let unitSystem:TrckUnitSystem = defaults.bool(forKey: "unitSystem") ? .metric : .royal
    let feedbackType = defaults.integer(forKey: "feedbackType")
    let feedbackValue = defaults.integer(forKey: "feedbackValue")

    let setup = TrckSetup(unitSystem: unitSystem,
                          voiceFeedback: .regular,
                          halfsUnits: 0,
                          distance: 0.0,
                          time: 0)
    destination.trck = Trck(setup: setup)
    source.present(destination, animated: true, completion: nil)
  }
}
