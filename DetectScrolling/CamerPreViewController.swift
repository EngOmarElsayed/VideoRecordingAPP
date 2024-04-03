//
//  CamerPreViewController.swift
//  DetectScrolling
//
//  Created by Eng.Omar Elsayed on 03/04/2024.
//

import AVFoundation
import SwiftUI

class CameraPreViewController: UIViewController {
    private var previewLayer = AVCaptureVideoPreviewLayer()
    var screenRect = UIScreen.main.bounds
    let session: AVCaptureSession = AVCaptureManger.shared.captureSession
    
    override func viewDidLoad() {
        setupPreview()
        self.view.layer.addSublayer(self.previewLayer)
    }
}

//MARK: -  SetUp & Reflecting Orientation Change
extension CameraPreViewController {
    func setupPreview() {
        previewLayer.session = session
        previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.connection?.videoRotationAngle = 90
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        screenRect = UIScreen.main.bounds
//        previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
//        
//        switch UIDevice.current.orientation {
//        case .portrait:
//            self.previewLayer.connection?.videoRotationAngle = PreviewLayerRotationAngle.portrait
//            
//        case .landscapeLeft:
//            self.previewLayer.connection?.videoRotationAngle = PreviewLayerRotationAngle.landscapeLeft
//            
//        case .landscapeRight:
//            self.previewLayer.connection?.videoRotationAngle = PreviewLayerRotationAngle.landscapeRight
//            
//        default:
//            self.previewLayer.connection?.videoRotationAngle = PreviewLayerRotationAngle.portrait
//        }
//    }
}

//MARK: - videoRotationAngle Values
extension CameraPreViewController {
    private enum PreviewLayerRotationAngle {
        static let portrait: CGFloat = 90
        static let landscapeLeft: CGFloat = 0
        static let landscapeRight: CGFloat = 180
    }
}

//MARK: - CameraPreview UIViewControllerRepresentable
struct CameraPreview: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    func makeUIViewController(context: Context) -> some UIViewController {
        return CameraPreViewController()
    }
}
