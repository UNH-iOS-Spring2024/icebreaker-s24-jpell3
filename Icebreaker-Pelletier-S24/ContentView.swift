//
//  ContentView.swift
//  Icebreaker-Pelletier-S24
//
//  Created by Justin Pelletier on 2/6/24.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {

	let db = Firestore.firestore()
	
	@State var firstName: String = ""
	@State var lastName: String = ""
	@State var preferredName: String = ""
	@State var answer: String = ""
	@State var question: String = ""
	
	@State var questions = [Question]()

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
						writeStudent() }) {
						Text("Submit")
						}
        }
					.font(.largeTitle)
					.multilineTextAlignment(.center)
					.padding()
					.autocorrectionDisabled()
					.onAppear() {
						fetchQuestions()
					}
    }
	
	func setRandomQuestion() {
		let newQuestion = questions.randomElement()?.text
		self.question = newQuestion!
	}
	
	func fetchQuestions() {
		var date = NSDate()
		print("\(date)")
			db.collection("questions").getDocuments() { (QuerySnapshot, err) in
				if let err = err {
					print("Error getting documents: \(err)")
				} else {
					for document in QuerySnapshot!.documents {
						if let question = Question(
							id: document.documentID,
							data: document.data()) {
							print("Question ID = \(question.id), text = \(question.text)")
							self.questions.append(question)
						}
					}
				}
				
			}
	}
	
	func writeStudent() {
		print("\(firstName) (\(preferredName)) \(lastName)")
		print("\(answer)")
	}
}

#Preview {
    ContentView()
}
