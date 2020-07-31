//
//  PeopleInfo.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/9/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct PeopleInfo: View {
    @EnvironmentObject var people: People
    @EnvironmentObject var restaurants: Restaurants
    var person: Person

    @State private var showingAddFavorite = false
    
    var body: some View {
        VStack { // might be able to add horizontal padding to VStack instead of each HStack
            
            Divider()
            
            HStack {
                Text("Notes:").font(.title)
                Spacer()
                Text(person.notes).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            VStack {
                HStack {
                    Text("Favorites:").font(.title)
                    Spacer()
                    NavigationLink(destination: AddFavorite(person: self.person)) {
                        Button(action: {
                            self.showingAddFavorite = true
                        }) {
                            Text("Add Favorite")
                        }
                    }
                }.padding(.horizontal, 10)
                
                List {
                    ForEach(person.favorites) { item in
                        NavigationLink(destination: InfoFavorite(
                            person: self.person,
                            favorite: self.findFavorite(person: self.person, restaurantName: item.restaurantName)!)) {
                                Text(self.person.favorites[self.person.favorites.firstIndex(of: item)!].restaurantName)
                        }
                    }
                    .deleteDisabled(false)
                }
                
            }
            
            Spacer()
            
        } // end VStack
        .navigationBarTitle(self.person.name)
        .navigationBarItems(trailing:
            NavigationLink(destination: PeopleEdit(people: people, person: person)) {
                Text("Edit").font(.title)
            }
        )
        .sheet(isPresented: $showingAddFavorite) {
            AddFavorite(person: self.person)
                .environmentObject(self.restaurants)
                .environmentObject(self.people)
        } // end navigationBarItems
    }
    
    // returns the favorite given the name of the restaurant
    func findFavorite(person: Person, restaurantName: String) -> Favorite? {
        for i in person.favorites {
            if(i.restaurantName == restaurantName) {
                print("Found Favorite - \(i.restaurantName) Count: \(person.favorites.count)")
                return i
            }
        }
        
        return nil
    }
}

struct PeopleInfo_Previews: PreviewProvider {
    static var previews: some View {
        PeopleInfo(person: Person(name: "", notes: ""))
    }
}
