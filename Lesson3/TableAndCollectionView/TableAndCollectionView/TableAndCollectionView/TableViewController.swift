//
//  ViewController.swift
//  TableAndCollectionView
//
//  Created by Denis on 22.03.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    let images = (1...13).map{ UIImage(named: String($0))! }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.allowsSelection = false
        tableView.separatorColor = .clear
        
        let nib = UINib(nibName: ImageTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
    }


}

extension TableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.reuseIdentifier, for: indexPath) as! ImageTableViewCell
        cell.configure(image: images[indexPath.row])
        
        cell.onButtonTap = {
            print("hi")
        }
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as? ImageTableViewCell
//        
//        cell?.isChosen.toggle()
//    }
    
    
}

