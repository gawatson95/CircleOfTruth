//
//  PromptView.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 6/6/22.
//

import SwiftUI

struct PromptView: View {
    
    @EnvironmentObject private var vm: HomeVM
    
    let prompt: String
    var numberOfPlayers: String

    var body: some View {
        Group {
            if vm.questions.isEmpty {
                Text("GAME OVER")
            } else if numberOfPlayers == "2 Players" {
                Text("Ask the other person:")
            } else {
                Text("The person " + prompt + ":")
            }
        }
        .foregroundColor(.white)
        .font(.largeTitle)
        .multilineTextAlignment(.center)
        .frame(maxHeight: 70)
        .minimumScaleFactor(0.01)
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.opacity(0.6)
            
            PromptView(prompt: "to make eye contact with you", numberOfPlayers: "More than 2 Players")
        }
        .environmentObject(dev.homeVM)
    }
}
