//
//  MenuButtonView.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 5/27/22.
//

import SwiftUI

struct MenuButtonView: View {
    var body: some View {
        VStack(spacing: 5) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 25, height: 3)
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 25, height: 3)
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 25, height: 3)
        }
        .foregroundColor(.white)
    }
}

struct MenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MenuButtonView()
    }
}
