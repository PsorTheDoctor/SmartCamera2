//
//  CameraView.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 06/12/2021.
//

import SwiftUI

struct CameraView: View {
    
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @ObservedObject var classifier: ImageClassifier
    @ObservedObject var speechService: SpeechService
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "photo")
                    .onTapGesture {
                        isPresenting = true
                        sourceType = .photoLibrary
                    }
                Image(systemName: "camera")
                    .onTapGesture {
                        isPresenting = true
                        sourceType = .camera
                    }
            }
            .font(.largeTitle)
            .foregroundColor(.blue)
            
            Rectangle()
                .strokeBorder()
                .foregroundColor(.yellow)
                .overlay(
                    Group {
                        if uiImage != nil {
                            Image(uiImage: uiImage!)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                )
            VStack {
                Button(action: {
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                    }
                }) {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }
                Group {
                    if let imageClass = classifier.imageClass {
                        HStack {
                            Text("Image categories:").font(.caption)
                            Text(imageClass).bold()
                        }
                    } else {
                        HStack {
                            Text("Nothing found. Please try again").font(.caption)
                        }
                    }
                }
                .font(.subheadline)
                .padding()
            }
        }
        .sheet(isPresented: $isPresenting) {
            ImagePicker(uiImage: $uiImage, isPresenting: $isPresenting, sourceType: $sourceType).onDisappear() {
                if uiImage != nil {
                    classifier.detect(uiImage: uiImage!)
                    
                    if let imageClass = classifier.imageClass {
                        speechService.speak(text: imageClass)
                    } else {
                        speechService.speak(text: "Nothing found. Please try again")
                    }
                }
            }
        }
        .padding()
    }
}
