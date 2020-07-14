//
//  OrderAdd.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/13/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct OrderAdd: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var people: People
    @EnvironmentObject var restaurants: Restaurants
    var favorite: Favorite
    var person: Person
    
    @State private var orderDetails = ""
    @State private var orderNotes = ""
    @State private var orderCost = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Order", text: $orderDetails)
                TextField("Notes", text: $orderNotes)
                TextField("Cost", text: $orderCost).keyboardType(.decimalPad)
            }
            .navigationBarTitle("Add New Restaurant")
            .navigationBarItems(
                leading:
                    Button("Close") {
                        self.presentationMode.wrappedValue.dismiss()
                    }.font(.title),
                trailing:
                    Button("Save") { // TODO: add warning when trying to save restaurant w/o name
                        if !self.orderDetails.isEmpty
                        {
                            let newOrder = Order(orderDetails: self.orderDetails, orderNotes: self.orderNotes, orderCost: Double(self.orderCost) ?? 0)
                            
                            // horribly ugly way to append the order manually through its direct lineage
                            self.people.items[self.searchPeopleForUUID(id: self.person.id)!].favorites[self.searchFavoritesForUUID(id: self.favorite.id)!].orders.append(newOrder)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }.font(.title)
            ) // end navigationBarItems
        } // end NavigationView
    } // end body
    
    func searchPeopleForUUID(id: UUID) -> Int? {
        return people.items.firstIndex { $0.id == self.person.id }
    }
    
    func searchFavoritesForUUID(id: UUID) -> Int? {
        return people.items[self.searchPeopleForUUID(id: self.person.id)!].favorites.firstIndex { $0.id == self.favorite.id }
    }
}

struct OrderAdd_Previews: PreviewProvider {
    static var previews: some View {
        OrderAdd(favorite: Favorite(personName: "", personUUID: UUID(), restaurantName: "", restaurantUUID: UUID(), cost: 5.55, notes: ""), person: Person(name: "", notes: ""))
    }
}
