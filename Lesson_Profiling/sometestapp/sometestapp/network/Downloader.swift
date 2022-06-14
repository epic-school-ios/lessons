//
//  Downloader.swift
//  sometestapp
//
//  Created by Yuriy on 29.03.2022.
//

import Foundation
import UIKit

class Downloader: NSObject, DataProtocol {
    func fetchData() {
        let foregroundTask = URLSession.shared.downloadTask(with: URL(string: "https://sabnzbd.org/tests/internetspeed/20MB.bin")!)
        
        let backgroundSession = URLSession(
            configuration: URLSessionConfiguration.background(withIdentifier: "some"),
            delegate: self,
            delegateQueue: nil)
        
        let backgroundId = UIApplication.shared.beginBackgroundTask {
            foregroundTask.cancel { data in
                let task: URLSessionDownloadTask
                
                if let data = data {
                    task = backgroundSession.downloadTask(withResumeData: data)
                } else {
                    task = backgroundSession.downloadTask(with: URL(string: "https://sabnzbd.org/tests/internetspeed/20MB.bin")!)
                }
                task.resume()
            }
        }
        
        foregroundTask.resume()
        
        
        
//        var config = URLSessionConfiguration.background(withIdentifier: "someBackgroundSession")
//        config.sessionSendsLaunchEvents = true
//
//
//        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
//
//        print("Downloading")
//
//        let task = session.downloadTask(with: URL(string: "https://sabnzbd.org/tests/internetspeed/20MB.bin")!)
//        task.resume()
    }
}

extension Downloader: URLSessionDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("File downloaded at: \(location)")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("Error downloading: \(error)")
            return
        }
    }
}


//https://habr.com/ru/company/redmadrobot/blog/478566/
