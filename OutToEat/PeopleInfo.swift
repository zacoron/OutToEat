//
//  PeopleInfo.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/9/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct PeopleInfo: View {
    @ObservedObject var people: People
    var person: Person
    @EnvironmentObject var restaurants: Restaurants
    @State private var showingAddFavorite = false
    
    var body: some View {
        VStack { // TODO: might be able to add horizontal padding to VStack instead of each HStack
            
            HStack {
                Text("Name:").font(.title)
                Spacer()
                Text(person.name).font(.title)
            }.padding(.horizontal, 10)
            
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
                        NavigationLink(destination: EditFavorite(favorite: item)) {
                            Text(self.person.favorites[self.person.favorites.firstIndex(of: item)!].restaurantName)
                        }
                    }
                    .deleteDisabled(false)
                }
                
            }
            
            Spacer()
            
        } // end VStack
        .navigationBarTitle("Info")
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
}

struct PeopleInfo_Previews: PreviewProvider {
    static var previews: some View {
        PeopleInfo(people: People(), person: Person(name: "", notes: ""))
    }
}
