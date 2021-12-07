//
//  ContentView.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 07/12/2021.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
    }
    
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            CameraView().tabItem {
                Image(systemName: "camera")
                Text("Camera")
            }
            SettingsView().tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
