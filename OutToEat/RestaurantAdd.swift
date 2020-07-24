//
//  RestaurantAdd.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/6/20
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct RestaurantAdd: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var restaurants: Restaurants
    
    @State private var name = ""
    @State private var type = ""
    @State private var notes = ""
    
    @State private var showEmptyNameWarning = false
    @State private var showDuplicateNameWarning = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Type (optional)", text: $type)
                TextField("Notes (optional)", text: $notes)
            }
            .navigationBarTitle("Add New Restaurant")
            .navigationBarItems(
                leading:
                    Button("Close") {
                        self.presentationMode.wrappedValue.dismiss()
                    }.font(.title),
                trailing:
                    Button("Save") {
                        if !self.name.isEmpty
                        {
                            if(self.findDuplicate(restaurant: self.name) == false) { // determine if the restaurant name is already being used
                                let item = Restaurant(name: self.name, type: self.type, notes: self.notes)
                                
                                self.restaurants.items.append(item)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            else { // show a warning that restaurant name already exists
                                self.showDuplicateNameWarning = true // attached to NavigationView
                            }
                            
                        }
                        else { // display warning that restaurant needs a name
                            self.showEmptyNameWarning = true // attached to this button
                        }
                    }
                    .font(.title)
                    .alert(isPresented: $showEmptyNameWarning) {
                        Alert(title: Text("Restaurant Must Have a Name"), dismissButton: .default(Text("Oh, right!")))
                    }
                    
            ) // end navigationBarItems
        } // end NavigationView
        .alert(isPresented: $showDuplicateNameWarning) { // swiftui doesn't let you attach multiple alerts to same object so i have to stick the other alert somewhere else
            Alert(title: Text("Restaurant With That Name Already Exists"), dismissButton: .default(Text("Oh, right!")))
        }
    } // end body
    
    // return true if a restaurant of given name already exists
    func findDuplicate(restaurant: String) -> Bool? {
        for i in restaurants.items {
            if(i.name == restaurant) {
                return true // if a duplicate name is found
            }
        }
        return false // if a duplicate name is not found
    }
}

struct RestaurantAdd_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantAdd(restaurants: Restaurants())
    }
}
