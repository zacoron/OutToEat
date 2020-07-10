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
                    NavigationLink(destination: AddFavorite()) {
                        Text("Add Favorite")
                        // self.people.addFavorite(newFavorite: newFavorite, index: self.people.items.firstIndex(of: self.person)!)
                    }
                }.padding(.horizontal, 10)
                
                
                List {
                    ForEach(person.favorites) { item in
                        NavigationLink(destination: AddFavorite()) {
                            Text(item.restaurantName).font(.title)
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
        ) // end navigationBarItems
         
    }
}

struct PeopleInfo_Previews: PreviewProvider {
    static var previews: some View {
        PeopleInfo(people: People(), person: Person(name: "", notes: ""))
    }
}
