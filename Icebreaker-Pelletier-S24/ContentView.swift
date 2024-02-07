//
//  ContentView.swift
//  Icebreaker-Pelletier-S24
//
//  Created by Justin Pelletier on 2/6/24.
//

import SwiftUI

struct ContentView: View {
	
	@State var firstName: String = ""
	@State var lastName: String = ""
	@State var preferredName: String = ""
	@State var answer: String = ""
	@State var question: String = ""

    var body: some View {
			
        VStack {
					Text("Icebreaker")
						.font(.system(size: 40))
						.bold()
					Text("Built with SwiftUI")
					TextField("First Name", text: $firstName)
					TextField("Last Name", text: $lastName)
					TextField("Preferred Name", text: $preferredName)
					Button(action: {
						setRandomQuestion() }) {
						Text("Get a new random question")
					}
					Text(question)
					TextField("Answer", text: $answer)
					Button(action: {
						writeStudentToFirebase() }) {
						Text("Submit")
						}
        }
				.font(.largeTitle)
				.multilineTextAlignment(.center)
        .padding()
				.autocorrectionDisabled()
    }
	
	func setRandomQuestion() {
		print("first name: \(firstName)")
	}
	
	func writeStudentToFirebase() {
		print("\(firstName) (\(preferredName)) \(lastName)")
		print("\(answer)")
	}
}

#Preview {
    ContentView()
}
