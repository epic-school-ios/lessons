//
//  IBAutolayoutViewController.swift
//  Lesson 1
//
//  Created by Denis Zhukoborskiy on 15.03.2022.
//

import UIKit

class IBAutolayoutViewController: UIViewController {
    
    @IBOutlet var topLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.textColor = .red
    }
}
