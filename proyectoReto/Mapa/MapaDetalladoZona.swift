import SwiftUI
import InteractiveMap

struct MapaDetalladoZona: View {
    var onSelectPath: (Int) -> Void
    @State private var clickedPath = PathData()
    @State private var svgName = "RojoDetalladoSvg2"
    @State private var textScale: CGFloat = 1.0
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentScale: CGFloat = 1.0
    @State private var finalScale: CGFloat = 1.0
    @State private var currentPosition: CGSize = .zero
    @State private var dragOffset: CGSize = .zero
    
    private let minScale: CGFloat = 1.0
    private let maxScale: CGFloat = 4.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Área interactiva que cubre toda la vista
                ZoomableScrollView(
                    currentScale: $currentScale,
                    finalScale: $finalScale,
                    currentPosition: $currentPosition,
                    minScale: minScale,
                    maxScale: maxScale
                ) {
                    ZStack {
                        // Rectángulo transparente que cubre el área del mapa
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8)
                            .background(Color.white)
                        
                        // El mapa actual
                        interactiveMapView(svgName: svgName)
                            .rotationEffect(.degrees(180))
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8)
                            .offset(y: UIScreen.screenHeight/12-10)
                            .scaleEffect(1.2)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                // Botón superpuesto
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
                            textScale = 1
                        }
                        .onChange(of: clickedPath.name) { _ in
                            textScale = 1.2
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                textScale = 1.0
                            }
                        }
                    }
                    .offset(x: -UIScreen.main.bounds.width / 2 + 50, y: UIScreen.screenHeight/4 - 150)
                    .zIndex(1)
                }
            }
            .background(Color.white)
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
}

struct ZoomableScrollView<Content: View>: View {
    @Binding var currentScale: CGFloat
    @Binding var finalScale: CGFloat
    @Binding var currentPosition: CGSize
    let minScale: CGFloat
    let maxScale: CGFloat
    let content: Content
    
    @GestureState private var magnifyBy: CGFloat = 1.0
    @State private var steadyStateZoom: CGFloat = 1.0
    @GestureState private var dragOffset: CGSize = .zero
    @State private var steadyStatePosition: CGSize = .zero
    
    init(currentScale: Binding<CGFloat>,
         finalScale: Binding<CGFloat>,
         currentPosition: Binding<CGSize>,
         minScale: CGFloat,
         maxScale: CGFloat,
         @ViewBuilder content: () -> Content) {
        _currentScale = currentScale
        _finalScale = finalScale
        _currentPosition = currentPosition
        self.minScale = minScale
        self.maxScale = maxScale
        self.content = content()
    }
    
    var body: some View {
        let magnification = MagnificationGesture()
            .updating($magnifyBy) { (value, state, _) in
                state = value
            }
            .onChanged { value in
                let newScale = steadyStateZoom * value
                currentScale = min(max(newScale, minScale), maxScale)
            }
            .onEnded { value in
                steadyStateZoom = min(max(steadyStateZoom * value, minScale), maxScale)
                finalScale = steadyStateZoom
                currentScale = steadyStateZoom
            }
        
        let drag = DragGesture()
            .updating($dragOffset) { (value, state, _) in
                state = value.translation
            }
            .onChanged { value in
                let newPosition = CGSize(
                    width: steadyStatePosition.width + value.translation.width,
                    height: steadyStatePosition.height + value.translation.height
                )
                currentPosition = newPosition
            }
            .onEnded { value in
                steadyStatePosition = CGSize(
                    width: steadyStatePosition.width + value.translation.width,
                    height: steadyStatePosition.height + value.translation.height
                )
                currentPosition = steadyStatePosition
            }
        
        return content
            .scaleEffect(currentScale)
            .offset(x: currentPosition.width, y: currentPosition.height)
            .gesture(SimultaneousGesture(magnification, drag))
    }
}
#Preview {
    MapaDetalladoZona { id in
        print("Selected path ID: \(id)")
    }
}
