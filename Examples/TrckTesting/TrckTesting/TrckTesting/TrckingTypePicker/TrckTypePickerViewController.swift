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
  private let pickerViewDataSources = [TrckPickerDataDistance(),
                                       TrckPickerDataTime(),
                                       TrckPickerDataPace()]

  private var unitSystem:Bool {
    return UserDefaults.standard.bool(forKey: "unitSystem")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    let page = UserDefaults.standard.integer(forKey: "trckType")
    selectedTab(page)
    setupFeedbackButton()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func setupFeedbackButton() {
    let title = UserDefaults.standard.string(forKey: "feedbackString") ?? "no feedback"
    voiceFeedbackButton.setTitle(title, for: .normal)
  }

  @IBAction func changedTab(_ sender: UISegmentedControl) {
    let index = sender.selectedSegmentIndex
    UserDefaults.standard.set(index, forKey: "trckType")
    selectedTab(index)
  }
  private func selectedTab(_ index:Int) {
    switch index {
    case 0:
      pickerView.isHidden = true
    default:
      pickerView.isHidden = false
      let data = pickerViewDataSources[index - 1]
      pickerView.dataSource = data
      pickerView.delegate = data
      pickerView.reloadAllComponents()
    }
  }
  @IBAction func clickedVoiceFeedbackSettings(_ sender: Any) {
    performSegue(withIdentifier: "kFeedbackSettingsSegue", sender: self)
  }
}
