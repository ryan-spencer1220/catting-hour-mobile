import Foundation
import Supabase

class SupabaseService {
    static let shared = SupabaseService()
    
    let client: SupabaseClient
    
    private init() {
        guard
            let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let supabaseURLString = dict["SUPABASE_URL"] as? String,
            let supabaseKey = dict["SUPABASE_KEY"] as? String,
            let supabaseURL = URL(string: supabaseURLString)
        else {
            fatalError("❌ Could not load Supabase config.")
        }

        self.client = SupabaseClient(supabaseURL: supabaseURL, supabaseKey: supabaseKey)
    }
    
    func fetchAllCatSightings() async throws -> [CatSighting] {
        let response: PostgrestResponse<[CatSighting]> = try await client
            .from("cat_sightings")
            .select()
            .execute()
        print(response)
        return response.value
    }
}
