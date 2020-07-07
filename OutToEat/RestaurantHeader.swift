//
//  RestaurantHeader.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/6/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct RestaurantHeader: View {
    var body: some View {
        
        VStack() {
            HStack() {
                Text("Restaurant")
                    .font(.largeTitle)
                
                Spacer()
                
                Button(action: {
                    // addRestaurant(name: "restaurante")
                    // print("there are now \(restaurantList.count) restaurants")
                }) {
                    Text("+")
                        .font(.largeTitle)
                }
                            
            }.padding(.horizontal)
            
            Divider().padding(.bottom)
        }
        
        
    }
}

struct RestaurantHeader_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantHeader()
    }
}
