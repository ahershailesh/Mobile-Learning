//
//  TunesList.swift
//  Mobile-Learning
//
//  Created by Shailesh Aher on 28/12/22.
//

import SwiftUI

struct TrackList: View {
    @State var list: [String] = ["ABC"]
    @ObservedObject var viewModel = TrackListViewModel(fileHandler: .init())
    
    private var textFieldBorder: some View {
        RoundedRectangle(cornerRadius: 4)
            .stroke(lineWidth: 1.0)
            .foregroundColor(.gray)
            .padding(.horizontal)
    }
    
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Song name or artist", text: $viewModel.query)
                    .onSubmit {
                        viewModel.getResults()
                    }
            }
            .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 16))
            .overlay(textFieldBorder)
            Spacer()
            List(viewModel.tracks) {
                TrackRow(viewModel: $0)
            }.listStyle(.plain)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TunesList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TrackList()
            .navigationTitle("Track list")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
