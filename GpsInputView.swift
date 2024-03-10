import SwiftUI

struct GpsInputView: View {
    @State private var latitude: String = ""
    @State private var longitude: String = ""

    var body: some View {
        VStack {
            TextField("Latitude", text: $latitude)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Longitude", text: $longitude)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Submit") {
                // Perform action with latitude and longitude values
                print("Latitude: \(latitude), Longitude: \(longitude)")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

struct GpsInputView_Previews: PreviewProvider {
    static var previews: some View {
        GpsInputView()
    }
}
