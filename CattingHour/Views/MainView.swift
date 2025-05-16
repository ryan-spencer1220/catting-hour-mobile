//
//  MainView.swift
//  CattingHour
//
//  Created by Ryan Spencer on 5/15/25.
//


import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MapViewContainer()
                .tabItem {
                    Label("Map", systemImage: "map")
                }

            AddCatView()
                .tabItem {
                    Label("Add Cat", systemImage: "plus.circle")
                }

            RecentCatsView()
                .tabItem {
                    Label("Recent", systemImage: "clock")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}
