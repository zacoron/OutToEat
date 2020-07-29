//
//  InfoFavorite.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/13/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct InfoFavorite: View {
    @EnvironmentObject var people: People
    @EnvironmentObject var restaurants: Restaurants
    var favorite: Favorite
    var person: Person
    
    @State private var showingOrderAdd = false
    
    var body: some View {
        VStack {
            Divider()
            
            HStack {
                Text("Notes:").font(.title)
                Spacer()
                Text(favorite.notes).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            VStack {
                HStack {
                    Text("Orders:").font(.title)
                    Spacer()
                    NavigationLink(destination: OrderAdd(favorite: self.favorite, person: self.person)) {
                        Button(action: {
                            self.showingOrderAdd = true
                        }) {
                            Text("Add Order")
                        }
                    }
                }.padding(.horizontal, 10)
                
                // TODO: make sure orders added through the people -> favorites -> add order button appear automatically
                List {
                    ForEach(favorite.orders) { item in
                        
                        NavigationLink(destination: OrderInfo(order: item, index: (self.favorite.orders.firstIndex(of: item)!) + 1)) {
                            Text(self.favorite.orders[self.favorite.orders.firstIndex(of: item)!].orderDetails)
                        }
                        
                        // Text("\(item.orderDetails) - Count: \(self.favorite.orders.count)")
                        
                    }
                    .deleteDisabled(false)
                }
            }
            
            Spacer()
        }
        .navigationBarTitle("\(person.name) - \(favorite.restaurantName)").padding()
        .navigationBarItems(trailing:
            NavigationLink(destination: EditFavorite(person: person, favorite: favorite)) {
                Text("Edit").font(.title)
            }
        )
        .sheet(isPresented: $showingOrderAdd) {
            OrderAdd(favorite: self.favorite, person: self.person)
                .environmentObject(self.restaurants)
                .environmentObject(self.people)
        }  // end navigationBarItems
    }
}

struct InfoFavorite_Previews: PreviewProvider {
    static var previews: some View {
        InfoFavorite(favorite: Favorite(personName: "", personUUID: UUID(), restaurantName: "", restaurantUUID: UUID(), orders: [Order(orderDetails: "", orderNotes: "", orderCost: 5.55)], cost: 5.55, notes: ""), person: Person(name: "", notes: ""))
    }
}
