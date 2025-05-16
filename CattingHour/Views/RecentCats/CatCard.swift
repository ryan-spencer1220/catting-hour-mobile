import SwiftUI

struct CatCard: View {
    let cat: CatSighting

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(cat.name ?? "Unnamed Cat")
                .font(.headline)

            Text(cat.type)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text(cat.notes)
                .font(.body)
                .lineLimit(2)

            Text(cat.dateSeen.formatted(date: .abbreviated, time: .omitted))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}
