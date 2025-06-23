import SwiftUI

@main
struct dreamloggerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                DreamsListView()
                    .tabItem {
                        Label("Dreams", systemImage: "list.bullet")
                    }
                StatsView()
                    .tabItem {
                        Label("Stats", systemImage: "chart.bar")
                    }
            }
        }
    }
}
