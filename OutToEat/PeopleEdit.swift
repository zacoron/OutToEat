//
//  PeopleEdit.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/9/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

// TODO: change observed object to environment object
struct PeopleEdit: View {
    @ObservedObject var people: People
    @EnvironmentObject var restaurants: Restaurants
    var person: Person

    @State var name:String = ""
    @State var notes = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            
            Divider().padding(.top, 20)
            
            HStack {
                Text("Name:").font(.title)
                Spacer()
                TextField(person.name, text: $name).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            HStack {
                Text("Notes:").font(.title)
                Spacer()
                TextField(person.notes, text: $notes).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            Spacer()
            
            Button("Delete") {
                if(self.people.items.firstIndex(of: self.person) != nil) { // makes sure there is actually something there to delete before attempting to do so
                    self.people.removeAtIndex(index: self.personIndex()!)
                }
                
                // after deletion, go back to the main people page
                self.presentationMode.wrappedValue.dismiss()
                self.presentationMode.wrappedValue.dismiss()
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding(.bottom, 50)
            .font(.title)
            
        } // end VStack
        .navigationBarTitle("Editing: \(person.name)")
        .navigationBarItems(
            trailing:
                Button("Save") { // TODO: don't want to overwrite notes sooo figure something out for that
                    // this checks each box for empty values to determine whether to update or not
                    if !self.name.isEmpty {
                        self.people.setName(
                            newName: self.name,
                            index: self.personIndex()!)
                    }
                    if !self.notes.isEmpty {
                        self.people.setNotes(
                            newNotes: self.notes,
                            index: self.personIndex()!)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.title)
        ) // end navigationBarItems
    } // end body
    
    /**** INDEX RETRIEVAL FUNCTIONS ****/
    func personIndex() -> Int? {
        // print("Person Index: \(people.items.firstIndex(of: person) ?? -1)")
        return people.items.firstIndex(of: person) ?? -1
    }
}

struct PeopleEdit_Previews: PreviewProvider {
    static var previews: some View {
        PeopleEdit(people: People(), person: Person(name: "", notes: ""))
    }
}
