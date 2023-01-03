//
//  MenuView.swift
//  Mobile-Learning
//
//  Created by Shailesh Aher on 27/12/22.
//

import SwiftUI

struct MenuItem {
    let chapter: String
    let topics: [Topic]
}

struct Topic {
    let title: String
    let view: AnyView
}

let menuList = [
    MenuItem(chapter: "Swift UI + Combine", topics: [
        Topic(title: "Buiding List and Navigation", view: AnyView(LandmarkList())),
        Topic(title: "Half Tunes", view: AnyView(TrackList()))
    ])
]

struct MenuView: View {
    var body: some View {
        NavigationView {
            List(menuList, id: \.chapter) { item in
                Section(item.chapter, content: {
                        ForEach(item.topics, id: \.title) { topic in
                            NavigationLink {
                                topic.view
                            } label: {
                                Text(topic.title)
                            }
                        }
                })
            }
            .navigationTitle("Learning Plan")
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
