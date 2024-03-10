import SwiftUI

struct LandingView: View {
    @State private var selectedFeature = 0
    // Array of feature descriptions
    let featureDescriptions = [
        "Description of Feature 1",
        "Description of Feature 2",
        "Description of Feature 3"
    ]

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("logo2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.3)
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.25) // Center the logo vertically in the upper part

                TabView(selection: $selectedFeature) {
                    ForEach(0..<featureDescriptions.count, id: \.self) { index in
                        FeatureView(description: featureDescriptions[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: geometry.size.height * 0.3)

                HStack(spacing: 10) {
                    ForEach(0..<featureDescriptions.count, id: \.self) { index in
                        Circle()
                            .fill(index == selectedFeature ? Color.blue : Color.gray)
                            .frame(width: 10, height: 10)
                    }
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.8)

                Button("Next") {
                    withAnimation {
                        selectedFeature = (selectedFeature + 1) % featureDescriptions.count
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.9)
            }
        }
    }
}

struct FeatureView: View {
    var description: String

    var body: some View {
        VStack {
            Text(description)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
