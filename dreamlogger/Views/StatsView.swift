import SwiftUI

struct StatsView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var statsViewModel: StatsViewModel
    
    init() {
        let authVM = AuthViewModel()
        _authViewModel = StateObject(wrappedValue: authVM)
        _statsViewModel = StateObject(wrappedValue: StatsViewModel(authViewModel: authVM))
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Word Frequency")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                List {
                    ForEach(statsViewModel.wordFrequency.sorted(by: { $0.value > $1.value }), id: \.key) { word, count in
                        HStack {
                            Text(word)
                            Spacer()
                            Text("\\(count)")
                        }
                    }
                }
            }
            .navigationTitle("Statistics")
            .onAppear {
                statsViewModel.computeWordFrequency()
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
