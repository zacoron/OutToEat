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
    var person: Person
    var favorite: Favorite
    
    
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
                    NavigationLink(destination: OrderAdd(person: self.person, favorite: self.favorite)) {
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
                        NavigationLink(destination: OrderInfo(
                            person: self.person,
                            favorite: self.favorite,
                            order: item,
                            index: (self.favorite.orders.firstIndex(of: item)!) + 1)) {
                                Text(self.favorite.orders[self.favorite.orders.firstIndex(of: item)!].orderDetails)
                        }
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
            OrderAdd(person: self.person, favorite: self.favorite)
                .environmentObject(self.restaurants)
                .environmentObject(self.people)
        } // end navigationBarItems
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

struct InfoFavorite_Previews: PreviewProvider {
    static var previews: some View {
        InfoFavorite( person: Person(name: "", notes: ""), favorite: Favorite(personName: "", personUUID: UUID(), restaurantName: "", restaurantUUID: UUID(), orders: [Order(orderDetails: "", orderNotes: "", orderCost: 5.55)], cost: 5.55, notes: ""))
    }
}
