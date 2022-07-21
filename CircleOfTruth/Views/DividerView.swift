//
//  DividerView.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 6/13/22.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(height: 1)
            .padding(.horizontal)
    }
}

struct DividerView_Previews: PreviewProvider {
    static var previews: some View {
        DividerView()
    }
}
