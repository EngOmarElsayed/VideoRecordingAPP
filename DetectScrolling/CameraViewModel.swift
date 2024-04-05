//
//  CameraViewModel.swift
//  DetectScrolling
//
//  Created by Eng.Omar Elsayed on 03/04/2024.
//

import Foundation

class CameraViewModel: ObservableObject {
    @Published var isRecoredButtonPressed: Bool = false
    private let captureManger = AVCaptureManger.shared
}

extension CameraViewModel {
    func requestAccess() async {
        await captureManger.requestAccess()
    }
    
    func recordButtonAction() {
        if isRecoredButtonPressed {
            stopVideoRecording()
        } else {
            startVideoRecording()
        }
    }
    
    private func startVideoRecording() {
        captureManger.startRecording()
        isRecoredButtonPressed = true
    }
    
   private func stopVideoRecording() {
        captureManger.stopRecording()
        isRecoredButtonPressed = false
    }
}
