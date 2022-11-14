//
//  HomeVM.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 6/2/22.
//

import Foundation
import SwiftUI


class HomeVM: ObservableObject {
    
    @Published var timer = Timer.publish(every: 0.07, on: .main, in: .common).autoconnect()
    @Published var timeRemaining = 20.0
    
    @Published var scaleAmount = 1.0
    @Published var progressCircle = 1.0
    @Published var circleColor: Color = .green
    
    @Published var isTimerRunning: Bool = false
    @Published var truthSelected: Bool = false
    @Published var dodgeSelected: Bool = false
    @Published var dodgeColor: Color = .red
    @Published var truthColor: Color = .green
    
    @Published var showQuestion: Bool = false
    @Published var setupBool: Bool = false
    
    let categories: [String] = ["Friends", "Custom"]
    @Published var category: String = ""
    
    @Published var question: String = ""
    @Published var questions: [String] = []
    
    var prompts: [String] = []
    @Published var prompt: String = ""
    
    let gameData = Bundle.main.decode([GameData].self, from: "gameData.json")

    let defaults = UserDefaults.standard
    
    init() {
        loadQuestions()
        timer = timer.self
        stopTimer()
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
        isTimerRunning = false
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.07, on: .main, in: .common).autoconnect()
        isTimerRunning = true
    }
    
    func activeProgress() {
        if isTimerRunning {
            if timeRemaining > 0 {
                timeRemaining -= 0.07
            }
            
            if timeRemaining < 6 && timeRemaining > 0 {
                scaleAmount += 0.01
            }
            withAnimation(.linear(duration: 0.07)) {
                if progressCircle > 0 {
                    progressCircle -= 0.0035
                }
            }
        }
    }
    
    func resetRound() {
        dodgeColor = .gray
        truthColor = .gray
        timeRemaining = 20.0
        progressCircle = 1
        scaleAmount = 1
        showQuestion = false
        withAnimation {
            dodgeSelected = false
            truthSelected = false
        }
        isTimerRunning = false
        prompt = prompts.randomElement() ?? ""
        question = questions.first ?? "Game Over"
    }
    
    func removeQuestion() {
        if questions.isEmpty == false {
            questions.remove(at: 0)
        }
    }
    
    func buttonColor() {
        if truthSelected == true || !showQuestion {
            dodgeColor = .gray
            truthColor = .green
        } else if dodgeSelected == true || !showQuestion {
            dodgeColor = .red
            truthColor = .gray
        } else if timeRemaining < 0.01 {
            dodgeColor = .red
        }
    }
    
    func updateCategory() {
        prompts = gameData.first(where: { $0.category == "friends" } )?.prompts ?? []
    }
    
    func shuffle() {
        questions = questions.shuffled()
        prompts = prompts.shuffled()
    }
    
    func showSetup() {
        setupBool.toggle()
    }
    
    func deleteQuestions(at offsets: IndexSet) {
        questions.remove(atOffsets: offsets)
        saveQuestions()
    }
    
    func saveQuestions() {
        let userQuestions = questions
        
        if category == "Friends" {
            defaults.set(userQuestions, forKey: "userFriendQuestions")
        } else if category == "Custom" {
            defaults.set(userQuestions, forKey: "userCustomQuestions")
        }
    }
    
    func loadQuestions() {
        if category == "Friends" {
            if let savedQuestions = defaults.object(forKey: "userFriendQuestions") as? [String] {
                questions = savedQuestions
            } else {
                questions = gameData.first(where: { $0.category == "friends"})!.questions
            }
        } else if category == "Custom" {
            if let savedQuestions = defaults.object(forKey: "userCustomQuestions") as? [String] {
                questions = savedQuestions
            } else {
                questions = []
            }
        }
    }
}
