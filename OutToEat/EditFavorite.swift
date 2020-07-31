//
//  EditFavorite.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/9/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

// TODO: make sure deleting a favorite immediately removes it from the list when traveling back to the personview
struct EditFavorite: View {
    @EnvironmentObject var people: People
    @EnvironmentObject var restaurants: Restaurants
    var person: Person
    var favorite: Favorite
    
    @State var notes = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Divider().padding(.top, 20)
            
            HStack {
                Text("Name:").font(.title)
                Spacer()
                Text(favorite.restaurantName)
            }
            
            Divider()
            
            HStack {
                Text("Notes:").font(.title)
                Spacer()
                TextField(favorite.notes, text: $notes).font(.title)
            }
            
            Divider()
            
            Spacer()
            
            Button("Delete") {
                if(self.favoriteIndex() != -1) { // makes sure there is actually something there to delete before attempting to do so
                    self.people.deleteFavorite(
                        personIndex: self.personIndex()!,
                        favoriteIndex: self.favoriteIndex()!)
                }
                
                self.presentationMode.wrappedValue.dismiss()
                self.presentationMode.wrappedValue.dismiss()
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding(.bottom, 50)
            .font(.title)
        } // end VStack
        .navigationBarTitle("Editing Favorite: \(favorite.restaurantName)")
        .navigationBarItems(
            trailing:
                Button("Save") { // TODO: don't want to overwrite notes sooo figure something out for that
                    // this checks for empty values to determine whether to update or not
                    if !self.notes.isEmpty {
                        self.people.setFavoriteNotes(
                            personIndex: self.personIndex()!,
                            favoriteIndex: self.favoriteIndex()!,
                            newNotes: self.notes)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.title)
        ) // end navigationBarItems
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

struct EditFavorite_Previews: PreviewProvider {
    static var previews: some View {
        EditFavorite(person: Person(name: "", notes: "") ,favorite: Favorite(personName: "", personUUID: UUID(), restaurantName: "", restaurantUUID: UUID(), cost: 5.55, notes: ""))
    }
}
