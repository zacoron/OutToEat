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
                if(self.people.items[self.people.items.firstIndex(of: self.person)!].favorites.firstIndex(of: self.favorite) != nil) { // makes sure there is actually something there to delete before attempting to do so
                    self.people.deleteFavorite(personIndex: self.people.items.firstIndex(of: self.person)!, favoriteIndex: self.people.items[self.people.items.firstIndex(of: self.person)!].favorites.firstIndex(of: self.favorite)!)
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
                        self.people.setFavoriteNotes(personIndex: self.people.items.firstIndex(of: self.person)!, favoriteIndex: self.people.items[self.people.items.firstIndex(of: self.person)!].favorites.firstIndex(of: self.favorite)!, newNotes: self.notes)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.title)
        ) // end navigationBarItems
    }
}

struct EditFavorite_Previews: PreviewProvider {
    static var previews: some View {
        EditFavorite(person: Person(name: "", notes: "") ,favorite: Favorite(personName: "", personUUID: UUID(), restaurantName: "", restaurantUUID: UUID(), cost: 5.55, notes: ""))
    }
}
