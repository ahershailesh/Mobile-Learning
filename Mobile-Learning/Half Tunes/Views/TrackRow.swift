//
//  TrackRow.swift
//  Mobile-Learning
//
//  Created by Shailesh Aher on 28/12/22.
//

import SwiftUI

struct TrackRow<Model>: View where Model: TrackViewModelRepresentable {
    @ObservedObject var viewModel: Model
    
    init(viewModel: Model) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.title2)
                    .foregroundColor(.primary)
                Text(viewModel.subTitle)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button() {
                viewModel.downloadTapped()
            } label: {
                Text(viewModel.ctaButton)
            }
        }
        .padding()
    }
}

struct TrackRow_Previews: PreviewProvider {
    static var previews: some View {
        TrackRow(viewModel: TrackViewModel(
            track: Track(
                wrapperType: .collection,
                kind: .song,
                artistID: 1,
                collectionID: 1,
                trackID: 1,
                artistName: "Drake & Future",
                collectionName: "What a Time To Be Alive",
                trackName: "Jumpman",
                collectionCensoredName: "What a Time To Be Alive",
                trackCensoredName: "Jumpman",
                artistViewURL: "https://music.apple.com/us/artist/drake/271256?uo=4",
                collectionViewURL: "https://music.apple.com/us/album/jumpman/1440842320?i=1440843184&uo=4",
                trackViewURL: "https://music.apple.com/us/album/jumpman/1440842320?i=1440843184&uo=4",
                previewURL: "https://music.apple.com/us/album/jumpman/1440842320?i=1440843184&uo=4",
                artworkUrl30: "https://music.apple.com/us/album/jumpman/1440842320?i=1440843184&uo=4",
                artworkUrl60: "https://music.apple.com/us/album/jumpman/1440842320?i=1440843184&uo=4",
                artworkUrl100: "https://music.apple.com/us/album/jumpman/1440842320?i=1440843184&uo=4",
                collectionPrice: 9.99,
                trackPrice: 9.99,
                collectionExplicitness: .explicit,
                trackExplicitness: .explicit,
                discCount: 1,
                discNumber: 1,
                trackCount: 1,
                trackNumber: 1,
                trackTimeMillis: 1,
                country: .usa,
                currency: .usd,
                primaryGenreName: "",
                isStreamable: true,
                collectionArtistName: nil,
                collectionArtistID: nil,
                contentAdvisoryRating: nil,
                collectionArtistViewURL: nil),
            fileHandler: FileHandler()))
    }
}
