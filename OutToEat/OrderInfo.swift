//
//  OrderInfo.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/13/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct OrderInfo: View {
    @EnvironmentObject var people: People
    @EnvironmentObject var restaurants: Restaurants
    
    var person: Person
    var favorite: Favorite
    var order: Order
    var index: Int // the index of the order (1 is added when OrderInfo is called)
    
    var body: some View {
        VStack {
            Divider()
            
            HStack {
                Text("Details:").font(.title)
                Spacer()
                Text(order.orderDetails).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            HStack {
                Text("Notes:").font(.title)
                Spacer()
                Text(order.orderNotes).font(.title)
            }.padding(.horizontal, 10)
            
            Divider()
            
            HStack {
                Text("Cost:").font(.title)
                Spacer()
                Text(String(order.orderCost)).font(.title)
            }.padding(.horizontal, 10)
            
            Spacer()
        }
        .navigationBarTitle("Order #\(index)").padding()
        .navigationBarItems(trailing:
            NavigationLink(destination: OrderEdit(person: person, favorite: favorite, order: order, index: index)) {
                Text("Edit").font(.title)
            }
        )
    }
}

struct OrderInfo_Previews: PreviewProvider {
    static var previews: some View {
        OrderInfo(person: Person(name: "", notes: ""), favorite: Favorite(personName: "", personUUID: UUID(), restaurantName: "", restaurantUUID: UUID(), cost: 5.55, notes: ""), order: Order(orderDetails: "", orderNotes: "", orderCost: 5.55), index: 0)
    }
}
