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
                        Button("Save") { // TODO: add warning when trying to save restaurant w/o name
                            if !self.name.isEmpty
                            {
                                let item = Person(name: self.name, notes: self.notes)
                                self.people.items.append(item)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }.font(.title)
                ) // end navigationBarItems
                .padding(.bottom, 20)
            
                Text("Restaurants can be added by selecting this person in the \"People\" tab")
                    .padding(50)
            } // end VStack
        } // end NavigationView
    } // end body
}

struct PeopleAdd_Previews: PreviewProvider {
    static var previews: some View {
        PeopleAdd(people: People())
    }
}
