//
//  YoloViewController.swift
//  SeaFood
//
//  Created by rodoolfo gonzalez on 14-06-23.
//



import UIKit
import AVFoundation
import Vision

protocol YOLODetectionDelegate: AnyObject {
    func didDetectObjects(_ objects: [YOLOObject])
}

class YoloViewController : NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    private var session: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var detectionDelegate: YOLODetectionDelegate?
    
    private var yoloModel = MLModel()
    
    init(detectionDelegate: YOLODetectionDelegate) {
        self.detectionDelegate = detectionDelegate
        super.init()
        
        setupCaptureSession()
        loadYOLOModel()
    }
    
    private func setupCaptureSession() {
        session = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            return
        }
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        
        session?.addInput(input)
        session?.addOutput(videoOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session!)
    }
    
    private func loadYOLOModel() {
        yoloModel = YOLOv3Tiny().model
    }
    
    func startDetection() {
        session?.startRunning()
    }
    
    func stopDetection() {
        session?.stopRunning()
    }
    
    // AVCaptureVideoDataOutputSampleBufferDelegate method
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        performObjectDetection(on: pixelBuffer)
    }
    
    private func performObjectDetection(on pixelBuffer: CVPixelBuffer) {
        guard let yoloModel = yoloModel else {
            return
        }
        
        let request = VNCoreMLRequest(model: yoloModel.model) { [weak self] (request, error) in
            guard let results = request.results as? [VNRecognizedObjectObservation] else {
                return
            }
            
            let yoloObjects = self?.processResults(results)
            
            DispatchQueue.main.async {
                self?.detectionDelegate?.didDetectObjects(yoloObjects ?? [])
            }
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    private func processResults(_ results: [VNRecognizedObjectObservation]) -> [YOLOObject] {
        var objects: [YOLOObject] = []
        
        for result in results {
            guard let label = result.labels.first?.identifier else {
                continue
            }
            
            let boundingBox = result.boundingBox
            
            let yoloObject = YOLOObject(label: label, boundingBox: boundingBox)
            objects.append(yoloObject)
        }
        
        return objects
    }
}

struct YOLOObject {
    let label: String
    let boundingBox: CGRect
}

class YOLOModel {
    let model: VNCoreMLModel
    
    init() {
        let modelURL = Bundle.main.url(forResource: "YOLOModel", withExtension: "mlmodelc")!
        model = try! VNCoreMLModel(for: MLModel(contentsOf: modelURL))
    }
}

