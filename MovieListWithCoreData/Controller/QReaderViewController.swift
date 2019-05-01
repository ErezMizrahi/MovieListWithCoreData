//
//  QReaderViewController.swift
//  MovieListWithCoreData
//
//  Created by hackeru on 01/05/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit
import AVFoundation
class QReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    var video = AVCaptureVideoPreviewLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("started")
        let session = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
    
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        }catch{
            print(error)
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        session.startRunning()
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count > 0 {
            if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr {
                    let alert = UIAlertController(title: "QRcode", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (UIAlertAction) in
                        let qrCode = QR(context: PersistentService.context)
                        qrCode.string = object.stringValue
                        PersistentService.saveContext()
                    }))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }

}
