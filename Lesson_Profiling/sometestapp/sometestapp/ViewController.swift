//
//  ViewController.swift
//  sometestapp
//
//  Created by Yuriy on 29.03.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var retryButton: UIButton!
    
    private var orgs: [GithubOrganization] = []
    private let data: DataProvider = OrganizationDataProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(OrganizationCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
    }
    
    @IBAction func retry(_ sender: Any) {
        fetchData()
    }
    
    @IBAction func didTapClear(_ sender: Any) {
        data.clear()
    }
    
    private func fetchData() {
        data.fetchData { [weak self] newOrgs in
            self?.orgs = newOrgs
            self?.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? OrganizationCell
        else {
            fatalError()
        }
        
        cell.titleLabel.text = orgs[indexPath.row].login
        
        if let data = orgs[indexPath.row].avatar {
            cell.logoView.image = UIImage(data: data)
        }
        
        return cell
    }
}


extension Pinning: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard
            let trust = challenge.protectionSpace.serverTrust,
            SecTrustGetCertificateCount(trust) > 0
        else {
            // не валидный сертификат
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        // получаем сертификат из цепочки
//        if let certificate = SecTrustGetCertificateAtIndex(trust, 0) {
//            
//            let data = SecCertificateCopyData(certificate) as Data
//            
//            // если сертификаты одинаковые
//            if certificates.contains(data) {
//                // все хорошо, сертификат валидный
//                completionHandler(.useCredential, URLCredential(trust: trust))
//                return
//            }
//        }
        
        // не валидный сертификат
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}
