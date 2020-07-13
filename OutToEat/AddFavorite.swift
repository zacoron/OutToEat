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
                TextField("Cost", text: $cost)
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
                            let newFavorite = Favorite(
                                personName: self.person.name,
                                personUUID: self.person.id,
                                restaurantName: self.selectedRestaurant,
                                restaurantUUID: self.restaurants.items[self.searchRestaurantsForName(name: self.selectedRestaurant)!].id,
                                order: self.order,
                                cost: 5.55,
                                notes: self.notes
                            )
                            
                            self.people.items[self.searchPeopleForUUID(id: self.person.id)!].favorites.append(newFavorite)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }.font(.title)
            ) // end navigationBarItems
        } // end NavigationView
    } // end body
    
    func searchRestaurantsForName(name: String) -> Int? {
        return restaurants.items.firstIndex { $0.name == self.selectedRestaurant }
    }
    
    func searchPeopleForUUID(id: UUID) -> Int? {
        return people.items.firstIndex { $0.id == self.person.id }
    }
    
    /*
    @EnvironmentObject var restaurants: Restaurants
    
    @State private var selectedRestaurant = ""
    @State private var orderDetails = ""
    
    var body: some View {
        // Text(restaurants.items[0].name)
    
        Form {
            Section {
                Picker(selection: $selectedRestaurant, label: Text("Restaurant")) {
                    ForEach(restaurants.items) { item in
                        Text(self.restaurants.items[self.restaurants.items.firstIndex(of: item)!].name)
                            .tag(self.restaurants.items[self.restaurants.items.firstIndex(of: item)!].name)
                    }
                } // end restaurant name Picker
                TextField("Order", text: $orderDetails)
            } // end Section
        }
        .navigationBarTitle("Add Favorite")
 
        
        
        // let newFavorite = Favorite(personName: "", personUUID: person.id, restaurantName: "3", restaurantUUID: "4", order: "4", cost: 5.55, notes: "6")
    }
    */
}

struct AddFavorite_Previews: PreviewProvider {
    static var previews: some View {
        AddFavorite(person: Person(name: "", notes: ""))
    }
}
