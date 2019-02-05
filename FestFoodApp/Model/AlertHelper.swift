//
//  AlertHelper.swift
//  FestFoodApp
//
//  Created by Macinstosh on 05/02/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

// Pour gerer facilement nos alertes popup

import UIKit

class AlertHelper {


    private static let _montrer = AlertHelper()

    // mon getter de montrer
    static var montrer: AlertHelper {
        return _montrer
    }

    func choixCamera(controller: CameraController, picker: UIImagePickerController) {

        let alerte = UIAlertController(title: "Prendre une photo", message: "Quel media voulez vous utiliser?", preferredStyle: .actionSheet)

        let camera = UIAlertAction(title: "Appareil photo", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                controller.present(picker, animated: true, completion: nil)
            } else {
                self.erreur(controller: controller, erreur: "L'appareil photo n'est pas disponible")
            }
        }

        let gallery = UIAlertAction(title: "Gallerie de photos", style: .default) { (action) in
            picker.sourceType = .photoLibrary
            controller.present(picker, animated: true, completion: nil)
        }

        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)

        alerte.addAction(camera)
        alerte.addAction(gallery)
        alerte.addAction(cancel)

        // Pour l'ipad !
        if let pop = alerte.popoverPresentationController {
            pop.sourceView = controller.view
            pop.sourceRect = CGRect(x: controller.view.frame.midX, y: controller.view.frame.midY, width: 0, height: 0)
            pop.permittedArrowDirections = []
        }
        ////////////////

        controller.present(alerte, animated: true, completion: nil)




    }

    func erreur(controller: CameraController, erreur: String){
         let alerte = UIAlertController(title: "Erreur", message: erreur, preferredStyle: .alert)
         let ok = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alerte.addAction(ok)
        controller.present(alerte, animated: true, completion: nil)
    }



}
