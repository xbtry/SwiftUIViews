//
//  ContentView.swift
//  SwiftUIViews
//
//  Created by baturay on 13.05.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var someVal : Double = 0.0
    var body: some View {
        VStack {
            KnobView(value: $someVal,maxVal: 100.0)
            Text("\(someVal)")
        }
    }
}

#Preview {
    ContentView()
}
