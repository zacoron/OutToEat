//
//  AppView.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/7/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            RestaurantScroll()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Restaurants")
                }
            
            PeopleScroll()
                .tabItem {
                    Image(systemName: "person.2")
                    Text("People")
                }
            
            OtherView()
            .tabItem {
                Image(systemName: "tortoise")
                Text("Other")
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    // static let people = PeopleScroll()
    static var previews: some View {
        AppView() // .environmentObject(people)
    }
}
