//
//  TrckingSegue.swift
//  TrckTesting
//
//  Created by Ernesto Cambuston on 2/7/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import UIKit

class TrckingSetupSegue:UIStoryboardSegue {
  override func perform() {
    guard let source = source as? TrckTypePickerViewController,
          let destination = destination as? TrckingViewController else {return}
    
    let defaults = UserDefaults.standard
    let _ = defaults.integer(forKey: "feedbackType")
    let _ = defaults.integer(forKey: "feedbackValue")
    
    source.present(destination, animated: true, completion: nil)
  }
}
