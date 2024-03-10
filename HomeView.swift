import SwiftUI
import MapKit
import SwiftUI // Import necessary modules

struct HomeView: View {
    @ObservedObject private var locationManager = LocationManager.shared
    @State private var showDestinationInput = false
    @State private var currentLocation: String = ""
    @State private var destination: String = ""
    @State private var route: MKRoute? = nil

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                MapView(userLocation: $locationManager.userLocation)
                    .edgesIgnoringSafeArea(.all)

                NavigationLink(
                    destination: GpsInputView(), // Update destination to GpsInputView
                    isActive: $showDestinationInput
                ) {
                    EmptyView()
                }
                .hidden() // Hide the NavigationLink

                SearchBarButton(action: {
                    showDestinationInput.toggle()
                })
                .padding()
                .frame(maxWidth: .infinity, alignment: .top)
            }

            Spacer()

            Toolbar(showDestinationInput: $showDestinationInput)
                .background(Color.white)
                .padding(.bottom, -25)
        }
        .navigationBarHidden(true) // Hide the navigation bar
    }
}

// Your other structs and classes...



struct SearchBarButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(UIColor(hex: "979797")))
                    .padding(.leading, 8)
                Text("Where to..")
                    .foregroundColor(Color(UIColor(hex: "979797")))
                    .padding(.trailing, 8)
                Spacer()
            }
            .padding(20)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

struct Toolbar: View {
    @Binding var showDestinationInput: Bool

    let buttons = [
        ToolbarButton(iconName: "house.fill", label: "Home"),
        ToolbarButton(iconName: "phone.fill", label: "Call"),
        ToolbarButton(iconName: "alarm.fill", label: "Alarm"),
        ToolbarButton(iconName: "person.fill", label: "Account")
    ]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(buttons, id: \.self) { button in
                VStack(spacing: 4) {
                    Button(action: {
                        if button.label == "Alarm" {
                            showDestinationInput.toggle()
                        } else {
                            // Handle other toolbar button actions
                        }
                    }) {
                        Image(systemName: button.iconName)
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .frame(width: 80, height: 60)
                            .background(Color.clear)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 4)
                                    .padding(10)
                            )
                    }
                    Text(button.label)
                        .font(.caption)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }
}

struct ToolbarButton: Hashable {
    let iconName: String
    let label: String
}

struct MapView: UIViewRepresentable {
    @Binding var userLocation: CLLocation?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let userLocation = userLocation {
            let region = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            uiView.setRegion(region, animated: true)
        } else {
            let boulderCoordinate = CLLocationCoordinate2D(latitude: 40.0150, longitude: -105.2705)
            let region = MKCoordinateRegion(
                center: boulderCoordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
            uiView.setRegion(region, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        // Implement delegate methods if needed
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    private var locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
