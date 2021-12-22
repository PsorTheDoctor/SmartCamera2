//
//  CameraView.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 06/12/2021.
//

import SwiftUI

struct CameraView: View {
    
    let mint = Color(red: 0.2, green: 0.6, blue: 0.4)
    
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @StateObject var camera = CameraModel()
    
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
                    .padding()
                    .background(mint)
                    .clipShape(Circle())
                
                Image(systemName: "camera")
                    .onTapGesture {
                        isPresenting = true
                        sourceType = .camera
                    }
                    .padding()
                    .background(mint)
                    .clipShape(Circle())
            }
            .foregroundColor(.white)
            
            if uiImage != nil {
                Image(uiImage: uiImage!)
                    .resizable()
                    .scaledToFit()
            } else {
                CameraPreview(camera: camera).ignoresSafeArea(.all, edges: .all)
            }

            VStack {
                Button(action: {
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                    }
                }) {
                    Text("")
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
            }.onAppear(perform: camera.check)
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
        }.padding()
    }
}
