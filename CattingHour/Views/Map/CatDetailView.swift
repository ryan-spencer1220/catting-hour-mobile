import SwiftUI

struct CatDetailView: View {
    let cat: CatSighting

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(cat.name ?? "Unnamed Cat")
                .font(.largeTitle)
            Text(cat.notes)
            Text("Seen on \(cat.dateSeen.formatted(date: .abbreviated, time: .omitted))")
            Text("Lat: \(cat.latitude), Lon: \(cat.longitude)")
            Spacer()
        }
        .padding()
    }
}
