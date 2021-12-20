//
//  SettingsView.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 08/12/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isShareSheetShowing = false
    
    func share() {
        isShareSheetShowing.toggle()
        
        let text = "Hello from Smart Camera!"
        let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: share) {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                        .font(.largeTitle)
                }
            }.navigationTitle("Settings")
        }
    }
}
