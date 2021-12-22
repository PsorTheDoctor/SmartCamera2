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
                                .font(.title)
                        }
                        .background(mint)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    }
                }.padding(10)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Frequenty asked questions")
                            .font(.title)
                            .padding(.bottom)
                        Text("How does it work?").bold()
                        Text("We use machine learning methods called convolutional neural networks to recognize images.\n").foregroundColor(.gray)
                        Text("My app has been crashed while using a camera. What should I do?").bold()
                        Text("Try to reinstall the app, it usually helps. It seems like a reason of this problem occurs in the SwiftUI code. The same object detection system was working well, even in real-time with older version of Swift.\n").foregroundColor(.gray)
                        Text("Contact").bold()
                        Text("adwol21@student.sdu.dk")
                    }
                    .padding()
                }
            }.navigationTitle("Settings")
        }
    }
}
