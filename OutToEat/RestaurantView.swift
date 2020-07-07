//
//  RestaurantView.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/6/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct RestaurantView: View {
    var body: some View {
        
        ScrollView(showsIndicators: true) {
            VStack() {
                ForEach(0..<10) {_ in
                    Text("hi")
                    
                    Divider()
                }
            }
        }
        
        /*
        VStack {
            HStack(content: <#T##() -> _#>) {
               Text("Restaurants")
                   .font(.largeTitle)
                   .foregroundColor(.black)
               
               Spacer()
               
               Button(action: {
                   // add action for adding new restaurant
               }) {
                   Text("+")
                       .font(.largeTitle)
                       .bold()
                       .foregroundColor(.blue)
                       .padding(5)
                       .border(Color.blue, width: 5)
               }
           }.frame(alignment: .topLeading)
            .padding()
           
            Divider()
           
            ScrollView(showsIndicators: true) {
                VStack() {
                    ForEach(0..<10) {
                        
                    }
                }
            }
        }
        */
        
       
    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView()
    }
}
