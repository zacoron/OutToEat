//
//  AddFavorite.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/9/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct AddFavorite: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var restaurants: Restaurants
    @EnvironmentObject var people: People
    @State var person: Person
    
    @State private var selectedRestaurant = ""
    @State private var order = ""
    @State private var cost = ""
    @State private var notes = ""
    
    @State private var showEmptyNameWarning = false
    @State private var showDuplicateWarning = false
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $selectedRestaurant, label: Text("Restaurant")) {
                    ForEach(restaurants.items) { item in
                        Text(self.restaurants.items[self.restaurants.items.firstIndex(of: item)!].name)
                            .tag(self.restaurants.items[self.restaurants.items.firstIndex(of: item)!].name)
                    }
                } // end restaurant name Picker
                TextField("Order", text: $order)
                TextField("Cost", text: $cost).keyboardType(.decimalPad)
                TextField("Notes", text: $notes)
                
            }
            .navigationBarTitle("Add New Restaurant")
            .navigationBarItems(
                leading:
                    Button("Close") {
                        self.presentationMode.wrappedValue.dismiss()
                    }.font(.title),
                trailing:
                    Button("Save") { // TODO: add warning when trying to save restaurant w/o name
                        if !self.selectedRestaurant.isEmpty
                        {
                            if(self.findDuplicate(restaurant: self.selectedRestaurant) == false) {
                                let newFavorite = Favorite(
                                    personName: self.person.name,
                                    personUUID: self.person.id,
                                    restaurantName: self.selectedRestaurant,
                                    restaurantUUID: self.restaurants.items[self.searchRestaurantsForName(name: self.selectedRestaurant)!].id,
                                    orders: [Order(orderDetails: "", orderNotes: "", orderCost: 5.55)],
                                    cost: 5.55,
                                    notes: self.notes
                                )
                                
                                self.people.items[self.searchPeopleForUUID(id: self.person.id)!].favorites.append(newFavorite)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            else {
                                self.showDuplicateWarning = true
                            }
                        }
                        else {
                            self.showEmptyNameWarning = true
                        }
                    }.font(.title)
                    .alert(isPresented: $showEmptyNameWarning) {
                        Alert(title: Text("You Must Select a Restaurant to Add"), dismissButton: .default(Text("Oh, right!")))
                    }
            ) // end navigationBarItems
        } // end NavigationView
        .alert(isPresented: $showDuplicateWarning) {
            Alert(title: Text("This Restaurant Already Exists as a Favorite for this Person"), dismissButton: .default(Text("Oh, right!")))
        }
    } // end body
    
    // TODO: search restaurants by UUID instead of name (in case of duplicate named restaurants)
    func searchRestaurantsForName(name: String) -> Int? {
        return restaurants.items.firstIndex { $0.name == self.selectedRestaurant }
    }
    
    func searchPeopleForUUID(id: UUID) -> Int? {
        return people.items.firstIndex { $0.id == self.person.id }
    }
    
    // return true if a favorite of given restaurant already exists
    func findDuplicate(restaurant: String) -> Bool? {
        for i in person.favorites {
            if(i.restaurantName == restaurant) {
                return true // if a duplicate name is found
            }
        }
        return false // if a duplicate name is not found
    }
    
}

struct AddFavorite_Previews: PreviewProvider {
    static var previews: some View {
        AddFavorite(person: Person(name: "", notes: ""))
    }
}
