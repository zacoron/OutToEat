//
//  RestaurantScroll.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/6/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct RestaurantScroll: View {
    @ObservedObject var restaurants = Restaurants()
    @State private var showingRestaurantAdd = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurants.items) { item in // items are identifiable (by UUID) so no need to specify id
                    NavigationLink(destination: RestaurantInfo(restaurants: self.restaurants, restaurant: item)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name).font(.title)
                            }
                            Spacer()
                        }
                    }
                }
                .deleteDisabled(true)
                // .onDelete(perform: removeItems)
            } // end List
            .navigationBarTitle("Restaurants")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.showingRestaurantAdd = true
                    }) {
                        Image(systemName: "plus").font(.title)
                    }
            ) // end navigationBarItems
            .sheet(isPresented: $showingRestaurantAdd) {
                RestaurantAdd(restaurants: self.restaurants)
            }
        } // end NavigationView
    }
    
    /* don't need anymore
    func removeItems(at offsets: IndexSet) {
        restaurants.items.remove(atOffsets: offsets)
    }
    */
}


struct RestaurantScroll_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantScroll()
    }
}
