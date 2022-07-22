//
//  HomeView.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 5/27/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeVM
    
    @State private var category: String = ""
    @State private var numberOfPlayers: String = ""
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack {
                ZStack {
                    MenuButtonView()
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .onTapGesture {
                            vm.showSetup()
                        }
                    
                    if vm.timeRemaining > 0 {
                        Text("\(vm.timeRemaining, specifier: "%.2f")")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .scaleEffect(vm.scaleAmount, anchor: .center)
                    } else {
                        Text("TIME!")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color.red)
                            .scaleEffect(vm.scaleAmount, anchor: .center)
                    }
                }
                .frame(maxHeight: 70)
                
                DividerView()
                    .padding(.vertical, 3)
                    .foregroundColor(.white.opacity(0.07))
          
                PromptView(prompt: vm.prompt, numberOfPlayers: numberOfPlayers)
                    .padding()
                
                QuestionView(question: vm.question)
                
                Spacer()
                
                if vm.timeRemaining < 0.01 || vm.dodgeSelected || vm.truthSelected {
                    ButtonView(buttonText: "Next Round", buttonColor: Color.theme.accent)
                        .onTapGesture {
                            vm.removeQuestion()
                            vm.resetRound()
                        }
                        .transition(.slide)
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                }
                responseButtons
            }
            .onReceive(vm.timer) { _ in
                vm.activeProgress()
            }
            .sheet(isPresented: $vm.setupBool) {
                GameSetupView(numberOfPlayers: $numberOfPlayers)
            }
            .onAppear() {
                ReviewHandler.requestReview()
                vm.stopTimer()
                vm.showSetup()
            }
        }
    }
}

extension HomeView {
    private var responseButtons: some View {
        HStack {
            ButtonView(buttonText: "Dodge", buttonColor: vm.timeRemaining < 0.01 ? .red : vm.dodgeColor)
                .allowsHitTesting(vm.truthSelected || !vm.showQuestion ? false : true)
                .onTapGesture {
                    vm.stopTimer()
                    withAnimation {
                        vm.dodgeSelected = true
                        vm.truthSelected = false
                    }
                    vm.buttonColor()
                }
            
            ButtonView(buttonText: "Truth", buttonColor: vm.timeRemaining < 0.01 ? .gray : vm.truthColor)
                .allowsHitTesting(vm.dodgeSelected || !vm.showQuestion ? false : true)
                .onTapGesture {
                    vm.stopTimer()
                    withAnimation {
                        vm.truthSelected = true
                        vm.dodgeSelected = false
                    }
                    vm.buttonColor()
                }
        }
        .padding(.horizontal)
        .padding(.bottom, 5)
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
            .environmentObject(dev.homeVM)
    }
}
