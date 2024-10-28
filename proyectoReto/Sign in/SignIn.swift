//
//  SignIn.swift
//  proyectoReto
//
//  Created by user254414 on 10/28/24.
//

import SwiftUI

struct SignIn: View {
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var isLoginViewShown: Bool = false
    @State private var isRegisterViewShown: Bool = false
    @Environment(\.colorScheme) private var colorScheme
    
    var isSignInButtonDisabled: Bool {
        [name, password].contains(where: \.isEmpty)
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
                    .transition(.move(edge: isRegisterViewShown ? .leading : .trailing))
            }
            
            if isRegisterViewShown {
                registerView
                    .transition(.move(edge: isLoginViewShown ? .trailing : .leading))
            }
        }
    }
    
    private var loginView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.thinMaterial)
                .padding(.vertical, 120)
                .padding(.horizontal, 25)
                .shadow(radius: 8, y: 10)
                .environment(\.colorScheme, .light)
            
            VStack {
                Text("Inicio de sesión")
                    .font(.system(size: 40))
                    .bold()
                    .padding(.bottom, 25)
                    .foregroundStyle(Color.black)
                
                TextField("Name", text: $name, prompt: Text("Ingresa tu correo").foregroundColor(Color(white: 0.4)).bold())
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
                    print("Hacer Log In")
                } label: {
                    Text("Ingresar")
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
                .padding(.top, 40)
                
                Button {
                    withAnimation(.easeInOut) {
                        isLoginViewShown = false
                        isRegisterViewShown = true
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
                .padding(.vertical, 120)
                .padding(.horizontal, 25)
                .shadow(radius: 8, y: 10)
                .environment(\.colorScheme, .light)
            
            VStack {
                Text("Registro de usuario")
                    .font(.system(size: 37))
                    .bold()
                    .padding(.bottom, 25)
                    .foregroundStyle(Color.black)
                
                TextField("Name", text: $name, prompt: Text("Ingresa tu correo").foregroundColor(Color(white: 0.4)).bold())
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
                
                TextField("Name", text: $name, prompt: Text("Nombre de usuario").foregroundColor(Color(white: 0.4)).bold())
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
                    LinearGradient(colors: [colores[3]!, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(30)
                .shadow(radius: 8, y: 10)
                .padding(.top, 40)
                
                Button {
                    withAnimation(.easeInOut) {
                        isRegisterViewShown = false
                        isLoginViewShown = true
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
