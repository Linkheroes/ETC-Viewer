//
//  ContentView.swift
//  Nanopool
//
//  Created by Alexandre Ricard on 16/08/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var walletID = UserDefaults.standard.string(forKey: "walletID")
    
    var body: some View {
        if !(self.walletID?.isEmpty ?? true) {
            HomeView()
        }else {
            WalletView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
