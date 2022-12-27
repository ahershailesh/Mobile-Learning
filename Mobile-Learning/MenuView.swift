//
//  MenuView.swift
//  Mobile-Learning
//
//  Created by Shailesh Aher on 27/12/22.
//

import SwiftUI

struct MenuItem {
    let chapter: String
    let topics: [String]
}

let menuList = [
    MenuItem(chapter: "Swift UI + Combine", topics: ["Buiding List and Navigation"])
]

struct MenuView: View {
    var body: some View {
        NavigationView {
            List(menuList, id: \.chapter) { item in
                Section(item.chapter, content: {
                    VStack {
                        ForEach(item.topics, id: \.self) { item in
                            NavigationLink {
                                Text("Thank you")
                            } label: {
                                Text(item)
                            }
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
