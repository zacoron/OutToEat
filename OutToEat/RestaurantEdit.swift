//
//  RestaurantEdit.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/7/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

// addMode instead of presentationMode???
struct RestaurantEdit: View {
    @EnvironmentObject var restaurants: Restaurants
    var restaurant: Restaurant
    
    @State var name = ""
    @State var type = ""
    @State var notes = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Divider().padding(.top, 10)
            
            HStack {
                Text("Name:").font(.title)
                Spacer()
                Text(restaurant.name).font(.title)
                // TextField(restaurant.name, text: $name).font(.title) // removed for time-being
            }.padding(.horizontal, 10)
            
            Divider()
            
            HStack {
                Text("Type:").font(.title)
                Spacer()
                TextField(restaurant.type, text: $type).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            HStack {
                Text("Notes:").font(.title)
                Spacer()
                TextField(restaurant.notes, text: $notes)
                    .font(.title)
                    .textFieldStyle(PlainTextFieldStyle())
            }.padding(.horizontal, 10)
            
            Spacer()
            
            Button("Delete") {
                if(self.restaurants.items.firstIndex(of: self.restaurant) != nil) { // makes sure there is actually something there to delete before attempting to do so
                    self.restaurants.removeAtIndex(index: self.restaurants.items.firstIndex(of: self.restaurant)!)
                }
                
                // after deletion, go back to the main restaurants page
                self.presentationMode.wrappedValue.dismiss()
                self.presentationMode.wrappedValue.dismiss()
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding(.bottom, 50)
            .font(.title)
        } // end VStack
        .navigationBarTitle("Editing: \(restaurant.name)")
        .navigationBarItems(
            trailing:
                Button("Save") { // TODO: don't want to overwrite notes sooo figure something out for that
                    // this checks each box for empty values to determine whether to update or not
                    /* editing restaurant names causes a lot of problems so remove this feature for now
                    if !self.name.isEmpty {
                        self.restaurants.setName(
                            newName: self.name,
                            index: self.restaurantIndex()!)
                    }
                    */
                    if !self.type.isEmpty {
                        self.restaurants.setType(
                            newType: self.type,
                            index: self.restaurantIndex()!)
                    }
                    // TODO: 121 throws error if finds nil (when editing type and notes at same time on restaurant entry that has not been edited before). dont know why
                    if !self.notes.isEmpty {
                        self.restaurants.setNotes(
                            newNotes: self.notes,
                            index: self.restaurantIndex()!)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.title)
        ) // end navigationBarItems
    } // end body
    
    /**** INDEX RETRIEVAL FUNCTIONS ****/
    // return the index of the restaurant (no arguments b/c i use the local variables anyway)
    func restaurantIndex() -> Int? {
        // print("Restaurant Index: \(restaurants.items.firstIndex(of: restaurant) ?? -1)")
        return restaurants.items.firstIndex(of: restaurant) ?? -1
    }
}


struct RestaurantEdit_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantEdit(restaurant: Restaurant(name: "", type: "", notes: ""))
    }
}

