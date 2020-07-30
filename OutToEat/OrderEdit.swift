//
//  OrderEdit.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/30/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

// TODO: make sure i lookup orders by id
struct OrderEdit: View {
    @EnvironmentObject var people: People
    var person: Person
    var favorite: Favorite
    var order: Order
    var index: Int
    
    @State var orderDetails = ""
    @State var orderNotes = ""
    @State var orderCost = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Divider().padding(.top, 20)
            
            HStack {
                Text("Name:").font(.title)
                Spacer()
                TextField(order.orderDetails, text: $orderDetails).font(.title)
            }
            
            Divider()
            
            HStack {
                Text("Notes:").font(.title)
                Spacer()
                TextField(order.orderNotes, text: $orderNotes).font(.title)
            }
            
            Divider()
            
            HStack {
                Text("Cost:").font(.title)
                Spacer()
                TextField(String(order.orderCost), text: $orderCost).font(.title)
            }
            
            Spacer()
        } // end VStack
        .navigationBarTitle("Editing Order #\(index)")
        .navigationBarItems(
            trailing:
                Button("Save") { // TODO: don't want to overwrite notes sooo figure something out for that
                    // this checks for empty values to determine whether to update or not
                    
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.title)
        ) // end navigationBarItems
    } // end body
    
    // return the index of the person
    func personIndex(person: Person) -> Int? {
        // print("Person Index: \(people.items.firstIndex(of: person) ?? -1)")
        return people.items.firstIndex(of: person)
    }
    
    // return the index of the favorite
    func favoriteIndex(person: Person, favorite: Favorite) -> Int? {
        let personindex = personIndex(person: person) ?? -1 // get the index of the person
        
        // print("Favorite Index: \(people.items[personindex].favorites.firstIndex(of: favorite) ?? -1)")
        return people.items[personindex].favorites.firstIndex(of: favorite)
    }
    
    // return the index of the order
    func orderIndex(person: Person, favorite: Favorite, order: Order) -> Int? {
        let personindex = personIndex(person: person) ?? -1 // get the index of the person
        let favoriteindex = favoriteIndex(person: person, favorite: favorite) ?? -1 // get the index of the favorite
        
        print("Order Index: \(people.items[personindex].favorites[favoriteindex].orders.firstIndex(of: order) ?? -1)")
        return people.items[personindex].favorites[favoriteindex].orders.firstIndex(of: order)
    }
}

struct OrderEdit_Previews: PreviewProvider {
    static var previews: some View {
        OrderEdit(person: Person(name: "", notes: ""), favorite: Favorite(personName: "", personUUID: UUID(), restaurantName: "", restaurantUUID: UUID(), cost: 5.55, notes: ""), order: Order(orderDetails: "", orderNotes: "", orderCost: 5.55), index: 0)
    }
}
