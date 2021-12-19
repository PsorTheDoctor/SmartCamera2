//
//  Classifier.swift
//  SmartCamera2
//
//  Created by Adam Wolkowycki on 19/12/2021.
//

import CoreML
import Vision
import CoreImage

struct Classifier {
    
    private(set) var results: String?
    
    mutating func detect(ciImage: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: SqueezeNet(configuration: MLModelConfiguration()).model) else { return }
        
        let request = VNCoreMLRequest(model: model)
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        try? handler.perform([request])
        
        guard let results = request.results as? [VNClassificationObservation] else { return }
        
        if let firstResult = results.first {
            self.results = firstResult.identifier
        }
    }
}
