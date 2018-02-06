//
//  ViewController.swift
//  VoiceFeedbackTesting
//
//  Created by Ernesto Cambuston on 2/6/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  private let speaker = TrckSpeaker()
  private var currentLocale = Locale.current.identifier
  private var currentSpeaker:TrckFeedbackProtocol?
  @IBOutlet weak var speakButton: UIButton!
  @IBOutlet weak var distanceTextField: UITextField!
  @IBOutlet weak var timeTextField: UITextField!
  @IBOutlet weak var languagePickerView: UIPickerView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    languagePickerView.dataSource = self
    languagePickerView.delegate = self
    distanceTextField.delegate = self
    timeTextField.delegate = self
    distanceTextField.tag = 0
    timeTextField.tag = 1
    setLanguage(currentLocale)
  }
  
  private func setLanguage(_ code:String) {
    let setup = TrckSetup(unitSystem: .metric, voiceFeedback: .regular, halfsUnits: 2)
    currentSpeaker = TrckEnglishFeedback(setup: setup)
  }
  
  @IBAction func speak(_ sender: Any) {
    print("[Speech] - Checking text exists")
    guard let distanceText = distanceTextField.text,
      let timeText = timeTextField.text else {return}
    print("[Speech] - Parsing Text distance:\(distanceText) \n\t\t\ttime: \(timeText)")
    if let distance = Double(distanceText),
      let time = Int(timeText) {
      if let speech = currentSpeaker?.feedbackFor(distance: distance,
                                                  time: time,
                                                  pace: Double(time) / distance) {
        saySpeech(speech)
      }
    }
  }
  
  private func saySpeech(_ speech:String) {
    print("[Speech] - \(speech)")
    speaker.speak(string: speech, language: currentLocale)
  }
  
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.tag == 0 {
      if let field = view.viewWithTag(1) as? UITextField {
        field.becomeFirstResponder()
      }
    } else if textField.tag == 1 {
      textField.resignFirstResponder()
    }
    return false
  }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return Locale.availableIdentifiers.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return Locale.availableIdentifiers[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    currentLocale = Locale.availableIdentifiers[row]
  }
}
