import SwiftUI

struct ContentView: View {
    @StateObject private var auth = AuthViewModel()
    @State private var selectedCat: CatSighting?

    var body: some View {
        Group {
            if let _ = auth.user {
                MainView(selectedCat: $selectedCat)
                    .sheet(item: $selectedCat) { cat in
                        CatDetailView(cat: cat)
                    }
            } else {
                LoginView()
            }
        }
        .environmentObject(auth)
    }
}
