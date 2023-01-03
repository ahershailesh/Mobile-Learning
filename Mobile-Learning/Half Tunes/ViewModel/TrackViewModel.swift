//
//  TuneViewModel.swift
//  Mobile-Learning
//
//  Created by Shailesh Aher on 02/01/23.
//

import Combine
import Foundation

protocol TrackViewModelRepresentable: AnyObject, Identifiable, Downloadable, ObservableObject {
    var title: String { get }
    var subTitle: String { get }
    var ctaButton: String { get }
    var id: Int { get }
    func downloadTapped()
    func updateCTA()
}

protocol Downloadable {
    var downloadURL: String { get }
    var fileName: String { get }
}

class TrackViewModel: TrackViewModelRepresentable {
    private let track: Track
    private let fileHandler: FileHandlerRepresentable
    let onDownloadTapped = PassthroughSubject<any TrackViewModelRepresentable,Error>()
    var title: String { track.collectionName }
    var subTitle: String { track.artistName }
    var downloadURL: String { track.previewURL }
    var id: Int { track.trackID }
    var fileName: String { track.trackID.description }
    @Published var ctaButton: String = ""
    
    init(track: Track, fileHandler: FileHandlerRepresentable) {
        self.track = track
        self.fileHandler = fileHandler
        self.updateCTA()
    }
    
    func downloadTapped() {
        if !fileHandler.isFileExist(fileName: fileName) {
            onDownloadTapped.send(self)
        }
    }
    
    func updateCTA() {
        ctaButton = fileHandler.isFileExist(fileName: fileName) ? "Open" : "Download"
    }
}
