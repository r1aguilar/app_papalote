import SwiftUI

struct SignIn: View {
    @State private var username: String = ""
    @State private var correo: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var isLoginViewShown: Bool = false
    @State private var isRegisterViewShown: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isLoading: Bool = false // Nuevo estado para el progreso
    
    @Environment(\.colorScheme) private var colorScheme
    
    var isSignInButtonDisabled: Bool {
        [correo, password].contains(where: \.isEmpty) || isLoading // Deshabilitar si está cargando
    }
    
    var isRegisterButtonDisabled: Bool {
        [correo, password, username].contains(where: \.isEmpty)
    }
    
    var body: some View {
        ZStack {
            Color.init(red: 193/255, green: 214/255, blue: 47/255).ignoresSafeArea()
            
            VStack {
                Image("LogoVerde")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                    .offset(x: -4)
                    .padding(.bottom, 30)
                
                Button {
                    withAnimation(.easeInOut) {
                        isLoginViewShown = true
                    }
                } label: {
                    Text("Comenzar")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(height: 50)
                .frame(width: 280)
                .background(
                    LinearGradient(colors: [colores[3]!, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(30)
                .shadow(radius: 8, y: 10)
                .padding()
            }
            
            if isLoginViewShown {
                loginView
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))
                    .zIndex(isRegisterViewShown ? 0 : 1)
            }
            
            if isRegisterViewShown {
                registerView
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))
                    .zIndex(isRegisterViewShown ? 1 : 0)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("Aceptar")))
        }
    }
    
    private var loginView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.thinMaterial)
                .padding(.vertical, UIScreen.screenHeight / 6)
                .padding(.horizontal, 25)
                .shadow(radius: 8, y: 10)
                .environment(\.colorScheme, .light)
            
            VStack {
                Text("Inicio de sesión")
                    .font(.system(size: 40))
                    .bold()
                    .padding(.bottom, 25)
                    .foregroundStyle(Color.black)
                
                TextField("Correo", text: $correo, prompt: Text("Ingresa tu correo").foregroundColor(Color(white: 0.4)).bold())
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 2)
                    }
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.9)))
                    .shadow(radius: 2, y: 2)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .frame(width: 335)
                
                passwordField
                
                Button {
                    iniciarSesion()
                } label: {
                    if isLoading {
                        ProgressView() // Ícono de carga
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(width: 20, height: 20) // Tamaño del ícono
                    } else {
                        Text("Ingresar")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 50)
                .frame(width: 280)
                .background(
                    isSignInButtonDisabled ?
                    LinearGradient(colors: [Color(white: 0.75), Color(white: 0.55)], startPoint: .topLeading, endPoint: .bottomTrailing) :
                    LinearGradient(colors: [colores[3]!, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(30)
                .shadow(radius: 8, y: 10)
                .padding(.top, 40)
                .disabled(isSignInButtonDisabled) // Deshabilitar el botón si está cargando
                
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isLoginViewShown = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isRegisterViewShown = true
                            }
                        }
                    }
                } label: {
                    Text("¿No tienes una cuenta?").padding(.top, 10)
                }
            }
            
            closeButton {
                withAnimation(.easeInOut) {
                    isLoginViewShown = false
                }
            }
        }
    }

    private var registerView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.thinMaterial)
                .padding(.vertical, UIScreen.screenHeight/6)
                .padding(.horizontal, 25)
                .shadow(radius: 8, y: 10)
                .environment(\.colorScheme, .light)
            
            VStack {
                Text("Registro de usuario")
                    .font(.system(size: 37))
                    .bold()
                    .padding(.bottom, 25)
                    .foregroundStyle(Color.black)
                
                TextField("Correo", text: $correo, prompt: Text("Ingresa tu correo").foregroundColor(Color(white: 0.4)).bold())
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 2)
                    }
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.9)))
                    .shadow(radius: 2, y: 2)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                    .frame(width: 335)
                
                TextField("Nombre de usuario", text: $username, prompt: Text("Nombre de usuario").foregroundColor(Color(white: 0.4)).bold())
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 2)
                    }
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.9)))
                    .shadow(radius: 2, y: 2)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                    .frame(width: 335)
                
                passwordField
                
                Button {
                    print("Registrarse")
                } label: {
                    Text("Regístrate")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(height: 50)
                .frame(width: 280)
                .background(
                    isRegisterButtonDisabled ?
                    LinearGradient(colors: [Color(white: 0.75), Color(white: 0.55)], startPoint: .topLeading, endPoint: .bottomTrailing) :
                    LinearGradient(colors: [colores[3]!, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(30)
                .shadow(radius: 8, y: 10)
                .padding(.top, 40)
                
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isRegisterViewShown = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isLoginViewShown = true
                            }
                        }
                    }
                } label: {
                    Text("¿Ya tienes una cuenta?").padding(.top, 10)
                }
            }
            
            closeButton {
                withAnimation(.easeInOut) {
                    isRegisterViewShown = false
                }
            }
        }
    }
    
    private func iniciarSesion() {
        isLoading = true // Comenzar la carga
        
        guard let url = URL(string: "\(apiURLbase)login") else { return }
        
        let loginData: [String: String] = ["correo": correo, "password": password]
        guard let jsonData = try? JSONEncoder().encode(loginData) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false // Detener la carga
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.alertMessage = "No se pudo ingresar: \(error.localizedDescription)"
                    self.showAlert = true
                    self.correo = ""
                    self.password = ""
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.alertMessage = "No se recibió datos de la respuesta."
                    self.showAlert = true
                    self.correo = ""
                    self.password = ""
                }
                return
            }
            
            if let usuario = try? JSONDecoder().decode(user.self, from: data) {
                guardarUsuario(usuario: usuario)
                DispatchQueue.main.async {
                    // Navegar a InicioView() aquí
                    // Puedes usar una variable de estado o algún mecanismo para cambiar la vista
                }
            } else {
                DispatchQueue.main.async {
                    self.alertMessage = "No se pudo ingresar: datos inválidos."
                    self.showAlert = true
                    self.correo = ""
                    self.password = ""
                }
            }
        }
        
        task.resume()
    }
    
    private func guardarUsuario(usuario: user) {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("sesion.json")
        
        guard let url = fileURL else { return }
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(usuario)
            try jsonData.write(to: url)
        } catch {
            print("Error guardando el usuario: \(error)")
        }
    }

    private var passwordField: some View {
        ZStack {
            Group {
                if showPassword {
                    TextField("Contraseña", text: $password, prompt: Text("Contraseña").foregroundColor(Color(white: 0.4)).bold())
                } else {
                    SecureField("Contraseña", text: $password, prompt: Text("Contraseña").foregroundColor(Color(white: 0.4)).bold())
                }
            }
            .multilineTextAlignment(.center)
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 2)
            }
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.9)))
            .shadow(radius: 2, y: 2)
            .padding(.horizontal)
            .frame(width: 335)
            
            Button {
                showPassword.toggle()
            } label: {
                Image(systemName: showPassword ? "eye.slash" : "eye")
                    .foregroundColor(Color(white: 0.1)).bold()
            }
            .offset(x: UIScreen.screenWidth / 3 - 10)
        }
    }
    
    private func closeButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.secondary)
                    .frame(width: 35)
                
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
            }
            .padding(8)
            .contentShape(Circle())
        }
        .buttonStyle(PlainButtonStyle())
        .offset(y: UIScreen.screenHeight / 3.1)
    }
}

#Preview {
    SignIn()
}
