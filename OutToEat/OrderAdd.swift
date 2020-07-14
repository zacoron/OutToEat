//
//  OrderAdd.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/13/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct OrderAdd: View {
    @EnvironmentObject var people: People
    @EnvironmentObject var restaurants: Restaurants
    var favorite: Favorite
    var person: Person
    
    var body: some View {
        Text("OrderAdd")
    }
}

struct OrderAdd_Previews: PreviewProvider {
    static var previews: some View {
        OrderAdd(favorite: Favorite(personName: "", personUUID: UUID(), restaurantName: "", restaurantUUID: UUID(), cost: 5.55, notes: ""), person: Person(name: "", notes: ""))
    }
}
