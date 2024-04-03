//
//  ContentView.swift
//  DetectScrolling
//
//  Created by Eng.Omar Elsayed on 27/03/2024.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var vm = CameraViewModel()
    var frameDimensions: (width: CGFloat, height: CGFloat) {
        let screenRect = UIScreen.main.bounds
        let tenPrecentFromWidth = (10.0/100.0) * screenRect.width
        let twentyPrecentFromHeight = (10.0/100.0) * screenRect.height
        
        return (screenRect.width - tenPrecentFromWidth, screenRect.height - twentyPrecentFromHeight)
    }
    var body: some View {
        ZStack {
            Color.black
            ZStack(alignment: .bottom) {
                CameraPreview()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(width: frameDimensions.width, height: frameDimensions.height)
                
                RecordButtonView()
                    .padding(.vertical)
            }
        }
        .ignoresSafeArea()
    }
}

struct RecordButtonView: View {
    var body: some View {
        Circle()
            .stroke(lineWidth: 3)
            .frame(width: 70)
            .foregroundStyle(.white)
            .overlay(alignment: .center) {
                Circle()
                    .frame(width: 60)
                    .foregroundStyle(.red)
            }
    }
}


#Preview {
    ContentView()
}
