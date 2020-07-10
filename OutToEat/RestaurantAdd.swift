//
//  RestaurantAdd.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/6/20
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct RestaurantAdd: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var restaurants: Restaurants
    @State private var name = ""
    @State private var type = ""
    @State private var notes = ""
    // @State private var amount = ""
    // static let types = ["Chinese", "American", "Italian"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                TextField("Type (optional)", text: $type)
                
                TextField("Notes (optional)", text: $notes)
                
                /*
                Picker("Type (optional)", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
                */
            }
            .navigationBarTitle("Add New Restaurant")
            .navigationBarItems(
                leading:
                    Button("Close") {
                        self.presentationMode.wrappedValue.dismiss()
                    }.font(.largeTitle),
                trailing:
                    Button("Save") { // TODO: add warning when trying to save restaurant w/o name
                        if !self.name.isEmpty
                        {
                            let item = Restaurant(name: self.name, type: self.type, notes: self.notes)
                            self.restaurants.items.append(item)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }.font(.largeTitle))            
        }
    }
}

struct RestaurantAdd_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantAdd(restaurants: Restaurants())
    }
}
