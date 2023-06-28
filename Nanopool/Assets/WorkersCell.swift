//
//  WorkersCell.swift
//  Nanopool
//
//  Created by Alexandre Ricard on 16/08/2021.
//

import SwiftUI

struct WorkersCell: View {
    
    var isOnline: Bool
    
    var workerName: String
    
    var body: some View {
        ZStack() {
            Rectangle()
                .fill(Color(UIColor.tertiarySystemBackground))
                .frame(maxWidth: 64, maxHeight: 64)
                .cornerRadius(16)
            
            Text(workerName.substring(toIndex: 1)).font(.title).bold().frame(width: 20, height: 20).foregroundColor(Color(UIColor.secondaryLabel))
            
            VStack() {
                HStack() {
                    Spacer()
                    ZStack() {
                        Rectangle().fill(Color(UIColor.secondarySystemBackground)).frame(maxWidth: 20, maxHeight: 20).cornerRadius(16)
                        if isOnline {
                            Rectangle().fill(Color.green).frame(maxWidth: 16, maxHeight: 16).cornerRadius(16)
                        }else {
                            Rectangle().fill(Color.red).frame(maxWidth: 16, maxHeight: 16).cornerRadius(16)
                        }
                    }
                }
                
                Spacer()
            }
            
        }.frame(width: 70, height: 70)
    }
}

struct WorkersCell_Previews: PreviewProvider {
    static var previews: some View {
        WorkersCell(isOnline: false, workerName: "Linky")
    }
}
