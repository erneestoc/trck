//
//  FeedbackSettingsViewController.swift
//  TrckTesting
//
//  Created by Ernesto Cambuston on 2/7/18.
//  Copyright © 2018 Ernesto Cambuston. All rights reserved.
//

import UIKit

class FeedbackSettingsViewController:UITableViewController {
  
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
    case 1: setupDistanceCell(cell, row: indexPath.row)
    case 2: setupTimeCell(cell, row: indexPath.row)
    default: setupUnitSystemCell(cell)
    }
    return cell
  }
  
  private func setupNoneCell(_ cell:UITableViewCell) {
    if feedbackType == 0 {
      cell.textLabel?.textColor = UIColor.green
    }
  }
  
  private func setupDistanceCell(_ cell:UITableViewCell, row: Int) {
    let distanceTuple = distance[row]
    let unitSystemString = unitSystem ? "km" : "mile"
    cell.textLabel?.text = "\(distanceTuple.0) \(unitSystemString)"
    if feedbackType == 1 && feedbackValue == row {
      cell.textLabel?.textColor = UIColor.green
    }
  }
  
  private func setupTimeCell(_ cell:UITableViewCell, row: Int) {
    let timeTuple = time[row]
    cell.textLabel?.text = timeTuple.0
    if feedbackType == 2 && feedbackValue == row {
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
    } else {
      UserDefaults.standard.set(indexPath.section, forKey: "feedbackType")
      UserDefaults.standard.set(indexPath.row, forKey: "feedbackValue")
    }
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 20
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return nil
  }
}
