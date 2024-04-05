//
//  FrameHandler.swift
//  DetectScrolling
//
//  Created by Eng.Omar Elsayed on 02/04/2024.
//

import Foundation
import AVFoundation

class AVCaptureManger: NSObject {
    static let shared = AVCaptureManger()
    var captureSession = AVCaptureSession()
    
    private let videoOutput = AVCaptureMovieFileOutput()
    private let sessionThread = DispatchQueue(label: "SessionQue")
    
    override init() {
        super.init()
        if isAuthorized {
            configure()
        }
    }
    
    private var isAuthorized: Bool {
        get {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            
            var isAuthorized = status == .authorized
            
            if status == .notDetermined {
                AVCaptureDevice.requestAccess(for: .video) { result in
                    isAuthorized = result
                }
            }
            
            return isAuthorized
        }
    }
    
}

//MARK: -  AVCapture methods
extension AVCaptureManger {
    func configure() {
        sessionThread.async { [weak self] in
            guard let self else { return }
            captureSession.beginConfiguration()
            
            guard let videoDevice = AVCaptureDevice.default(for: .video) else { return }
            guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
            
            guard captureSession.canAddInput(videoDeviceInput) else { return }
            captureSession.addInput(videoDeviceInput)
            
            guard captureSession.canAddOutput(videoOutput) else { return }
            captureSession.sessionPreset = .medium
            captureSession.addOutput(videoOutput)
            
            captureSession.commitConfiguration()
            captureSession.startRunning()
        }
    }
    
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
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("Started Recording")
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("Video URL: \(outputFileURL)")
        cleanFilePath(outputFileURL)
    }
}

//MARK: -  Private Methods
extension AVCaptureManger {
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
