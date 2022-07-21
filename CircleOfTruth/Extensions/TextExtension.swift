//
//  TextExtension.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 5/27/22.
//

import Foundation
import SwiftUI

struct CustomText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.title2.bold())
            .frame(maxWidth: .infinity)
            .padding()
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

extension View {
    func buttonText() -> some View {
        modifier(CustomText())
    }
}
