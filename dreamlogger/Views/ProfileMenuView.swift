import SwiftUI

struct ProfileMenuView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var showingLogin = false
    
    var body: some View {
        Menu {
            if let user = authViewModel.currentUser {
                Text("Logged in as \\(user)")
                Button("Logout") {
                    authViewModel.logout()
                }
            } else {
                Button("Login") {
                    showingLogin = true
                }
            }
        } label: {
            Image(systemName: "person.circle")
                .font(.title)
                .foregroundColor(.accentColor)
        }
        .sheet(isPresented: $showingLogin) {
            LoginView(authViewModel: authViewModel)
        }
    }
}

struct ProfileMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMenuView(authViewModel: AuthViewModel())
    }
}
