//Copyright (c) 2024 Omar Elsayed
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

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
