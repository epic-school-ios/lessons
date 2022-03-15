//
//  SimpleMvcViewController.swift
//  Lesson 1
//
//  Created by Denis Zhukoborskiy on 12.03.2022.
//

import UIKit

class SimpleMvcViewController: UIViewController {
    
    @IBOutlet private var colorChangingLabel: UILabel!
    
    private var labelColor: UIColor? {
        didSet {
            colorChangingLabel.textColor = labelColor
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Simple MVC"
    }
    
    
    @IBAction private func redButtonDidTap(_ sender: UIButton) {
        labelColor = .red
    }
    
    @IBAction private func greenButtonDidTap(_ sender: UIButton) {
        labelColor = .green
    }
    
    @IBAction private func yellowButtonDidTap(_ sender: UIButton) {
        labelColor = .yellow
    }
}
