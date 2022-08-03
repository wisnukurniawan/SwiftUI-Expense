//
//  ContentView.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      
        
        Button("Crash") {
          fatalError("Crash was triggered")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
