//
//  FeedbackSettingsViewController.swift
//  TrckTesting
//
//  Created by Ernesto Cambuston on 2/7/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import UIKit

class FeedbackSettingsViewController:UITableViewController {

  typealias BlankBlock = () -> Void
  var updatePreviousController:BlankBlock?

  private lazy var feedbackType = UserDefaults.standard.integer(forKey: "feedbackType")
  private lazy var feedbackValue = UserDefaults.standard.integer(forKey: "feedbackValue")

  private lazy var unitSystem = UserDefaults.standard.bool(forKey: "unitSystem")

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }

  private let distance = [("0.5", 1), ("1.0", 2), ("1.5", 3), ("2.0", 4)]
  private let time = [("1:00 min", 2), ("5:00 min", 10)]

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0: return 1
    case 1: return distance.count
    case 2: return time.count
    default: return 1
    }
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    switch indexPath.section {
    case 0: setupNoneCell(cell)
    case 1: setupDistanceCell(cell, rowNumber: indexPath.row)
    case 2: setupTimeCell(cell, rowNumber: indexPath.row)
    default: setupUnitSystemCell(cell)
    }
    return cell
  }

  private func setupNoneCell(_ cell:UITableViewCell) {
    cell.textLabel?.text = "None"
    if feedbackType == 0 {
      cell.textLabel?.textColor = UIColor.green
    }
  }

  private func setupDistanceCell(_ cell:UITableViewCell, rowNumber: Int) {
    let distanceTuple = distance[rowNumber]
    let unitSystemString = unitSystem ? "km" : "mile"
    cell.textLabel?.text = "\(distanceTuple.0) \(unitSystemString)"
    if feedbackType == 1 && feedbackValue == rowNumber {
      cell.textLabel?.textColor = UIColor.green
    }
  }

  private func setupTimeCell(_ cell:UITableViewCell, rowNumber: Int) {
    let timeTuple = time[rowNumber]
    cell.textLabel?.text = timeTuple.0
    if feedbackType == 2 && feedbackValue == rowNumber {
      cell.textLabel?.textColor = UIColor.green
    }
  }

  private func setupUnitSystemCell(_ cell:UITableViewCell) {
    cell.textLabel?.text = unitSystem ? "metric" : "royal"
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 3 {
      unitSystem = !unitSystem
      UserDefaults.standard.set(unitSystem, forKey: "unitSystem")
      tableView.reloadData()
    } else {
      feedbackType = indexPath.section
      feedbackValue = indexPath.row
      UserDefaults.standard.set(feedbackString(indexPath: indexPath), forKey: "feedbackString")
      UserDefaults.standard.set(feedbackType, forKey: "feedbackType")
      UserDefaults.standard.set(feedbackValue, forKey: "feedbackValue")
      updatePreviousController?()
      dismiss(animated: true, completion: nil)
    }
  }

  private func feedbackString(indexPath:IndexPath) -> String {
    switch indexPath.section {
    case 0: return "no feedback"
    case 1:
      let unitSystemString = unitSystem ? "km" : "mile"
      return "\(distance[indexPath.row].0) \(unitSystemString)"
    default: return time[indexPath.row].0
    }
  }

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 20
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return nil
  }
}
