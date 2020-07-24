//
//  Help.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/23/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct Help: View {
    var body: some View {
        VStack {
            List {
                VStack(alignment: .leading) {
                    Text("How do I add new restaurants?")
                        .font(.title)
                        .foregroundColor(Color.blue)
                        
                    Text("Navigate to the \"Restaurants\" tab on the bottom and click the + sign in the top right corner. Then enter the name and any additional information in the boxes that appear before hitting \"Save\" in the top right again.")
                }
                
                VStack(alignment: .leading) {
                    Text("How do I add new people?")
                        .font(.title)
                        .foregroundColor(Color.blue)
                        
                    Text("Navigate to the \"People\" tab on the bottom and click the + sign in the top right corner. Then enter the name and any additional information in the boxes that appear before hitting \"Save\" in the top right again.")
                }
                
                VStack(alignment: .leading) {
                    Text("How do I add a restaurant as a favorite?")
                        .font(.title)
                        .foregroundColor(Color.blue)
                        
                    Text("To add favorites you must first add both the restaurant and person for which you wish to save an order. From there, navigate to the person in question under the \"People\" tab and tap on their name to open their info page. A list of their favorited restaurants will appear with an \"Add Favorite\" button. Tapping this will open a new page that will let you add a restaurant to this list of favorites.")
                    
                    Text("Note: you must select a restaurant from the list of existing restaurants as well as provide an order before you can save the newly created favorite")
                        .foregroundColor(Color.gray)
                }
                
                VStack(alignment: .leading) {
                    Text("How do I save an order?")
                        .font(.title)
                        .foregroundColor(Color.blue)
                        
                    Text("You can only save orders for restaurants that are saved as favorites for a particular person. Adding a restaurant as a favorite will automatically save an order, but more can be added to that favorite by navigating to the info page of the person, then selecting the name of the restaurant. This will bring up a list of orders for that person at that restaurant, in which you can add additional orders by tapping the \"Add Order\" button")
                }
                
                VStack(alignment: .leading) {
                    Text("Other things to consider:")
                        .font(.title)
                        .foregroundColor(Color.blue)
                    
                    Text(" - Deleting a restaurant will not delete that resaurant from the favorites list of anybody. All the orders from that restaurant will remain until the favorite is deleted manually.")
                        .foregroundColor(Color.gray)
                }
            }
        }
        .navigationBarTitle("Help/FAQ")
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help()
    }
}
