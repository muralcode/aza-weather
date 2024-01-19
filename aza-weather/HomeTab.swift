//
//  HomeTab.swift
//  aza-weather
//
//  Created by Lerato Mokoena on 2024/01/19.
//

import SwiftUI

struct HomeTab: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "sun.max.fill")
                Text("Current Weather")
            }
            
            Forecast().tabItem {
                Image(systemName: "calendar")
                Text("7 day Forecast")
            }
        }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}
