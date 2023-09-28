//
//  ViewController.swift
//  SeaFood
//
//  Created by rodoolfo gonzalez on 30-05-23.
//

import UIKit
import CoreML
import Vision


//reconocimiento de imagen

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        //imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage{
            imageView.image = image
            
            guard let ciImage = CIImage(image: image) else{
                fatalError("error convert to CIIMAGE")
            }
        
            self.detect(image: ciImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
       
    }
    
    func detect( image: CIImage ){
        
       // RECONOCIMIENTO DE TEXTO EN IMAGEN
         /*let request = VNRecognizeTextRequest { request, error in
             guard let results = request.results as? [VNRecognizedTextObservation] else {
                 fatalError("problema al recuperar el resultado")
             }
             let text = results.compactMap({
                 $0.topCandidates(1).first?.string
                 }).joined(separator: ", ")
                 print(text)
         }
             let handler = VNImageRequestHandler(ciImage: image)
                    do{
                        request.recognitionLevel = VNRequestTextRecognitionLevel.fast
                        try handler.perform([request])
                    }
                    catch{
                        print("error al intentar clasificar la imagen")
                    }
        
        
        */
        // RECONOCIMIENTO IMAGEN
        guard let model = try? VNCoreMLModel (for: Inceptionv3().model) else{
            
            fatalError("problemas al recuperar el pronostico del modelo")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("problema al recuperar el resultado")
            }
            if let firstResult = results.first{
                self.navigationItem.title = firstResult.identifier
                print(firstResult.identifier)
            }
           
        }
            let handler = VNImageRequestHandler(ciImage: image)
                   do{
                       
                       try handler.perform([request])
                   }
                   catch{
                       print("error al intentar clasificar la imagen")
                   }
    }
    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

