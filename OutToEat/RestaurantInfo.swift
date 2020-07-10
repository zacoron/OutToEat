//
//  RestaurantInfo.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/6/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct RestaurantInfo: View {
    @ObservedObject var restaurants: Restaurants
    var restaurant: Restaurant
    
    var body: some View {
        VStack { // TODO: might be able to add horizontal padding to VStack instead of each HStack
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
            
            Spacer()
        } // end VStack
        .navigationBarTitle("Info")
        .navigationBarItems(trailing:
            NavigationLink(destination: RestaurantEdit(restaurants: restaurants, restaurant: restaurant)) {
                Text("Edit").font(.title)
            }
        ) // end navigationBarItems
    } // end body
}

struct RestaurantInfo_Previews: PreviewProvider {
    // @ObservedObject var restaurants: Restaurants
    static var previews: some View {
        RestaurantInfo(restaurants: Restaurants(), restaurant: Restaurant(name: "", type: "", notes: ""))
    }
}
