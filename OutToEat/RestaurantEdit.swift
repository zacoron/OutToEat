//
//  RestaurantEdit.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/7/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

// TODO: addMode instead of presentationMode???
struct RestaurantEdit: View {
    @ObservedObject var restaurants: Restaurants
    var restaurant: Restaurant
    
    @State var name = ""
    @State var type = ""
    @State var notes = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Divider().padding(.vertical, 20)
            
            HStack {
                Text("Name:").font(.title)
                Spacer()
                Text(restaurant.name).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            HStack {
                Text("Type:").font(.title)
                Spacer()
                Text(restaurant.type).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            HStack {
                Text("Notes:").font(.title)
                Spacer()
                Text(restaurant.notes).font(.title)
            }.padding(.horizontal, 10)
            
            Form {
                TextField("Name", text: $name)
                TextField("Type (optional)", text: $type)
                TextField("Notes (optional)", text: $notes)
            }
            
            Spacer()
        } // end VStack
        .navigationBarTitle("Editing: \(restaurant.name)")
        .navigationBarItems(
            trailing:
                Button("Save") { // TODO: don't want to overwrite notes sooo figure something out for that
                    // check each box for empty values to determine whether to update or not
                    if !self.name.isEmpty {
                        self.restaurants.setName(newName: self.name, index: self.restaurants.items.firstIndex(of: self.restaurant)!)
                    }
                    if !self.type.isEmpty {
                        self.restaurants.setType(newType: self.type, index: self.restaurants.items.firstIndex(of: self.restaurant)!)
                    }
                    if !self.notes.isEmpty {
                        self.restaurants.setNotes(newNotes: self.notes, index: self.restaurants.items.firstIndex(of: self.restaurant)!)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }.font(.title)
        ) // end navigationBarItems
    } // end body
}


struct RestaurantEdit_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantEdit(restaurants: Restaurants(), restaurant: Restaurant(name: "", type: "", notes: ""))
    }
}

