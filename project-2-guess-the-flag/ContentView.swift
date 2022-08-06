//
//  ContentView.swift
//  project-2-guess-the-flag
//
//  Created by Luca Capriati on 2022/08/05.
//

import SwiftUI

struct ContentView: View {
    
    var countries = ["Estonia", "France", "Germany",
                     "Ireland", "Italy", "Nigeria",
                     "Poland", "Russia", "Spain",
                     "Uk", "Us"]
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                }
                
                ForEach(0..<3) {number in
                    Button {
                        // Flag was tapped
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
