//
//  RestaurantEdit.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/7/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//
/*
import SwiftUI

struct RestaurantEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @State var restaurant: Restaurant?
    @State private var name: String
    @State private var type: String
    @State private var notes: String
    
    /*
    init() {
        self.name = restaurant.name
        self.type = restaurant.type
        self.notes = restaurant.notes
    }
 */
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $restaurant.name)
                
                TextField("Type (optional)", text: $restaurant.type)
                
                TextField("Notes (optional)", text: $restaurant.notes)
                
            }
            .navigationBarTitle("Edit Restaurant")
            .navigationBarItems(trailing:
                Button("Save") {
                    if !self.name.isEmpty
                    {
                        self.restaurant = Restaurant(name: self.name, type: self.type, notes: self.notes)
                        // restaurant.name = self.name
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }.font(.largeTitle))
        }
    }
}


struct RestaurantEdit_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantEdit() // restaurant: Restaurant(name: "", type: "", notes: ""))
    }
}
 /**/*/
