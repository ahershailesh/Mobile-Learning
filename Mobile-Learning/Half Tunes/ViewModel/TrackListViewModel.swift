//
//  TunesListViewModel.swift
//  Mobile-Learning
//
//  Created by Shailesh Aher on 28/12/22.
//

import Combine
import Foundation

class TrackListViewModel: ObservableObject {
    var query = ""
    @Published private(set) var tracks = [TrackViewModel]()
    private let service = QueryService()
    private var cancellables = Set<AnyCancellable>()
    private var activeDownloads: [URL: Download] = [:]
    private let fileHandler: FileHandler
    
    init(fileHandler: FileHandler) {
        self.fileHandler = fileHandler
    }
    
    func getResults() {
        service.getSearchResults(query: query)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print("Recieved Error while seerching for query - \(error)")
                case .finished:
                    break
                }
            } receiveValue: {
                self.tracks = $0.results.map {
                    let viewModel = TrackViewModel(track: $0, fileHandler: self.fileHandler)
                    viewModel.onDownloadTapped.sink { _ in } receiveValue: { viewModel in
                        self.download(item: viewModel)
                            .sink { [weak self] _ in
                                DispatchQueue.main.async {
                                    viewModel.updateCTA()
                                    self?.tracks = self?.tracks ?? []
                                }
                            }.store(in: &self.cancellables)
                    }.store(in: &self.cancellables)
                    return viewModel
                }
            }
            .store(in: &cancellables)
    }
    
    func download(item: Downloadable) -> AnyPublisher<Void, Never> {
        let download = Download(downloadURL: item.downloadURL)
        download.resume()
        return download.onComplete.map { [weak self] destinationPath in
            do {
                try self?.fileHandler.move(fromLoc: destinationPath.absoluteString, fileName: item.fileName)
            } catch {
                print(error)
            }
        }
        .replaceError(with: Void())
        .eraseToAnyPublisher()
    }
}
