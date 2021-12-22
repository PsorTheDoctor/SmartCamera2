//
//  SettingsView.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 08/12/2021.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    let mint = Color(red: 0.2, green: 0.6, blue: 0.4)
    
    @State private var isShareSheetShowing = false
    
    func share() {
        isShareSheetShowing.toggle()
        
        let text = "Hello from Smart Camera!"
        let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
    func rate() {
        guard let scene = UIApplication.shared.windows.first?.windowScene else { return }
        
        SKStoreReviewController.requestReview(in: scene)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(mint)
                            .frame(height: 100)
                        Button(action: share) {
                            Text("Share")
                            Image(systemName: "square.and.arrow.up")
                                .font(.largeTitle)
                        }
                        .background(mint)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(mint)
                            .frame(height: 100)
                        Button(action: rate) {
                            Text("Rate")
                            Image(systemName: "star")
                                .font(.largeTitle)
                        }
                        .background(mint)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    }
                }
                Spacer()
            }.navigationTitle("Settings")
        }
    }
}
