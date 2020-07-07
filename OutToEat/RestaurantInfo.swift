//
//  RestaurantInfo.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/6/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct RestaurantInfo: View {
    // @ObservedObject var restaurants: Restaurants
    var restaurant: Restaurant
    @State private var showingRestaurantEdit = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Name:")
                        .font(.title)
                    Spacer()
                    Text(restaurant.name)
                        .font(.title)
                }
                .padding(.horizontal, 10)
                
                Divider()
                
                HStack {
                    Text("Type:")
                        .font(.title)
                    Spacer()
                    Text(restaurant.type)
                        .font(.title)
                }
                .padding(.horizontal, 10)
                
                Divider()
                
                HStack {
                    Text("Notes:")
                        .font(.title)
                    Spacer()
                    Text(restaurant.notes)
                        .font(.title)
                }
                .padding(.horizontal, 10)
                
                Spacer()
            }
            .navigationBarTitle("Info")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingRestaurantEdit = true
                }) {
                    Text("Edit").font(.largeTitle)
                }
            )
            // .sheet(isPresented: $showingRestaurantEdit) {
                // RestaurantAdd(restaurants: restaurants) // restaurant: self.restaurant)
            // }
        }
        
        
    
        
    }
}

struct RestaurantInfo_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfo(restaurant: Restaurant(name: "", type: "", notes: ""))
    }
}
