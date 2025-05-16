import SwiftUI
import CoreLocation

let catTypes = ["Tuxedo", "Orange", "Siamese", "Calico", "Tabby", "Black", "White", "Gray", "Other"]

struct AddCatView: View {
    @State private var catName: String = ""
    @State private var notes: String = ""
    @State private var dateSeen: Date = Date()
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var selectedCatType = "Tuxedo"
    @StateObject private var locationManager = LocationManager()


    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Date Seen")) {
                    DatePicker("Date", selection: $dateSeen, displayedComponents: [.date])
                }
                
                Section(header: Text("Location")) {
                    if let location = locationManager.location {
                        Text("Lat: \(location.latitude), Lon: \(location.longitude)")
                            .font(.caption)
                    } else {
                        Text("Getting location...")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Section(header: Text("Cat Details")) {
                    TextField("Name (optional)", text: $catName)
                    Picker("Type", selection: $selectedCatType) {
                        ForEach(catTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Notes", text: $notes)
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
        guard let location = locationManager.location else {
            print("⚠️ No location — please wait")
            return
        }

        let sighting = CatSighting(
            name: catName.isEmpty ? nil : catName,
            type: selectedCatType,
            notes: notes,
            dateSeen: dateSeen,
            latitude: location.latitude,
            longitude: location.longitude,
            imageUrl: nil
        )

        Task {
            do {
                let client = SupabaseService.shared.client

                let response = try await client
                    .from("cat_sightings")
                    .insert(sighting)
                    .execute()

                print("✅ Cat sighting saved: \(response)")
            } catch {
                print("❌ Failed to save cat sighting:", error)
            }
        }
    }
}
