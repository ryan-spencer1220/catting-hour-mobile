import SwiftUI

struct MainView: View {
    @Binding var selectedCat: CatSighting?
    
    var body: some View {
        TabView {
            MapViewContainer(selectedCat: $selectedCat)
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
