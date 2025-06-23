import SwiftUI

struct HomeView: View {
    @State private var navigateToRecord = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("dreamlogger")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
                
                Text("Welcome to dreamlogger! Write or dictate your dreams and keep them safe locally on your device.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                
                NavigationLink(destination: RecordView(), isActive: $navigateToRecord) {
                    EmptyView()
                }
                
                Button(action: {
                    navigateToRecord = true
                }) {
                    Text("Start Writing a Dream")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
