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
