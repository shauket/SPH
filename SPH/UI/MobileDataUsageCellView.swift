//
//  MobileDataUsageCellView.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 17/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import UIKit
@objc protocol AlertDelegate {
    func showAlert(message: String)
}
class MobileDataUsageCellView: UITableViewCell {
    @IBOutlet weak var quarterLabel: UILabel!
    @IBOutlet weak var usageDataLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    weak var delegate: AlertDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(record: Record, canShow: Bool) {
        quarterLabel.text?.append(record.quarterStr)
        usageDataLabel.text?.append(record.volumeOfMobileData)
        self.infoButton.isHidden = !canShow
    }
    
    @IBAction func showDataReduction() {
        
        let message = "Lowest of mobile data usage in " + self.quarterLabel.text!
        delegate?.showAlert(message: message)
    }

}
