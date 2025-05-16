import SwiftUI
import MapboxMaps

struct ContentView: View {
    @State private var mapView: MapView?

    var body: some View {
        MainView()
    }
}

struct MapViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> MapView {
        let accessToken = Bundle.main.object(forInfoDictionaryKey: "MBXAccessToken") as? String ?? ""

        // ✅ Use built-in light style
        let options = MapInitOptions(
            resourceOptions: ResourceOptions(accessToken: accessToken),
            styleURI: .light
        )

        let mapView = MapView(frame: .zero, mapInitOptions: options)

        let camera = CameraOptions(
            center: CLLocationCoordinate2D(latitude: 45.5122, longitude: -122.6587),
            zoom: 13
        )
        mapView.mapboxMap.setCamera(to: camera)

        return mapView
    }

    func updateUIView(_ uiView: MapView, context: Context) {}
}
