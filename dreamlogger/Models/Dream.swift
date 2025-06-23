import Foundation

struct Dream: Identifiable, Codable {
    let id: UUID
    var text: String
    let date: Date
    let user: String
    
    var title: String {
        // Return first 5-6 words as title
        let words = text.split(separator: " ")
        let titleWords = words.prefix(6)
        return titleWords.joined(separator: " ")
    }
}
