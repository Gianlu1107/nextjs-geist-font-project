import SwiftUI

struct RecordView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var dreamViewModel: DreamViewModel
    @StateObject private var speechService = SpeechService()
    
    @State private var dreamText: String = ""
    @State private var showLogin = false
    
    init() {
        let authVM = AuthViewModel()
        _authViewModel = StateObject(wrappedValue: authVM)
        _dreamViewModel = StateObject(wrappedValue: DreamViewModel(authViewModel: authVM))
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ProfileMenuView(authViewModel: authViewModel)
                    .padding()
            }
            
            TextEditor(text: $dreamText)
                .padding()
                .border(Color.gray.opacity(0.5), width: 1)
                .cornerRadius(12)
                .frame(minHeight: 200)
            
            HStack(spacing: 20) {
                Button(action: {
                    if speechService.isRecording {
                        speechService.stopRecording()
                        dreamText += " " + speechService.transcript
                    } else {
                        speechService.requestAuthorization { authorized in
                            if authorized {
                                do {
                                    try speechService.startRecording()
                                } catch {
                                    print("Failed to start recording: \\(error)")
                                }
                            } else {
                                print("Speech recognition not authorized")
                            }
                        }
                    }
                }) {
                    Image(systemName: speechService.isRecording ? "mic.fill" : "mic")
                        .font(.largeTitle)
                        .foregroundColor(speechService.isRecording ? .red : .blue)
                }
                
                Button(action: {
                    if authViewModel.isLoggedIn() {
                        dreamViewModel.addDream(text: dreamText)
                        dreamText = ""
                    } else {
                        showLogin = true
                    }
                }) {
                    Text("Save Dream")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(authViewModel.isLoggedIn() ? Color.accentColor : Color.gray)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                }
                .disabled(!authViewModel.isLoggedIn())
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showLogin) {
            LoginView(authViewModel: authViewModel)
        }
        .onChange(of: speechService.transcript) { newValue in
            dreamText = newValue
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
