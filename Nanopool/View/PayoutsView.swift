//
//  PayoutsView.swift
//  Nanopool
//
//  Created by Alexandre Ricard on 17/08/2021.
//

import SwiftUI

struct Payment: Codable {
    var status: Bool
    var data: [PaymentResult]
}

struct PaymentResult: Codable {
    var date: Int
    var amount: Double
    var confirmed: Bool
}

struct PayoutsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var walletID = UserDefaults.standard.string(forKey: "walletID")
    
    @State private var payment = [PaymentResult]()
    
    @State private var noPayment: Bool = false
    
    @State private var totalETH: Double = 0.0
    
    @State private var totalUSD: String = ""
    
    var usd: Double = 0.0
    
    var eur: Double = 0.0
    
    var body: some View {
        ZStack() {
            Rectangle().fill(Color(UIColor.secondarySystemBackground)).ignoresSafeArea()
            
            VStack() {
                HStack() {
                    Text("Wallet")
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
                
                Image("ETHCard")
                    .resizable()
                    .frame(width: 320, height: 200)
                    .cornerRadius(25)
                    .scaledToFill()
                
                HStack() {
                    ZStack() {
                        Rectangle().fill(Color(UIColor.tertiarySystemBackground)).frame(maxWidth: .infinity, maxHeight: 75).cornerRadius(12.5)
                        
                        VStack(alignment: .leading) {
                            Text("Total ETC").font(.caption2).foregroundColor(Color(UIColor.systemGray))
                            
                            Text(String(self.totalETH).substring(toIndex: 5) + " ETC").bold()
                        }.frame(maxWidth: .infinity, maxHeight: 75)
                    }.frame(maxWidth: .infinity, maxHeight: 75).padding(.horizontal)
                    
                    ZStack() {
                        Rectangle().fill(Color(UIColor.tertiarySystemBackground)).frame(maxWidth: .infinity, maxHeight: 75).cornerRadius(12.5)
                        
                        VStack(alignment: .leading) {
                            Text("Total balance").font(.caption2).foregroundColor(Color(UIColor.systemGray))
                            
                            Text("$" + String(self.totalUSD).substring(toIndex: 8)).bold().foregroundColor(Color(UIColor.systemGreen))
                        }.frame(maxWidth: .infinity, maxHeight: 75)
                    }.frame(maxWidth: .infinity, maxHeight: 75).padding(.horizontal)
                }.padding([.leading, .trailing, .top])
                
                if noPayment {
                    ZStack {
                        Rectangle().fill(Color(UIColor.secondarySystemBackground))
                        
                        VStack() {
                            Text("You have not received any payment".translate()).fontWeight(.bold).multilineTextAlignment(.center).font(.title).foregroundColor(Color(UIColor.tertiaryLabel))
                        }
                    }
                }else {
                    ScrollView() {
                        VStack() {
                            ForEach(payment, id: \.date) { payment in
                                
                                let exactDate = Date.init(timeIntervalSince1970: TimeInterval(payment.date))
                                
                                let moneyAmout = String(payment.amount*self.usd)
                                
                                if payment.confirmed {
                                    PayoutsCell(state: "Confirmed".translate(), date: timeAgoSince(exactDate).translate(), ethAmount: String(payment.amount), moneyAmount: moneyAmout)
                                        .padding(.horizontal)
                                        .frame(height: 80.0)
                                }else {
                                    PayoutsCell(state: "Pending".translate(), date: timeAgoSince(exactDate).translate(), ethAmount: String(payment.amount), moneyAmount: moneyAmout)
                                        .padding(.horizontal)
                                        .frame(height: 80.0)
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
            guard let url = URL(string: "https://api.nanopool.org/v1/etc/payments/" + walletID!) else {
                print("Invalid URL")
                return
            }
        
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("something went wrong")
                    return
                }
                
                var result: Payment?
                do {
                    result = try JSONDecoder().decode(Payment.self, from: data)
                }
                catch {
                    print("Failed to convert \(error.localizedDescription)")
                }
                
                guard let json = result else {
                    return
                }
                
                print(json.data)
                
                
                if json.data.isEmpty {
                    self.noPayment = true
                }else {
                    self.payment = json.data
                    self.noPayment = false
                }
                
                for payment in payment {
                    self.totalETH = self.totalETH + payment.amount
                }
                
                self.totalUSD = String(self.totalETH*self.usd)
            }.resume()
        }
}

struct PayoutsView_Previews: PreviewProvider {
    static var previews: some View {
        PayoutsView(usd: 0.0, eur: 0.0)
    }
}
