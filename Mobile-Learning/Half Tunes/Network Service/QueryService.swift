//
//  QueryService.swift
//  Mobile-Learning
//
//  Created by Shailesh Aher on 28/12/22.
//

import Combine
import Foundation

class QueryService {
    
    func getSearchResults(query: String) -> AnyPublisher<TrackResponse, Error> {
        let session = URLSession(configuration: .default)
        guard var urlComponents = URLComponents(string: "https://itunes.apple.com/search") else { return Fail(error: NSError(domain: "", code: 500)).eraseToAnyPublisher() }
        urlComponents.query = "media=music&entity=song&term=\(query)"
        
        guard let url = urlComponents.url else { return Fail(error: NSError(domain: "", code: 500)).eraseToAnyPublisher() }
        print("Request - \(url)")
         return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                let response = try JSONDecoder().decode(TrackResponse.self, from: data)
                return response
            }
            .eraseToAnyPublisher()
    }
    
}
