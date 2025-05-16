import Supabase
import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: User?

    init() {
        user = SupabaseService.shared.client.auth.session.user
    }

    func refreshUser() {
        user = SupabaseService.shared.client.auth.session.user
    }

    func logout() async {
        do {
            try await SupabaseService.shared.client.auth.signOut()
            user = nil
        } catch {
            print("Logout failed: \(error)")
        }
    }
}
