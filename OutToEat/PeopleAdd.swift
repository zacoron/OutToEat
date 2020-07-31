//
//  PeopleAdd.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/9/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct PeopleAdd: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var people: People
    
    @State private var name = ""
    @State private var notes = ""
    @State private var favorite = ""
    @State private var showEmptyNameWarning = false
    @State private var showDuplicateNameWarning = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Name", text: $name)
                    TextField("Notes (optional)", text: $notes)
                }
                .navigationBarTitle("Add New Person")
                .navigationBarItems(
                    leading:
                        Button("Close") {
                            self.presentationMode.wrappedValue.dismiss()
                        }.font(.title),
                    trailing:
                        Button("Save") { // TODO: (maybe) remove space from ends of name before adding it
                            if !self.name.isEmpty
                            {
                                if(self.findDuplicate(name: self.name) == false) { // if no people with that name already exist
                                    let item = Person(name: self.name, notes: self.notes)
                                    self.people.items.append(item)
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                else {
                                    self.showDuplicateNameWarning = true
                                }
                            }
                            else { // display a warning that name can't be empty
                                self.showEmptyNameWarning = true
                            }
                        }.font(.title)
                        .alert(isPresented: $showEmptyNameWarning) {
                            Alert(title: Text("Person Must Have a Name"), dismissButton: .default(Text("Oh, right!")))
                        }
                ) // end navigationBarItems
                .padding(.bottom, 20)
                
                // add a quick note at the bottom of the screen
                Text("Note: Restaurants can be added by selecting this person in the \"People\" tab").padding(50).foregroundColor(Color.gray)
            } // end VStack
            .alert(isPresented: $showDuplicateNameWarning) {
                Alert(title: Text("A Person With This Name Already Exists"), dismissButton: .default(Text("Oh, right!")))
            }
        } // end NavigationView
    } // end body
    
    // return true if a person of given name already exists
    func findDuplicate(name: String) -> Bool? {
        for i in people.items {
            if(i.name == name) {
                return true // if a duplicate name is found
            }
        }
        return false // if a duplicate name is not found
    }
}

struct PeopleAdd_Previews: PreviewProvider {
    static var previews: some View {
        PeopleAdd(people: People())
    }
}
