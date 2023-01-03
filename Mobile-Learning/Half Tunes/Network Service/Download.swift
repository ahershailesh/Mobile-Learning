//
//  Download.swift
//  Mobile-Learning
//
//  Created by Shailesh Aher on 28/12/22.
//

import Combine
import Foundation

class Download: NSObject {
    let onComplete: PassthroughSubject<(URL), Error> = .init()
    private var isDownloading = false
    private var progress: Float = 0
    private var resumeData: Data?
    private var task: URLSessionDownloadTask?
    private var downloadURL: String
    private lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    
    init(downloadURL: String) {
        self.downloadURL = downloadURL
    }
    
    func resume() {
        guard let url = URL(string: downloadURL) else { return }
        task?.cancel()
        task = session.downloadTask(with: .init(url: url))
        task?.resume()
    }
}

extension Download: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        onComplete.send(location)
        print("Finished downloading to \(location).")
    }
}
