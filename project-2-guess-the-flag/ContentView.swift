//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Luca Capriati on 2022/08/22.
//
// Challanges:
// Project 2 - Challange 1: Add an @State property to store the user’s score, modify it when they get an answer right or wrong,
//  then display it in the alert and in the score label.
// Project 2 - Challange 2: When someone chooses the wrong flag, tell them their mistake in your alert message –
//  something like “Wrong! That’s the flag of France,” for example.
// Project 2 - Challange 3: Make the game show only 8 questions, at which point they see a final alert judging their score
//  and can restart the game.
// Project 2 - Bonus Challange: Removing repeats
// Project 4 - Challange 2: Go back to project 2 and replace the Image view used for flags with a new FlagImage() view
//  that renders one flag image using the specific set of modifiers we had.
// Project 6 - Challange 1: When you tap a flag, make it spin around 360 degrees on the Y axis.
// Project 6 - Challange 2: Make the other two buttons fade out to 25% opacity.
// Project 6 - Chalange 3: Add a third effect of your choosing to the two flags the user didn’t choose – maybe make them scale down?
//  Or flip in a different direction? Experiment!

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    // Project 2 - Bonus Challange
    @State private var countries = allCountries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    // Project 2 - Challange 1
    @State private var score = 0
    // Project 2 - Challange 3
    @State private var questionCounter = 1
    @State private var showingResults = false
    // Project 2 - Bonus Challange
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    // Project 6 - Challange 1
    @State private var selectedFlag = -1

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            // Project 4 - Challange 2
                            FlagImage(name: countries[number])
                                // Project 6 - Challange 1
                                .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .animation(.default, value: selectedFlag)
                                // Project 6 - Challange 2
                                .opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                                // Project 6 - Challange 3 (different style to choose from)
//                                .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                                .saturation(selectedFlag == -1 || selectedFlag == number ? 1 : 0)
                                .blur(radius: selectedFlag == -1 || selectedFlag == number ? 0 : 3)
                                
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        // Project 2 - Challange 3
        .alert("Game over!", isPresented: $showingResults) {
            Button("Start Again", action: newGame)
        } message: {
            Text("Your final score was \(score).")
        }
    }

    func flagTapped(_ number: Int) {
        // Project 6 - Challange 1
        selectedFlag = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            // Project 2 - Challange 1
            score += 1
        } else {
            // Project 2 - Challange 1
            let needsThe = ["UK", "US"]
            let theirAnswer = countries[number]
            
            if needsThe.contains(theirAnswer) {
                scoreTitle = "Wrong! That's the flag of the \(countries[number])."
            } else {
                scoreTitle = "Wrong! That's the flag of \(countries[number])."
            }
            // Project 2 - Challange 1
            if score > 0 {
                score -= 1
            }
        }
        
        // Project 2 - Challange 3
        if questionCounter == 8 {
            showingResults = true
        } else {
            showingScore = true
        }
    }

    func askQuestion() {
        // Project 2 - Bonus Challange
        countries.remove(at: correctAnswer)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        // Project 2 - Challange 3
        questionCounter += 1
        // Project 6 - Challange 1
        selectedFlag = -1
    }
    
    func newGame() {
        questionCounter = 0
        score = 0
        // Project 2 - Bonus Challange
        countries = Self.allCountries
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
