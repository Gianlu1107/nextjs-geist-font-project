import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var currentUser: String? = nil
    
    init() {
        loadUser()
    }
    
    func loadUser() {
        currentUser = StorageService.shared.loadCurrentUser()
    }
    
    func login(username: String) {
        StorageService.shared.saveCurrentUser(username)
        currentUser = username
    }
    
    func logout() {
        StorageService.shared.clearCurrentUser()
        currentUser = nil
    }
    
    func isLoggedIn() -> Bool {
        return currentUser != nil
    }
}
