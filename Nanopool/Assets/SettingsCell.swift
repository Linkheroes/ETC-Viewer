//
//  SettingsCell.swift
//  Nanopool
//
//  Created by Alexandre Ricard on 17/08/2021.
//

import SwiftUI

struct SettingsCell: View {
    
    var settingName: String
    
    var settingIcon: String
    
    var body: some View {
        ZStack() {
            Rectangle().fill(Color(UIColor.tertiarySystemBackground)).frame(maxWidth: .infinity, maxHeight: 40).cornerRadius(15)
            
            HStack() {
                Image(settingIcon).resizable().frame(width: 32, height: 32)
                
                Text(settingName)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(UIColor.label))
                
                Spacer()
                
                Image(systemName: "chevron.right").frame(width: 32, height: 32)
                    .foregroundColor(Color(UIColor.label))
                
            }
            .padding(.horizontal)
        }.frame(maxWidth: .infinity, maxHeight: 40)
    }
}

struct SettingsCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCell(settingName: "Wallet", settingIcon: "portefeuille-ethereum").previewLayout(.fixed(width: 400, height: 40))
    }
}
