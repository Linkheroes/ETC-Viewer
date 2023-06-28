//
//  WalletView.swift
//  Nanopool
//
//  Created by Alexandre Ricard on 16/08/2021.
//

import SwiftUI

struct WalletView: View {
    
    @State private var wallet = ""
    
    @State private var showingAlert = false
    
    @State var correctWallet = false
    
    var body: some View {
        VStack() {
            HStack() {
                Text("Wallet").bold()
                    .font(.largeTitle)
                    .padding(.all)
                
                Spacer()
            }
            .padding(.top)
            
            Image("portefeuille-ethereum").resizable().frame(width: 256, height: 256)
            
            ZStack() {
                Rectangle()
                    .fill(Color(UIColor.systemGray5))
                    .cornerRadius(20)
                
                TextField("Wallet ID", text: $wallet)
                    .padding(20.0)
                    
            }.frame(maxWidth: .infinity, maxHeight: 40).padding(.all, 20.0)
            
            Button {
                if self.wallet.starts(with: "0x") {
                    UserDefaults.standard.set(self.wallet, forKey: "walletID")
                    self.correctWallet.toggle()
                } else {
                    self.showingAlert.toggle()
                }
            } label: {
                Text("Save").bold().font(.title2).foregroundColor(Color.white)
            }.padding().frame(maxWidth: 250, maxHeight: 50).background(Color.gray).cornerRadius(12.5)

            
            Text("No personal data is stored anywhere but on your phone").font(.footnote).foregroundColor(Color(UIColor.systemRed)).padding(.top)
            
            Spacer()
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text("Your wallet ID is not recognized"), dismissButton: .default(Text("OK")))
        }
        .fullScreenCover(isPresented: self.$correctWallet) {
            HomeView()
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
