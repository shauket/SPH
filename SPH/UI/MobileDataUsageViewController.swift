//
//  MobileDataUsageViewController.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import UIKit

class MobileDataUsageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var isLoading: Bool = true
    private var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    private lazy var moibileDataUsageViewModel: MobileDataUsageViewModel = {
      let moibileDataUsageViewModel = MobileDataUsageViewModel()
      return moibileDataUsageViewModel
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.isHidden = true
        self.requestForData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func requestForData() {
        startActivityIndicator()
        self.moibileDataUsageViewModel.getMobileUsageData { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.stopActivityIndicator()
                    self.tableView.reloadData()
                }
                self.isLoading = false
            } else {
                // show error description
                self.showAlert(error!.localizedDescription)
            }
        }
    }
}

extension MobileDataUsageViewController: UITableViewDelegate {
    // Mark: TableView Deletgate methods
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.moibileDataUsageViewModel.getHeaderTitle(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = UIColor.white
            header.textLabel!.font = UIFont.systemFont(ofSize: 16.0)
            header.backgroundView?.backgroundColor = UIColor.black
        }
    }
}

extension MobileDataUsageViewController: UITableViewDataSource {
    // Mark: TabelView DataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.moibileDataUsageViewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moibileDataUsageViewModel.getNumberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MobileDataUsageCellView
        cell.delegate = self
        let data = self.moibileDataUsageViewModel.getRecordForRow(indexPath: indexPath)
        if let record = data.0 {
            cell.configure(record: record, canShow: data.1)
        }
        
        return cell
    }
}
extension MobileDataUsageViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        print("scrollViewWillBeginDragging")
        isLoading = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
        {
            if !isLoading && self.moibileDataUsageViewModel.canSendRequest() {
                isLoading = true
                self.requestForData()
            }
        }
        
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

extension MobileDataUsageViewController {
    func startActivityIndicator() {
        activityIndicator.isHidden = false
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivityIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
