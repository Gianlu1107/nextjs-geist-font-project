import Foundation
import Combine

class StatsViewModel: ObservableObject {
    @Published var wordFrequency: [String: Int] = [:]
    
    private let storage = StorageService.shared
    private let authViewModel: AuthViewModel
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
        computeWordFrequency()
    }
    
    func computeWordFrequency() {
        guard let user = authViewModel.currentUser else {
            wordFrequency = [:]
            return
        }
        
        let dreams = storage.loadDreams().filter { $0.user == user }
        var frequency: [String: Int] = [:]
        
        for dream in dreams {
            let words = dream.text.lowercased().components(separatedBy: CharacterSet.alphanumerics.inverted)
            for word in words where !word.isEmpty {
                frequency[word, default: 0] += 1
            }
        }
        
        wordFrequency = frequency
    }
}
