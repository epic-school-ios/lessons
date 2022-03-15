//
//  ViewController.swift
//  Lesson 1
//
//  Created by Denis Zhukoborskiy on 12.03.2022.
//

import UIKit

class FirstViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func simpleMVCButtonDidTap(_ sender: UIButton) {
        let vc = SimpleMvcViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func autoLayoutIbButtonDidTap(_ sender: UIButton) {
        
    }
    
    @IBAction func autoLayoutCodeButtonDidTap(_ sender: UIButton) {
        
    }
    
    @IBAction func framesButtonDidTap(_ sender: UIButton) {
        
    }
}

