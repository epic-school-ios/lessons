//
//  ViewController.swift
//  sometestapp
//
//  Created by Yuriy on 29.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let data: DataProtocol = Downloader()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTap(_ sender: Any) {
        data.fetchData()
    }
}

