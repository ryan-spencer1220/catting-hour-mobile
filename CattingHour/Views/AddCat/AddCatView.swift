import SwiftUI

struct AddCatView: View {
    @State private var catName: String = ""
    @State private var notes: String = ""
    @State private var dateSeen: Date = Date()
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Cat Details")) {
                    TextField("Name (optional)", text: $catName)
                    TextField("Notes", text: $notes)
                }

                Section(header: Text("Date Seen")) {
                    DatePicker("Date", selection: $dateSeen, displayedComponents: [.date])
                }

                Section(header: Text("Photo")) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }

                    Button("Select Photo") {
                        showingImagePicker = true
                    }
                }

                Section {
                    Button("Submit") {
                        submitCat()
                    }
                    .disabled(notes.isEmpty)
                }
            }
            .navigationTitle("Add Cat")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $selectedImage)
            }
        }
    }

    func submitCat() {
        print("🐱 Submitting cat:")
        print("Name: \(catName)")
        print("Notes: \(notes)")
        print("Date: \(dateSeen)")
        // You can also upload the image and coordinates here
    }
}
