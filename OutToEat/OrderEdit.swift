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
                    if !self.orderDetails.isEmpty {
                        self.people.setOrderDetails(
                            personIndex: self.personIndex()!,
                            favoriteIndex: self.favoriteIndex()!,
                            orderIndex: self.orderIndex()!,
                            newDetails: self.orderDetails)
                    }
                    
                    if !self.orderNotes.isEmpty {
                        self.people.setOrderNotes(
                            personIndex: self.personIndex()!,
                            favoriteIndex: self.favoriteIndex()!,
                            orderIndex: self.orderIndex()!,
                            newNotes: self.orderNotes)
                    }
                    
                    if !self.orderCost.isEmpty {
                        self.people.setOrderCost(
                            personIndex: self.personIndex()!,
                            favoriteIndex: self.favoriteIndex()!,
                            orderIndex: self.orderIndex()!,
                            newCost: Double(self.orderCost)!)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.title)
        ) // end navigationBarItems
    } // end body
    
    // return the index of the person (no arguments b/c i use the local variables anyway)
    func personIndex() -> Int? {
        // print("Person Index: \(people.items.firstIndex(of: person) ?? -1)")
        return people.items.firstIndex(of: person) ?? -1
    }
    
    // return the index of the favorite (no arguments b/c i use the local variables anyway)
    func favoriteIndex() -> Int? {
        let personindex = personIndex() ?? -1 // get the index of the person
        
        // print("Favorite Index: \(people.items[personindex].favorites.firstIndex(of: favorite) ?? -1)")
        return people.items[personindex].favorites.firstIndex(of: favorite) ?? -1
    }
    
    // return the index of the order (no arguments b/c i use the local variables anyway)
    func orderIndex() -> Int? {
        let personindex = personIndex() ?? -1 // get the index of the person
        let favoriteindex = favoriteIndex() ?? -1 // get the index of the favorite
        
        // print("Order Index: \(people.items[personindex].favorites[favoriteindex].orders.firstIndex(of: order) ?? -1)")
        return people.items[personindex].favorites[favoriteindex].orders.firstIndex(of: order) ?? -1
    }
}

struct OrderEdit_Previews: PreviewProvider {
    static var previews: some View {
        OrderEdit(person: Person(name: "", notes: ""), favorite: Favorite(personName: "", personUUID: UUID(), restaurantName: "", restaurantUUID: UUID(), cost: 5.55, notes: ""), order: Order(orderDetails: "", orderNotes: "", orderCost: 5.55), index: 0)
    }
}
