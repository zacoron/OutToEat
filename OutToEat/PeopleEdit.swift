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
    var person: Person

    @State var name:String = ""
    @State var notes = ""
    
    @Environment(\.presentationMode) var presentationMode
    @State var showScroll = false // keep track of whether we want to jump to the restaurant scroll view
    
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
            
            Button("Delete") { // TODO: go back to main people screen after deleting
                if(self.people.items.firstIndex(of: self.person) != nil) { // make sure there is actually something there to delete before attempting to do so
                    self.people.removeAtIndex(index: self.people.items.firstIndex(of: self.person)!)
                }
                // self.presentationMode.wrappedValue.dismiss()
                self.showScroll = true
            }
            .padding(.bottom, 50)
            .font(.title)
            // .navigate(to: RestaurantScroll(), when: $showScroll)
            // .navigationBarHidden(true)
            // .navigationBarBackButtonHidden(true)
            
            
            NavigationLink(destination: RestaurantScroll(), isActive: $showScroll) {
                EmptyView()
            }
            
        } // end VStack
        .navigationBarTitle("Editing: \(person.name)")
        .navigationBarItems(
            trailing:
                Button("Save") { // TODO: don't want to overwrite notes sooo figure something out for that
                    // this checks each box for empty values to determine whether to update or not
                    if !self.name.isEmpty {
                        self.people.setName(newName: self.name, index: self.people.items.firstIndex(of: self.person)!)
                    }
                    if !self.notes.isEmpty {
                        self.people.setNotes(newNotes: self.notes, index: self.people.items.firstIndex(of: self.person)!)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.title)
        ) // end navigationBarItems
    } // end body
}

struct PeopleEdit_Previews: PreviewProvider {
    static var previews: some View {
        PeopleEdit(people: People(), person: Person(name: "", notes: ""))
    }
}
