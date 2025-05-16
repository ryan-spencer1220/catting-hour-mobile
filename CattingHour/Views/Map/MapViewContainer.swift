struct MapViewContainer: UIViewRepresentable {
    @Binding var selectedCat: CatSighting?
    
    class Coordinator: NSObject, AnnotationInteractionDelegate {
        var parent: MapViewContainer
        var annotations: [String: CatSighting] = [:]

        init(_ parent: MapViewContainer) {
            self.parent = parent
        }

        func mapView(_ mapView: MapView, didDetectTappedAnnotation annotation: Annotation) {
            if let id = annotation.id, let cat = annotations[id] {
                parent.selectedCat = cat
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MapView {
        let accessToken = Bundle.main.object(forInfoDictionaryKey: "MBXAccessToken") as? String ?? ""

        let options = MapInitOptions(
            resourceOptions: ResourceOptions(accessToken: accessToken),
            styleURI: .light
        )

        let mapView = MapView(frame: .zero, mapInitOptions: options)
        context.coordinator.mapView = mapView

        let center = CLLocationCoordinate2D(latitude: 45.5122, longitude: -122.6587)
        let camera = CameraOptions(center: center, zoom: 13)
        mapView.mapboxMap.setCamera(to: camera)
        mapView.gestures.delegate = context.coordinator

        Task {
            await loadMarkers(mapView)
        }

        return mapView
    }

    func updateUIView(_ uiView: MapView, context: Context) {}

    func loadMarkers(_ mapView: MapView, context: Context) async {
        do {
            let cats = try await SupabaseService.shared.fetchAllCatSightings()

            var annotations: [PointAnnotation] = []
            var catMap: [String: CatSighting] = [:]

            for cat in cats {
                var annotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: cat.latitude, longitude: cat.longitude))
                let id = UUID().uuidString
                annotation.id = id
                annotation.image = .init(image: UIImage(systemName: "pawprint.fill")!, name: "cat-marker")
                annotations.append(annotation)
                catMap[id] = cat
            }

            context.coordinator.annotations = catMap
            let manager = mapView.annotations.makePointAnnotationManager()
            manager.delegate = context.coordinator
            manager.annotations = annotations
        } catch {
            print("❌ Failed to load cat markers:", error)
        }
    }
}
