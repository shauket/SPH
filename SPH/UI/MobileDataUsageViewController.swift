//
//  MobileDataUsageViewController.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import UIKit

class MobileDataUsageViewController: UITableViewController {
    
    private lazy var moibileDataUsageViewModel: MobileDataUsageViewModel = {
      let moibileDataUsageViewModel = MobileDataUsageViewModel()
      return moibileDataUsageViewModel
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableview delegate
        self.moibileDataUsageViewModel.getMobileUsageData { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                // show error description
                self.showAlert(error!.localizedDescription)
            }
        }
    }
    
    // Mark: TableView Deletgate methods
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.moibileDataUsageViewModel.getHeaderTitle(section: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }

    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel!.font = UIFont.systemFont(ofSize: 16.0)
            header.backgroundView?.backgroundColor = UIColor.black
        }
    }

    // Mark: TabelView DataSource methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.moibileDataUsageViewModel.getNumberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moibileDataUsageViewModel.getNumberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MobileDataUsageCellView
        cell.delegate = self
        let data = self.moibileDataUsageViewModel.getRecordForRow(indexPath: indexPath)
        if let record = data.0 {
            cell.configure(record: record, canShow: data.1)
        }
        
        return cell
    }
}

extension MobileDataUsageViewController: AlertDelegate {
    func showAlert(message: String) {
        self.showAlert(message)
    }
}
extension MobileDataUsageViewController {
    func showAlert(_ message: String) {
        let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            
            }))
        self.present(alert, animated: true, completion: nil)    }
}
