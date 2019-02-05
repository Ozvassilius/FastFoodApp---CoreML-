//
//  CoreMLHelper.swift
//  FestFoodApp
//
//  Created by Macinstosh on 05/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit
import Vision
import CoreML

class CoreMLHelper {

    private static let _analyse = CoreMLHelper()
    static var analyse: CoreMLHelper {
        return _analyse
    }

    var completion : ((String?) -> Void)?
    var erreurString = "Appuyez sur le burger pour choisir une image"

    func junkfood(_ image: UIImage?, completion: ((String?) -> Void)? ) {
        self.completion = completion

        if let img = image {
            if let data = img.pngData() {
                do {
                    let modele = try VNCoreMLModel(for: ImageClassifier().model)
                    let request = VNCoreMLRequest(model: modele, completionHandler: response)
                    let handler = VNImageRequestHandler(data: data, options: [:])
                    try handler.perform([request])
                } catch {
                    print(error.localizedDescription)
                        completion?(erreurString)
                }
            } else {
                completion?(erreurString)
            }
        } else {
            completion?(erreurString)
        }
    }

    func response(_ request: VNRequest, _ error: Error?) {
        if let resultats = request.results as? [VNClassificationObservation] {
            if  resultats.count > 0 {
                let bon = resultats[0]
                let confidence = " à \(Int(bon.confidence * 100))% "
                let resultatString = "Selon CoreML ceci est " + bon.identifier + confidence
                completion?(resultatString)
            } else {
                completion?(erreurString)
            }
        } else {
            completion?(erreurString)
        }
    }

}
