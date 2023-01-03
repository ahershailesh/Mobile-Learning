//
//  FileManager.swift
//  Mobile-Learning
//
//  Created by Shailesh Aher on 02/01/23.
//

import Foundation

protocol FileHandlerRepresentable {
    func move(fromLoc: String, fileName: String) throws
    func isFileExist(fileName: String) -> Bool
}

class FileHandler: FileHandlerRepresentable {
    enum FileHandlerError: Error {
        case noFileFound
        case destinationNotFound
    }
    
    private let fileManager: FileManager
    private lazy var documentsPath: URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }()
    
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
    func move(fromLoc: String, fileName: String) throws {
        guard let originPath = URL(string: fromLoc) else {
            return
        }
        let path = localFilePath(for: fileName)
        try? fileManager.removeItem(at: path)
        try fileManager.copyItem(at: originPath, to: path)
        print("File moved from \(originPath) to \(path)")
    }
    
    func isFileExist(fileName: String) -> Bool {
        let path = NSURLComponents(url: documentsPath, resolvingAgainstBaseURL: true)
        path?.scheme = nil
        return fileManager.fileExists(atPath: path?.url?.appending(path: "\(fileName).mp3").absoluteString ?? "")
    }
}

extension FileHandler {
    func localFilePath(for fileName: String) -> URL {
      return documentsPath.appendingPathComponent(fileName + ".mp3")
    }
}
