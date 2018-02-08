//
//  ViewController.swift
//  TrckTesting
//
//  Created by Ernesto Cambuston on 2/7/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import UIKit

class TrckTypePickerViewController: UIViewController {

  @IBOutlet weak var pickerView: UIPickerView!
  @IBOutlet weak var voiceFeedbackButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func changedTab(_ sender: UISegmentedControl) {
  }
  
}

