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
    @State private var personIndex2 = 0
    @State private var favoriteIndex2 = 0
    
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
                            self.personIndex2 = self.personIndex()!
                            self.favoriteIndex2 = self.favoriteIndex()!
                            self.showingOrderAdd = true
                        }) {
                            Text("Add Order")
                        }
                    }
                }.padding(.horizontal, 10)
                
                List {
                    ForEach(self.people.items[self.personIndex2].favorites[self.favoriteIndex()!].orders) { item in
                        NavigationLink(destination: OrderInfo(
                            person: self.person,
                            favorite: self.favorite,
                            order: item,
                            index: (self.people.items[0].favorites[0].orders.firstIndex(of: item)!) + 1)) { // (self.favorite.orders.firstIndex(of: item) ?? 0) + 1)) {
                                Text(self.people.items[self.personIndex2].favorites[self.favoriteIndex2].orders[self.people.items[self.personIndex2].favorites[self.favoriteIndex2].orders.firstIndex(of: item)!].orderDetails)
                                // Text(self.favorite.orders[self.favorite.orders.firstIndex(of: item)!].orderDetails)
                                // Text(String(self.people.items[3].favorites[0].orders.firstIndex(of: item).orderDetails))
                        }
                    }
                }
                
                /*
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
                */
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
        print("Person Name:\(person.name)")
        print("Person Index: \(people.items.firstIndex(of: person) ?? -1)")
        print("Person Count: \(people.items.count)")
        print("Person ID: \(person.id)")
        print("People 0 ID: \(people.items[0].id)")
        return people.items.firstIndex { $0.id == person.id} ?? -1
    }
    
    // return the index of the favorite (no arguments b/c i use the local variables anyway)
    func favoriteIndex() -> Int? {
        let personindex = personIndex2 // get the index of the person
        
        print("Favorite Index: \(people.items[personindex].favorites.firstIndex { $0.id == favorite.id } ?? -1)")
        return people.items[personindex].favorites.firstIndex { $0.id == favorite.id } ?? -1
    }
}

struct InfoFavorite_Previews: PreviewProvider {
    static var previews: some View {
        InfoFavorite(person: Person(name: "", notes: ""), favorite: Favorite(personName: "", personUUID: UUID(), restaurantName: "", restaurantUUID: UUID(), orders: [Order(orderDetails: "", orderNotes: "", orderCost: 5.55)], cost: 5.55, notes: ""))
    }
}
