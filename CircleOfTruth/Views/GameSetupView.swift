//
//  GameSetupView.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 5/27/22.
//

import SwiftUI

struct GameSetupView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var vm: HomeVM
    
    @Binding var numberOfPlayers: String
    @State private var editQuestions: Bool = false
    @State private var showNoQuestionAlert: Bool = false
    @State private var showHowToPlayAlert: Bool = false
    @State private var categorySelected: String?
    @State private var playersSelected: String?
    
    var finishedSetup: Bool {
        vm.categories.contains(vm.category) && players.contains(numberOfPlayers)
    }
    
    let players: [String] = [
        "2 Players", "More than 2 Players"
    ]
    
    var body: some View {
        ZStack {
            Color.theme.background2.ignoresSafeArea()
            
            VStack(spacing: 20) {
                ZStack {
                    Image(systemName: "xmark")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .allowsHitTesting(finishedSetup)
                        .onTapGesture {
                            dismiss()
                            vm.resetRound()
                            
                        }
                    Text("Settings")
                        .font(.title)
                    
                    Image(systemName: "pencil")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .allowsHitTesting(vm.categories.contains(vm.category))
                        .onTapGesture {
                            editQuestions.toggle()
                        }
                }
                .foregroundColor(.white)
                
                DividerView()
                    .foregroundColor(.white.opacity(0.1))
                    
                VStack(spacing: 30) {
                    VStack {
                        Text("Category:")
                            .font(.title3)
                            .frame(alignment: .leading)
                        
                        ForEach(vm.categories, id: \.self) { category in
                            Button {
                                vm.category = category
                                categorySelected = category
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(maxHeight: 50)
                                        .foregroundColor(categorySelected == category ? Color.theme.accent : Color.theme.listBackground)
                                    Text(category)
                                        .bold()
                                }
                            }
                            .onChange(of: vm.category) { _ in
                                vm.updateCategory()
                                vm.loadQuestions()
                            }
                        }
                    }
                    
                    VStack {
                        Text("How many players?")
                            .font(.title3)
                        
                        ForEach(players, id: \.self) { player in
                            Button {
                                self.numberOfPlayers = player
                                playersSelected = player
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(maxHeight: 50)
                                        .foregroundColor(playersSelected == player ? Color.theme.accent : Color.theme.listBackground)
                                    Text(player)
                                        .bold()
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
                HStack(spacing: 5) {
                    Text("First Time Playing?")
                        .font(.headline).bold()
                    Text("How to Play")
                        .font(.callout)
                }
                .onTapGesture {
                    showHowToPlayAlert.toggle()
                }
                
                ButtonView(buttonText: "Start", buttonColor: finishedSetup ? Color.theme.accent : .gray)
                    .onTapGesture {
                        vm.loadQuestions()
                        vm.shuffle()
                        vm.resetRound()
                        if vm.questions.isEmpty {
                            showNoQuestionAlert = true
                        } else {
                            dismiss()
                        }
                    }
                    .allowsHitTesting(finishedSetup)
            }
            .padding()
            .interactiveDismissDisabled(!finishedSetup)
        }
        .foregroundColor(Color.white.opacity(0.8))
        .sheet(isPresented: $editQuestions) {
            EditQuestionsView()
        }
        .alert("No Questions", isPresented: $showNoQuestionAlert) {
            
        } message: {
            Text("It looks like the \(vm.category) category doesn't have questions. Tap the pencil in the top right corner to add some.")
        }
        .alert("How to Play", isPresented: $showHowToPlayAlert) {
            
        } message: {
            Text("""
                Here is your chance to ask your friends the hottest burning questions you probably (haven't) had, but didn't know how to ask them. It's simple:
                
                1. Select the category & the number of players.
                
                2. Follow the prompt at the top of the screen then press the Ready button to show the question. The other person has 20 seconds to answer the question truthfully or dodge the question.
                
                3. That person then gets to ask the next question.
                
                You can edit each question set to make unique sets that are all your own. Use the Custom category to create a set of questions that is entirely yours.
                
                Have fun & play responsibly!
                """)
            .multilineTextAlignment(.center)
        }
    }
}

struct GameSetupView_Previews: PreviewProvider {
    static var previews: some View {
        GameSetupView(numberOfPlayers: .constant("More than 2"))
            .environmentObject(dev.homeVM)
    }
}
