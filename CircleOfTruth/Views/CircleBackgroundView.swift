//
//  CircleBackgroundView.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 6/1/22.
//

import Combine
import SwiftUI

struct CircleBackgroundView: View {
    
    @EnvironmentObject private var vm: HomeVM

    var progressColor: Color {
        withAnimation {
            if vm.timeRemaining > 11 {
                return Color.progress.greenProgress
            } else if vm.timeRemaining > 6 {
                return Color.progress.orangeProgress
            } else {
                return Color.progress.redProgress
            }
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
            Circle()
                .fill(vm.questions.isEmpty ? Color.gray.opacity(0.4) : progressColor.opacity(0.4))
            Circle()
                .strokeBorder(lineWidth: 20)
                .foregroundColor(vm.questions.isEmpty ? Color.gray.opacity(0.2) : progressColor.opacity(0.2))
            Circle()
                .trim(from: 0.0, to: min(CGFloat(vm.progressCircle), 1.0))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(vm.questions.isEmpty ? Color.gray : progressColor)
                .rotationEffect(Angle(degrees: -90))
                .padding(10)
        }
        .padding(5)
        .frame(minWidth: 375, minHeight: 375)
        .aspectRatio(contentMode: .fit)
        .onAppear() {
            withAnimation(.linear(duration: 0.7)) {
                vm.activeProgress()
            }
       }
    }
}

struct CircleBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        CircleBackgroundView()
            .environmentObject(dev.homeVM)
    }
}
