//
//  ContentView.swift
//  project-2-guess-the-flag
//
//  Created by Luca Capriati on 2022/08/05.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var playerScore = 0
    @State private var question = 1
    @State private var questionsAlert = false
    
    private var numberOfQuestions = 8
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 600)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                Text("Question \(question) of \(numberOfQuestions)")
                    .foregroundStyle(.primary)
                    .font(.title.bold())
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
//                Text("Score: \(playerScore)")
//                    .foregroundColor(.white)
//                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Question \(question) of \(numberOfQuestions)")
        }
        .alert("You scored: \(playerScore)", isPresented: $questionsAlert) {
            Button("no") {
                
            }
            Button("YES", action: reset)
        } message: {
            Text("Do you want to play again?")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            playerScore += 1
        } else {
            scoreTitle = """
                            Wrong!
                            That's the flag of \(countries[number])
                        """
        }
    
        showingScore = true
    }
    
    func askQuestion() {
        if question < numberOfQuestions {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            question += 1
        } else {
            questionsAlert = true
        }
    }
    
    func reset() {
        question = 0
        playerScore = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
