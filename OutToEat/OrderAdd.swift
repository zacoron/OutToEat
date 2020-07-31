//
//  OrderAdd.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/13/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

// TODO: fix orders not automatically showing up in infofavorite list of orders (seemingly only through the people tab - restaurants works fine)
struct OrderAdd: View {
    @EnvironmentObject var people: People
    @EnvironmentObject var restaurants: Restaurants
    @State var person: Person
    @State var favorite: Favorite
    
    
    @State private var orderDetails = ""
    @State private var orderNotes = ""
    @State private var orderCost = ""
    
    @State private var showWarning = false
    @State private var showingAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Order", text: $orderDetails)
                    TextField("Notes", text: $orderNotes)
                    TextField("Cost", text: $orderCost).keyboardType(.decimalPad)
                }
                
                Spacer()
            }
            .navigationBarTitle("Add New Order")
            .navigationBarItems(
                leading:
                    Button("Close") {
                        self.presentationMode.wrappedValue.dismiss()
                    }.font(.title),
                trailing:
                    Button("Save") {
                        if !self.orderDetails.isEmpty {
                            let newOrder = Order(orderDetails: self.orderDetails, orderNotes: self.orderNotes, orderCost: Double(self.orderCost) ?? 0)
                            
                            self.people.addOrder(
                                personIndex: self.personIndex()!,
                                favoriteIndex: self.favoriteIndex()!,
                                newOrder: newOrder)

                            self.presentationMode.wrappedValue.dismiss()
                        }
                        else { // display a message saying that the order must have a name
                            self.showWarning = true
                        }
                    }
                    .font(.title)
                    .alert(isPresented: $showWarning) {
                        Alert(title: Text("Order Must Have a Name"), dismissButton: .default(Text("Oh, right!")))
                    }
            ) // end navigationBarItems
        } // end NavigationView
    } // end body
    
    /**** INDEX RETRIEVAL FUNCTIONS ****/
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
}

struct OrderAdd_Previews: PreviewProvider {
    static var previews: some View {
        OrderAdd(person: Person(name: "", notes: ""), favorite: Favorite(personName: "", personUUID: UUID(), restaurantName: "", restaurantUUID: UUID(), cost: 5.55, notes: ""))
    }
}
