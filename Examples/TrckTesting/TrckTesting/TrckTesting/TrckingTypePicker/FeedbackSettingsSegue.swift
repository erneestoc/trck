//
//  FeedbackSettingsSegue.swift
//  TrckTesting
//
//  Created by Ernesto Cambuston on 2/9/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import UIKit

class FeedbackSettingsSegue:UIStoryboardSegue {
  override func perform() {
    guard let source = source as? TrckTypePickerViewController,
          let destination = destination as? UINavigationController else {return}
    if let controller = destination.viewControllers.first as? FeedbackSettingsViewController {
      controller.updatePreviousController = source.setupFeedbackButton
    }
    source.present(destination, animated: true, completion: nil)
  }
}
