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
						if(answer != "") {
							writeStudent()
						}
						resetForm()
					}) {
						Text("Submit")
							.font(.system(size: 38))
						}
					.padding(30)
        }
					.font(.largeTitle)
					.multilineTextAlignment(.center)
					.padding()
					.autocorrectionDisabled()
					.onAppear() {
						log(message: "Attempting to fetch questions from database...")
						fetchQuestions()
					}
    }
	
	func log(message: String) {
		let date = Date().formatted(date: .omitted, time: .complete)
		print("\(date):  \(message)")
	}

	func fetchQuestions() {
			db.collection("questions").getDocuments() { (QuerySnapshot, err) in
				if let err = err {
					log(message: "Failed to fetch questions from database: \(err)")
				} else {
					for document in QuerySnapshot!.documents {
						if let question = Question(
							id: document.documentID,
							data: document.data()) {
							self.questions.append(question)
						}
					}
					log(message: "Successfully fetched \(QuerySnapshot!.count) questions from database")
				}
				
			}
	}
	
	func setRandomQuestion() {
		log(message: "Generated random question")
		let newQuestion = questions.randomElement()?.text
		self.question = newQuestion!
	}
	
	func writeStudent() {
		log(message: "Submission Attempt: name=\(firstName) preferredName=\(preferredName) lastName=\(lastName) question=\(question) answer=\(answer)")
		
		let data = ["first-name": firstName,
								"last-name": lastName,
								"perf-name": preferredName,
								"question": question,
								"answer": answer] as [String: Any]
		
		var ref: DocumentReference? = nil
		ref = db.collection("students").addDocument(data: data) { err in
			if let err = err {
				log(message: "Submission failed to update database: \(err)")
			} else {
				log(message: "Submission successfully pushed to database. ReferenceID: \(ref!.documentID)")
			}
		}
	}
	
	func resetForm() {
		firstName = ""
		lastName = ""
		preferredName = ""
		question = ""
		answer = ""
	}
}

#Preview {
    ContentView()
}

