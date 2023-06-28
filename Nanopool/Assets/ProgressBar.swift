//
//  ProgressBar.swift
//  Nanopool
//
//  Created by Alexandre Ricard on 16/08/2021.
//

import SwiftUI

struct ProgressBar: View {
    var progressValue: Float = 0.0
    var text: String = ""
        
        var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                        .opacity(0.5)
                        .foregroundColor(Color(UIColor.tertiarySystemBackground))
                    
                    Rectangle().frame(width: min(CGFloat(self.progressValue)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color(UIColor.systemGreen))
                        .animation(.linear)
                    
                    Text(text)
                        .fontWeight(.bold).frame(maxWidth: .infinity, maxHeight: 40)
                }.cornerRadius(5.0)
            }
        }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progressValue: 0.1, text: "test").frame(maxWidth: .infinity, maxHeight: 40)
    }
}
