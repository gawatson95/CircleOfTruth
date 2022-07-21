//
//  ButtonView.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 5/27/22.
//

import SwiftUI

struct ButtonView: View {
    let buttonText: String
    var buttonColor: Color = .green
    var height: CGFloat = 55
    var font: Font = .title2.bold()
    
    var body: some View {
        Text(buttonText)
            .foregroundColor(.white)
            .font(font)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(buttonColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(buttonText: "TRUTH", buttonColor: Color.green)
    }
}
