//
//  ViewController.swift
//  FestFoodApp
//
//  Created by Macinstosh on 04/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class CameraController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLbl: UILabel!

    // on créé comme ceci une instance de d'alerte helper
    let alertHelper = AlertHelper.montrer

    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.allowsEditing = false

    }

    @IBAction func takePicture(_ sender: Any) {
        alertHelper.choixCamera(controller: self, picker: picker    )
    }
    
}

extension CameraController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originale = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.imageView.image = originale
            }
        }

        dismiss(animated: true) {
            // appeller la fonction pour faire une requete CoreML
            CoreMLHelper.analyse.junkfood(self.imageView.image, completion: { (string) in
                DispatchQueue.main.async {
                    if string != nil {
                        self.predictionLbl.text = string!
                    }
                }
            })
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

