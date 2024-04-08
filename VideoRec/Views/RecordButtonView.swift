//
//  RecordButtonView.swift
//  VideoRec
//
//  Created by Eng.Omar Elsayed on 08/04/2024.
//

import SwiftUI

struct RecordButtonView: View {
    @Binding var isPressed: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            RecordButtonLabel(isPressed: $isPressed)
                .padding(.vertical)
        }
    }
}

struct RecordButtonLabel: View {
    @Binding var isPressed: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 3)
            .frame(width: 70)
            .foregroundStyle(.white)
            .overlay(alignment: .center) {
                if isPressed {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.red)
                        .animation(.linear, value: isPressed)
                } else {
                    Circle()
                        .frame(width: 55)
                        .foregroundStyle(.red)
                        .animation(.linear, value: isPressed)
                }
            }
    }
}
