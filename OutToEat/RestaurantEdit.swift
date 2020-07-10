//
//  RestaurantEdit.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/7/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct RestaurantEdit: View {
    @ObservedObject var restaurants: Restaurants
    var restaurant: Restaurant
    // var index: Int
    
    @State var name = ""
    @State var type = ""
    @State var notes = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    /*
    init() {
        self.name = restaurant.name
        self.type = restaurant.type
        self.notes = restaurant.notes
    }
 */
    
    var body: some View {
        // NavigationView {
            VStack {
                Divider()
                    .padding(.vertical, 20)
                
                HStack {
                    Text("Name:")
                        .font(.title)
                    Spacer()
                    Text(restaurant.name)
                        .font(.title)
                }
                
                Divider()
                
                HStack {
                    Text("Type:")
                        .font(.title)
                    Spacer()
                    Text(restaurant.type)
                        .font(.title)
                }
                
                Divider()
                
                HStack {
                    Text("Notes:")
                        .font(.title)
                    Spacer()
                    Text(restaurant.notes)
                        .font(.title)
                }
                
                Form {
                    TextField("Name", text: $name)
                    
                    TextField("Type (optional)", text: $type)
                    
                    TextField("Notes (optional)", text: $notes)
                    
                }
                
                Spacer()
            }
            .navigationBarTitle("Editing: \(restaurant.name)" )
            .navigationBarItems(
                trailing:
                    Button("Save") {
                        if !self.name.isEmpty
                        {
                            self.restaurants.setName(newName: self.name, index: self.restaurants.items.firstIndex(of: self.restaurant)!)
                            // restaurant = Restaurant(name: name, type: type, notes: notes)
                            // restaurant.updateName(newName: "hi")
                            // self.restaurant.updateName(newName: self.name)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }.font(.largeTitle))
            
        // }
    }
    
    
}


struct RestaurantEdit_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantEdit(restaurants: Restaurants(), restaurant: Restaurant(name: "", type: "", notes: ""))
    }
}

