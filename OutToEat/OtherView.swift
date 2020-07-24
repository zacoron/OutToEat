//
//  OtherView.swift
//  OutToEat
//
//  Created by Zack Smalley on 7/7/20.
//  Copyright © 2020 Zack Smalley. All rights reserved.
//

import SwiftUI

struct OtherView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Out To Eat")
                    .font(.largeTitle)
                    .padding(.vertical, 50)
                
                Text("Brought to you by:")
                    .font(.title)
                    .padding(.vertical, 15)
                
                Text("Zack Smalley")
                    .font(.title)
                    .foregroundColor(Color.blue)
                
                Text("(my name isn't a button but the blue looks nice")
                    .font(.subheadline)
                /*
                Text("Ciara Merrifield")
                    .foregroundColor(LinearGradient(gradient: Gradient(colors: [Color.pink]), startPoint: .top, endPoint: .bottom))
                */
                
                Spacer()
                
                Text("Special thanks to:")
                    .font(.title)
                    .padding(.vertical, 75)

                LinearGradient(gradient: Gradient(colors: [.pink, .green]),
                               startPoint: .leading,
                               endPoint: .trailing)
                    .mask(Text("Ciara Merrifield")
                        .frame(width: 400)
                        .font(.title)
                        .padding(.bottom, 25)
                    )
                
                
                
                Spacer()
                
                NavigationLink(destination: Help()) {
                    Text("Help").font(.title)
                }
                
                Text("version 1.0")
                    .foregroundColor(Color.gray)
                    .padding()
            }
        }
    }
}

struct OtherView_Previews: PreviewProvider {
    static var previews: some View {
        OtherView()
    }
}
