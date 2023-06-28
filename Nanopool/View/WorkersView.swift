//
//  WorkersView.swift
//  Nanopool
//
//  Created by Alexandre Ricard on 16/08/2021.
//

import SwiftUI

struct WorkersView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var favoriteColor = 0
    
    var rigName: String = ""
    var mHasrate: String = ""
    var rating: String = ""
    var lSeen: String = ""
    
    var body: some View {
        ZStack() {
            Rectangle().fill(Color(UIColor.secondarySystemBackground)).ignoresSafeArea()
            
            VStack() {
                HStack() {
                    Text("Worker".translate())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        self.dismiss()
                    } label: {
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color(UIColor.systemGray))
                            .frame(width: 32, height: 32)
                    }
                    .padding(.horizontal, 20.0)
                }
                .padding(.all)
                
                HStack() {
                    ZStack() {
                        Rectangle().fill(Color(UIColor.tertiarySystemBackground)).frame(maxWidth: .infinity, maxHeight: 100).cornerRadius(12.5)
                        
                        VStack() {
                            HStack() {
                                Text("NAME".translate())
                                    .font(.caption2)
                                    .foregroundColor(Color(UIColor.systemGray))
                                    .padding(.leading)
                                Spacer()
                            }
                            
                            HStack() {
                                HStack() {
                                    Text(self.rigName)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                            }.padding(.leading)
                        }
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    ZStack() {
                        Rectangle().fill(Color(UIColor.tertiarySystemBackground)).frame(maxWidth: .infinity, maxHeight: 100).cornerRadius(12.5)
                        
                        VStack() {
                            HStack() {
                                Text("CURRENT HASHRATE".translate())
                                    .font(.caption2)
                                    .foregroundColor(Color(UIColor.systemGray))
                                    .padding(.leading)
                                Spacer()
                            }
                            
                            HStack() {
                                HStack() {
                                    Text(mHasrate + " Mh/s")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                            }.padding(.leading)
                        }
                    }
                    .padding(.trailing)
                }
                
                HStack() {
                    ZStack() {
                        Rectangle().fill(Color(UIColor.tertiarySystemBackground)).frame(maxWidth: .infinity, maxHeight: 100).cornerRadius(12.5)
                        
                        VStack() {
                            HStack() {
                                Text("RATING".translate())
                                    .font(.caption2)
                                    .foregroundColor(Color(UIColor.systemGray))
                                    .padding(.leading)
                                Spacer()
                            }
                            
                            HStack() {
                                HStack() {
                                    Text(rating)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                            }.padding(.leading)
                        }
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    ZStack() {
                        Rectangle().fill(Color(UIColor.tertiarySystemBackground)).frame(maxWidth: .infinity, maxHeight: 100).cornerRadius(12.5)
                        
                        VStack() {
                            HStack() {
                                Text("LAST SEEN".translate())
                                    .font(.caption2)
                                    .foregroundColor(Color(UIColor.systemGray))
                                    .padding(.leading)
                                Spacer()
                            }
                            
                            HStack() {
                                HStack() {
                                    Text(lSeen.translate())
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                            }.padding(.leading)
                        }
                    }
                    .padding(.trailing)
                }
                
                Spacer()
            }
        }
    }
}

struct WorkersView_Previews: PreviewProvider {
    static var previews: some View {
        WorkersView(rigName: "", mHasrate: "", rating: "", lSeen: "")
    }
}
