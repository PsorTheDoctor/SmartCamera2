//
//  ImageClassifier.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 19/12/2021.
//

import SwiftUI

class ImageClassifier: ObservableObject {
    
    @Published private var classifier = Classifier()
    
    var imageClass: String? {
        classifier.results
    }
    
    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage(image: uiImage) else { return }
        classifier.detect(ciImage: ciImage)
    }
}
