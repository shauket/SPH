//
//  MobileDataUsageViewController.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import UIKit

class MobileDataUsageViewController: UIViewController {
  
    private lazy var moibileDataUsageViewModel: MobileDataUsageViewModel = {
      let moibileDataUsageViewModel = MobileDataUsageViewModel()
      return moibileDataUsageViewModel
    } ()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.moibileDataUsageViewModel.getMobileUsageData { error in
        if error == nil {
          
        } else {
          // show error description
        }
      }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
