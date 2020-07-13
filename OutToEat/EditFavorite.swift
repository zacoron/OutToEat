//
//  EditFavorite.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/9/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct EditFavorite: View {
    @EnvironmentObject var people: People
    var favorite: Favorite
    
    var body: some View {
        VStack {
            Text("Restaurant Name: \(favorite.restaurantName)").padding()
            Text("Order: \(favorite.order)").padding()
        }
    }
}

struct EditFavorite_Previews: PreviewProvider {
    static var previews: some View {
        EditFavorite(favorite: Favorite(personName: "", personUUID: UUID(), restaurantName: "", restaurantUUID: UUID(), order: "", cost: 5.55, notes: ""))
    }
}
