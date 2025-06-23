import SwiftUI

struct DreamsListView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var dreamViewModel: DreamViewModel
    
    @State private var searchText: String = ""
    
    init() {
        let authVM = AuthViewModel()
        _authViewModel = StateObject(wrappedValue: authVM)
        _dreamViewModel = StateObject(wrappedValue: DreamViewModel(authViewModel: authVM))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $dreamViewModel.searchText)
                    .padding(.horizontal)
                
                List {
                    ForEach(dreamViewModel.dreams) { dream in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(dream.title)
                                .font(.headline)
                            Text(dream.text)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(dream.date, style: .date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Your Dreams")
            .onAppear {
                dreamViewModel.loadDreams()
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Search dreams"
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

struct DreamsListView_Previews: PreviewProvider {
    static var previews: some View {
        DreamsListView()
    }
}
