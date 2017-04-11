//
//  RoutingSearchVC.swift
//  ios-sdk
//
//  Created by Matt Smollinger on 10/4/16.
//  Copyright © 2016 Mapzen. All rights reserved.
//
import UIKit

class DemoSearchListViewController: SampleAutocompleteTableViewController {

  var delegate : AutocompleteSearchDelegate?

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    super.tableView(tableView, didSelectRowAt: indexPath)
    if let delegate = delegate {
      delegate.selected((self.results?[indexPath.row])!)
      let _ = self.navigationController?.popViewController(animated: true)
    }
  }

}
