//
//  AddFavorite.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/9/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct AddFavorite: View {
    // let restaurants = RestaurantScroll.init(restaurants: items)
    
    @State var selectedRestaurant = ""    
    
    var body: some View {
        Text("Add Favorite")
        /*
        Form {
            TextField("Select a Restaurant", text: $selectedRestaurant)
        }
        */
        
        // let newFavorite = Favorite(personName: "", personUUID: person.id, restaurantName: "3", restaurantUUID: "4", order: "4", cost: 5.55, notes: "6")
    }
}

struct AddFavorite_Previews: PreviewProvider {
    static var previews: some View {
        AddFavorite()
    }
}
