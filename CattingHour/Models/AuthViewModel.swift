import Supabase
import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: User?

    init() {
        Task {
            await refreshUser()
        }
    }

    func refreshUser() async {
        do {
            let session = try await SupabaseService.shared.client.auth.session
            self.user = session.user
        } catch {
            print("⚠️ Failed to get session: \(error)")
            self.user = nil
        }
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
