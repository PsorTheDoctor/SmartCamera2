//
//  ContentView.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 07/12/2021.
//

import SwiftUI

struct ContentView: View {
    
    let mint = Color(red: 0.2, green: 0.6, blue: 0.4)

    
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
        // UITabBar.appearance().unselectedItemTintColor = .white
    }
    
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            CameraView(classifier: ImageClassifier(),
                       speechService: SpeechService()).tabItem {
                Image(systemName: "camera")
                Text("Camera")
            }
            SettingsView().tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }.accentColor(mint)
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
