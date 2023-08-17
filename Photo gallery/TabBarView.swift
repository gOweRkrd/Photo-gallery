import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        
        TabView {
            MainView()
                .tabItem {
                    Label("", systemImage: "photo.fill")
                }
            
            FavoritesView()
                .tabItem {
                    Label("", systemImage: "heart.fill")
                }
        }
        .accentColor(Color(R.Colors.black))
    }
}
