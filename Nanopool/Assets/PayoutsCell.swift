//
//  PayoutsCell.swift
//  Nanopool
//
//  Created by Alexandre Ricard on 17/08/2021.
//

import SwiftUI

struct PayoutsCell: View {
    
    var state: String
    var date: String
    var ethAmount: String
    var moneyAmount: String
    
    var body: some View {
        ZStack() {
            Rectangle().fill(Color(UIColor.tertiarySystemBackground)).frame(maxWidth: .infinity, maxHeight: 100).cornerRadius(20)
            
            VStack() {
                HStack() {
                    Text(state)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(ethAmount + " ETC")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                HStack() {
                    Text(date)
                        .font(.caption2)
                    
                    Spacer()
                    
                    Text("$" + moneyAmount.substring(toIndex: moneyAmount.length - 10))
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor.systemGreen))
                        
                }
            }
            .padding(.horizontal)
            
        }.frame(maxWidth: .infinity, maxHeight: 100)
    }
}

struct PayoutsCell_Previews: PreviewProvider {
    static var previews: some View {
        PayoutsCell(state: "Received", date: "OCT 20, 2019, 12:03 AM", ethAmount: "1.4000 ETH", moneyAmount: "4464,4 USD").previewLayout(.fixed(width: 400, height: 100))
    }
}
