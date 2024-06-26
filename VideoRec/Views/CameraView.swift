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

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var vm = CameraViewModel()
    @State private var zoomState = 1.0
    @State private var lastZoomState = 1.0
    @State private var showZoomValue = false
    private let screenRect = UIScreen.main.bounds
    
    var frameDimensions: (width: CGFloat, height: CGFloat) {
        let tenPrecentFromWidth = (10.0/100.0) * screenRect.width
        let twentyPrecentFromHeight = (10.0/100.0) * screenRect.height
        return (screenRect.width - tenPrecentFromWidth, screenRect.height - twentyPrecentFromHeight)
    }
    
    var magnificationGesture: some Gesture {
        MagnificationGesture()
            .onChanged { state in
                let delta = state/lastZoomState
                zoomState *= delta
                vm.zoomFor(zoomState)
                lastZoomState = state
                showZoomValue = true
            }
            .onEnded { _ in
                lastZoomState = 1.0
                showZoomValue = false
            }
    }
    
    var body: some View {
        ZStack {
            Color.black
            ZStack(alignment: .bottom) {
                CameraPreview()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(width: frameDimensions.width, height: frameDimensions.height)
                
                VStack(spacing: 10) {
                    if showZoomValue {
                        ZoomEffectValueLabelView(zoomEffectValue: $vm.zoomState)
                    }
                    RecordButtonView(isPressed: $vm.isRecoredButtonPressed) {
                        vm.recordButtonAction()
                    }
                }
            }
            .gesture(magnificationGesture)
        }
        .ignoresSafeArea()
        .task {
            await vm.requestAccess()
        }
    }
}

#Preview {
    ContentView()
}
