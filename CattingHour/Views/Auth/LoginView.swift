import SwiftUI
import Supabase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }

                Button("Log In") {
                    Task {
                        await logIn()
                    }
                }

                Button("Sign Up") {
                    Task {
                        await signUp()
                    }
                }
            }
            .padding()
            .navigationTitle("Sign In")
        }
    }

    func logIn() async {
        do {
            try await SupabaseService.shared.client.auth.signIn(email: email, password: password)
            print("✅ Logged in")
        } catch {
            errorMessage = "❌ Login failed: \(error.localizedDescription)"
        }
    }

    func signUp() async {
        do {
            try await SupabaseService.shared.client.auth.signUp(email: email, password: password)
            print("✅ Signed up")
        } catch {
            errorMessage = "❌ Signup failed: \(error.localizedDescription)"
        }
    }
}
