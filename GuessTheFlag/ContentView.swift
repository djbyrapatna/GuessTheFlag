//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Dhruva Jothik Byrapatna on 5/19/25.
//

import SwiftUI

struct ContentView: View {
    let maxQuestions = 8
    @State private var showingScore = false
    @State private var score = 0
    @State private var numQuestions = 0
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var gameOver = false
    
    var body: some View {
        
        
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.06), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)

                VStack(spacing:15){
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            
                    }
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius:5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }.padding()
            
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("Play Again", action: reset)
        } message: {
            Text("Your score is \(score) / \(maxQuestions)")
        }
    }
    func flagTapped(_ number: Int) {
        
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score+=1
        } else {
            scoreTitle = "Wrong! That was the flag of \(countries[number])"
        }
        
        numQuestions += 1
        
        
        if numQuestions==maxQuestions{
            gameOver=true
        } else{
            showingScore = true
            
            
        }

        
        
    }
    
    
    
    func askQuestion() {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset(){
        numQuestions = 0
        score = 0
        gameOver = false
        askQuestion()
        
    }
}


#Preview {
    ContentView()
}
