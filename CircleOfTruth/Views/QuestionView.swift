//
//  QuestionView.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 5/27/22.
//

import SwiftUI

struct QuestionView: View {
    
    @EnvironmentObject private var vm: HomeVM
    
    let question: String
    
    var textColor: Color {
        withAnimation {
            if vm.timeRemaining > 11 {
                return Color.theme.greenBackground
            } else if vm.timeRemaining > 6 {
                return Color.theme.orangeBackground
            } else {
                return Color.theme.redBackground
            }
        }
    }
    
    var body: some View {
        ZStack {
            CircleBackgroundView()
            
            if vm.showQuestion && vm.timeRemaining > 0.01 {
                Text(question)
                    .font(.largeTitle)
                    .foregroundColor(textColor)
                    .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height / 3.1)
                    .minimumScaleFactor(0.1)
                    .transition(.move(edge: .bottom))
            } else if vm.timeRemaining < 0.01 {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: UIScreen.main.bounds.width / 2.4)
            }
            else if vm.questions.isEmpty {
                ButtonView(buttonText: "Play Again", buttonColor: Color.theme.accent)
                    .frame(maxWidth: 200)
                    .onTapGesture {
                        vm.loadQuestions()
                        vm.showSetup()
                    }
            } else {
                ButtonView(buttonText: "READY?", buttonColor: Color.theme.accent)
                    .frame(maxWidth: 200)
                    .onTapGesture {
                        vm.dodgeColor = .gray
                        vm.truthColor = .gray
                        withAnimation {
                            vm.showQuestion.toggle()
                            vm.startTimer()
                        }
                    }
                    .transition(.move(edge: .leading))
            }
        }
        .multilineTextAlignment(.center)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(question: "Sample question to ask will go here. This is a pretty long question just to test how it will fit on the screen for when there is a longer question.")
            .environmentObject(dev.homeVM)
    }
}

extension Shape {
    func fill(using offset: CGSize) -> some View {
        if offset.width == 0 {
            return self.fill(.white)
        } else if offset.width < 0 {
            return self.fill(.red)
        } else {
            return self.fill(.green)
        }
    }
}
