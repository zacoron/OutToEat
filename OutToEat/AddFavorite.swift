//
//  AddFavorite.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/9/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct AddFavorite: View {
    @ObservedObject var restaurants: Restaurants
    
    @State var selectedRestaurant = ""
    
    var body: some View {
        // Text(restaurants.items[0].name)
        
        
        Form {
            Picker(selection: $selectedRestaurant, label: Text("Restaurant")) {
                ForEach(restaurants.items) { item in
                    
                    Text(String(self.restaurants.items.count))
                }
            }
        }
 
        
                
        // let newFavorite = Favorite(personName: "", personUUID: person.id, restaurantName: "3", restaurantUUID: "4", order: "4", cost: 5.55, notes: "6")
    }
}

struct AddFavorite_Previews: PreviewProvider {
    static var previews: some View {
        AddFavorite(restaurants: Restaurants())
    }
}
