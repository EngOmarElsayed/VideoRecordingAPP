//
//  FrameHandler.swift
//  DetectScrolling
//
//  Created by Eng.Omar Elsayed on 02/04/2024.
//

import Foundation
import AVFoundation

class AVCaptureManger {
    static let shared = AVCaptureManger()
    var captureSession = AVCaptureSession()
    private let sessionThread = DispatchQueue(label: "SessionQue")
    
    init() {
        if isAuthorized {
            configure()
        }
    }
    
    var isAuthorized: Bool {
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
    
    func configure() {
        sessionThread.async { [weak self] in
            guard let self else { return }
            captureSession.beginConfiguration()
            
            guard let videoDevice = AVCaptureDevice.default(for: .video) else { return }
            guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
            
            guard captureSession.canAddInput(videoDeviceInput) else { return }
            captureSession.addInput(videoDeviceInput)
            
            let videoOutput = AVCaptureMovieFileOutput()
            guard captureSession.canAddOutput(videoOutput) else { return }
            captureSession.sessionPreset = .medium
            captureSession.addOutput(videoOutput)
            
            captureSession.commitConfiguration()
            captureSession.startRunning()
        }
    }
    
}
