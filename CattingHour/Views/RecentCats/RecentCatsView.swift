import SwiftUI

struct RecentCatsView: View {
    @State private var cats: [CatSighting] = []
    @State private var selectedCat: CatSighting?
    @State private var isLoading = true

    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView("Loading cats...")
                } else if cats.isEmpty {
                    Text("No cats logged yet.")
                        .foregroundColor(.gray)
                } else {
                    List(cats) { cat in
                        Button {
                            selectedCat = cat
                        } label: {
                            CatCard(cat: cat)
                        }
                    }
                }
            }
            .navigationTitle("Recent Cats")
        }
        .sheet(item: $selectedCat) { cat in
            CatDetailView(cat: cat)
        }
        .task {
            await loadCats()
        }
    }

    func loadCats() async {
        do {
            cats = try await SupabaseService.shared.fetchAllCatSightings()
            isLoading = false
        } catch {
            print("❌ Failed to fetch cats:", error)
            isLoading = false
        }
    }
}
