//
//  EditQuestionsView.swift
//  CircleOfTruth
//
//  Created by Grant Watson on 6/14/22.
//

import SwiftUI

struct EditQuestionsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var vm: HomeVM
    
    @State private var showAddScreen: Bool = false
    @State private var newQuestionText: String = ""

    @State private var editText: String = ""
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color.theme.background2.ignoresSafeArea()
            
            VStack {
                toolbarView
                    .padding([.leading, .bottom, .trailing])
                
                if !vm.questions.isEmpty {
                    List {
                        ForEach(vm.questions, id: \.self) { question in
                            Text(question)
                                .listRowBackground(Color.theme.listBackground)
                        }
                        .onDelete(perform: vm.deleteQuestions)
                    }
                    .background(Color.theme.listBackground)
                    .listStyle(.plain)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                } else {
                    Spacer()
                    VStack(spacing: 20) {
                        Text("No questions are assigned to this category.")
                            .font(.title)
                        Text("Press the button below to add questions.")
                            .font(.title3)
                    }
                    .multilineTextAlignment(.center)
                    .padding()
                    Spacer()
                }
                
                if showAddScreen {
                    addQuestionScreen
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
                } else {
                    ButtonView(buttonText: "Add Question", buttonColor: Color.theme.accent, height: 50, font: .headline)
                        .padding()
                        .onTapGesture {
                            withAnimation {
                                showAddScreen.toggle()
                            }
                        }
                        .offset(y: -10)
                        .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .top)))
                }
                
            }
            .onAppear {
                vm.loadQuestions()
            }
        }
        .foregroundColor(.white)
        .background(Color.theme.background2)
    }
}

struct EditQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        EditQuestionsView()
            .environmentObject(dev.homeVM)
    }
}

extension EditQuestionsView {
    
    private var addQuestionScreen: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.listBackground)
            
            Image(systemName: "xmark")
                .font(.body)
                .foregroundColor(Color.white.opacity(0.7))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .onTapGesture {
                    withAnimation {
                        showAddScreen.toggle()
                    }
                }

            
            VStack {
                Text("Add Question")
                    .font(.headline)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(Color.white)
                    
                    TextField("Add new question", text: $newQuestionText)
                        .frame(height: 40)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.horizontal, 6)
                        .cornerRadius(16)
                        .foregroundColor(Color.theme.background)
                }
                
                ButtonView(buttonText: "Add", buttonColor: newQuestionText.isEmpty ? Color.gray : Color.theme.accent, height: 35, font: .headline)
                    .onTapGesture {
                        let question = newQuestionText
                        vm.questions.append(question)
                        vm.saveQuestions()
                        newQuestionText = ""
                        withAnimation {
                            showAddScreen.toggle()
                        }
                    }
            }
            .padding()
        }
        .frame(height: 150)
    }
    
    private var toolbarView: some View {
        ZStack {
            if !vm.questions.isEmpty {
                EditButton()
                    .foregroundColor(Color.white.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Text("Questions")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Image(systemName: "checkmark")
                .font(.title2)
                .foregroundColor(Color.white.opacity(0.7))
                .onTapGesture {
                    vm.saveQuestions()
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
        .padding(.top)
    }
}
