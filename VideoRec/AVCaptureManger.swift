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

import Foundation
import AVFoundation
import Photos

class AVCaptureManger: NSObject {
    static let shared = AVCaptureManger()
    var captureSession = AVCaptureSession()
    
    private let videoOutput = AVCaptureMovieFileOutput()
    private let sessionThread = DispatchQueue(label: "SessionQue")
    private var isAuthorizedToAccessLibrary: Bool = false
    
    override init() {
        super.init()
        configure()
    }
}

//MARK: -  RequesteAccess
extension AVCaptureManger {
    func requestAccess() async {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .notDetermined {
            _ = await AVCaptureDevice.requestAccess(for: .video)
            configure()
        } else if status == .authorized {
            configure()
        }
        isAuthorizedToAccessLibrary = await PHPhotoLibrary.requestAuthorization(for: .addOnly) == .authorized
    }
}

//MARK: -  AVCapture methods
extension AVCaptureManger {
    func startRecording() {
        let outputFileName = NSUUID().uuidString
        let outputFilePath = (NSTemporaryDirectory() as NSString).appendingPathComponent((outputFileName as NSString).appendingPathExtension("mov")!)
        videoOutput.startRecording(to: URL(fileURLWithPath: outputFilePath), recordingDelegate: self)
    }
    
    func stopRecording() {
        videoOutput.stopRecording()
    }
}

//MARK: -  Confirming to AVCaptureFileOutputRecordingDelegate
extension AVCaptureManger: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if isAuthorizedToAccessLibrary {
            PHPhotoLibrary.shared().performChanges {
                let options = PHAssetResourceCreationOptions()
                options.shouldMoveFile = true
                let creationRequest = PHAssetCreationRequest.forAsset()
                creationRequest.addResource(with: .video, fileURL: outputFileURL, options: options)
            } completionHandler: { [weak self] _, _  in
                guard let self else { return }
                self.cleanFilePath(outputFileURL)
            }
        } else {
            cleanFilePath(outputFileURL)
        }
    }
}

//MARK: -  Private Methods
extension AVCaptureManger {
    private func configure() {
        sessionThread.async { [weak self] in
            guard let self else { return }
            captureSession.beginConfiguration()
            
            guard let audioDevice = AVCaptureDevice.default(for: .audio) else { return }
            guard let audioDeviceInput = try? AVCaptureDeviceInput(device: audioDevice) else { return }
            guard let videoDevice = AVCaptureDevice.default(for: .video) else { return }
            guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
            
            guard captureSession.canAddInput(audioDeviceInput) else { return }
            guard captureSession.canAddInput(videoDeviceInput) else { return }
            captureSession.addInput(audioDeviceInput)
            captureSession.addInput(videoDeviceInput)
            
            guard captureSession.canAddOutput(videoOutput) else { return }
            captureSession.sessionPreset = .high
            captureSession.addOutput(videoOutput)
            
            captureSession.commitConfiguration()
            captureSession.startRunning()
        }
    }
    
    private func cleanFilePath(_ fileUrl: URL) {
        let path = fileUrl.path
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                print("Could not remove file at url: \(fileUrl)")
            }
        }
    }
}
