import Foundation
import Combine

class DreamViewModel: ObservableObject {
    @Published var dreams: [Dream] = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let storage = StorageService.shared
    private let authViewModel: AuthViewModel
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
        loadDreams()
        
        $searchText
            .sink { [weak self] _ in
                self?.filterDreams()
            }
            .store(in: &cancellables)
    }
    
    func loadDreams() {
        let allDreams = storage.loadDreams()
        if let user = authViewModel.currentUser {
            dreams = allDreams.filter { $0.user == user }
        } else {
            dreams = []
        }
    }
    
    func addDream(text: String) {
        guard let user = authViewModel.currentUser else { return }
        let newDream = Dream(id: UUID(), text: text, date: Date(), user: user)
        dreams.insert(newDream, at: 0)
        saveDreams()
    }
    
    func saveDreams() {
        var allDreams = storage.loadDreams()
        // Remove dreams of current user
        if let user = authViewModel.currentUser {
            allDreams.removeAll { $0.user == user }
            allDreams.append(contentsOf: dreams)
            storage.saveDreams(allDreams)
        }
    }
    
    func filterDreams() {
        loadDreams()
        if !searchText.isEmpty {
            dreams = dreams.filter { $0.text.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
