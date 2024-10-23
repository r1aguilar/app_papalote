import SwiftUI
import InteractiveMap

struct MapaDetalladoZona: View {
    var onSelectPath: (Int) -> Void
    @State private var clickedPath = PathData()
    @State private var svgName = "RojoDetalladoSvg2"
    @State private var textScale: CGFloat = 1.0
    @Environment(\.dismiss) private var dismiss
    
    // State for zoom and pan with initial values
    @State private var zoomScale: CGFloat = 1.0
    @State private var lastZoomScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var isDragging = false
    
    // Constants for animation and zoom limits
    private let defaultOffset = CGSize.zero
    private let animationDuration: Double = 0.3
    private let minScale: CGFloat = 1.0
    private let maxScale: CGFloat = 4.0
    
    var body: some View {
        ZStack {
            Color.white
            
            if clickedPath.name != "undefined", !clickedPath.name.isEmpty {
                VStack {
                    Button(action: {
                        onSelectPath(1)
                        dismiss()
                    }) {
                        Text("Ir hacia \(clickedPath.name)")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .rotationEffect(.degrees(270))
                    .scaleEffect(textScale)
                    .animation(.easeInOut(duration: 0.2), value: textScale)
                    .onAppear {
                        textScale = 1.2
                    }
                    .onChange(of: clickedPath.name) { _ in
                        textScale = 1.2
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            textScale = 1.0
                        }
                    }
                }
                .offset(x: -UIScreen.main.bounds.width / 2 + 35)
            }

            ScrollView([.horizontal, .vertical]) {
                VStack {
                    interactiveMapView(svgName: svgName)
                        .scaleEffect(zoomScale)
                        .offset(x: offset.width, y: offset.height)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    let delta = value / lastZoomScale
                                    lastZoomScale = value
                                    
                                    // Calculate new scale
                                    let newScale = zoomScale * delta
                                    
                                    // Limit zoom scale between minScale and maxScale
                                    zoomScale = min(max(newScale, minScale), maxScale)
                                }
                                .onEnded { value in
                                    lastZoomScale = 1.0
                                    withAnimation(.spring(duration: animationDuration)) {
                                        zoomScale = 1.0
                                        offset = defaultOffset
                                    }
                                }
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    isDragging = true
                                    // Scale the drag by the zoom scale to make it feel more natural
                                    let scaledTranslation = CGSize(
                                        width: value.translation.width * zoomScale,
                                        height: value.translation.height * zoomScale
                                    )
                                    offset = scaledTranslation
                                }
                                .onEnded { _ in
                                    isDragging = false
                                    withAnimation(.spring(duration: animationDuration)) {
                                        offset = defaultOffset
                                    }
                                }
                        )
                        .rotationEffect(.degrees(180))
                        .padding(.vertical, UIScreen.main.bounds.width / 10)
                        .padding(.horizontal, UIScreen.main.bounds.width / 8)
                        .offset(x: UIScreen.screenWidth / 2 - 170)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                }
            }
            .ignoresSafeArea()
        }
    }

    private func interactiveMapView(svgName: String) -> some View {
        InteractiveMap(svgName: svgName) { pathData in
            InteractiveShape(pathData)
                .stroke(clickedPath == pathData ? pathDictionary[pathData.name]?.0 ?? Color.black.opacity(0.4) : pathDictionary[pathData.name]?.0 ?? Color.black.opacity(0.4))
                .background(InteractiveShape(pathData).fill(pathDictionary[pathData.name]?.0 ?? colores[5]!))
                .onTapGesture {
                    clickedPath = pathData
                }
        }
        .id(svgName)
    }
    
    // Función para capitalizar la primera letra de una cadena
    private func capitalizeFirstLetter(_ text: String) -> String {
        guard let firstLetter = text.first else { return text }
        return firstLetter.uppercased() + text.dropFirst()
    }
}

#Preview {
    MapaDetalladoZona { id in
        print("Selected path ID: \(id)")
    }
}
