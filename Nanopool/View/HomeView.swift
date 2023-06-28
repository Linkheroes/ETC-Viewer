//
//  HomeView.swift
//  Nanopool
//
//  Created by Alexandre Ricard on 16/08/2021.
//

import SwiftUI

struct Response: Codable {
    var status: Bool
    var data: Results
}

struct Results: Codable {
    var account: String
    var unconfirmed_balance: String
    var balance: String
    var hashrate: String
    var avgHashrate: Hashrate
    var workers: [Workers]
}

struct Hashrate: Codable {
    var h1: String
    var h3: String
    var h6: String
    var h12: String
    var h24: String
}

struct Workers: Codable {
    var id: String
    var uid: Int
    var hashrate: String
    var lastshare: Int
    var rating: Int
}

struct HomeView: View {
    @State private var walletID = UserDefaults.standard.string(forKey: "walletID")
    
    @State var showingWorkers: Bool = false
    @State var showingPayout: Bool = false
    
    @State var unconfirmedBalanceString: String = "0.000"
    @State var currentBalance: String = "0.000"
    @State var currentBalanceUSD: String = "0.00"
    
    @State var progressValue: Float = 0.0
    @State var progressText: String = ""
    
    @State var currentHasrate: String = ""
    
    @State var payout: Double = 0.2
    @State var currentETHUSD: Double = 0.0
    @State var currentETHEUR: Double = 0.0
    
    @State var totalPaymentETH: String = "0.000"
    @State var totalPaymentUSD: String = "0.00"
    @State var totalPaymentETHS: Double = 0.00
    
    @State var ETH: String = ""
    @State var playAnime = false
    @State var degree = 0.0
    
    @State private var workers = [Workers]()
    @State private var paymentCount = [PaymentResult]()
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color(UIColor.secondarySystemBackground)).ignoresSafeArea()
            VStack() {
                HStack() {
                    Text("ETC Stat viewer")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 25, weight: .black, design: .rounded))
                        .rotationEffect(.degrees(self.degree))
                        .onTapGesture {
                            self.playAnime.toggle()
                            self.loadCurrentETHPrice()
                        }
                        .onChange(of: self.playAnime) { newValue in
                            withAnimation(.linear(duration: 1).speed(1)) {
                                self.degree = 360
                                self.playAnime.toggle()
                            }
                        }
                }
                .padding([.all], 20.0)
                
                HStack() {
                    ZStack() {
                        Rectangle().fill(Color(UIColor.tertiarySystemBackground)).frame(maxWidth: .infinity, maxHeight: 100).cornerRadius(12.5)
                        
                        VStack() {
                            HStack() {
                                Text("UNCONFIRMED BALANCE".translate())
                                    .font(.caption2)
                                    .foregroundColor(Color(UIColor.systemGray))
                                    .padding(.leading)
                                Spacer()
                            }
                            
                            HStack() {
                                HStack() {
                                    Text(unconfirmedBalanceString.substring(toIndex: 6) + " ETC")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                            }.padding(.leading)
                            
                            HStack() {
                                Text(self.unconfirmedBalanceString.substring(toIndex: 5) + "$".translate())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(UIColor.systemGreen))
                                    .padding(.trailing)
                                
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
                                Text("BALANCE".translate())
                                    .font(.caption2)
                                    .foregroundColor(Color(UIColor.systemGray))
                                    .padding(.leading)
                                Spacer()
                            }
                            
                            HStack() {
                                HStack() {
                                    Text(self.currentBalance.substring(toIndex: 6) + " ETC")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                            }.padding(.leading)
                            
                            HStack() {
                                Text(self.currentBalanceUSD.substring(toIndex: 5) + "$".translate())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(UIColor.systemGreen))
                                    .padding(.trailing)
                                
                                Spacer()
                            }.padding(.leading)
                        }
                    }
                    .padding(.trailing)
                }
                
                ProgressBar(progressValue: self.progressValue, text: self.progressText).padding(.horizontal).frame(maxWidth: .infinity, maxHeight: 35)
                
                HStack() {
                    Text("Worker(s)".translate())
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding(.leading, 20.0)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 10) {
                        ForEach(workers, id: \.uid) { workers in
                            
                            Button {
                                self.showingWorkers.toggle()
                            } label: {
                                if workers.hashrate != "0.0" {
                                    WorkersCell(isOnline: true, workerName: workers.id)
                                }else {
                                    WorkersCell(isOnline: false, workerName: workers.id)
                                }
                            }.sheet(isPresented: $showingWorkers){
                                //let unixTimeStamp: Double = Double(workers.lastshare) / 1000.0
                                let exactDate = Date.init(timeIntervalSince1970: TimeInterval(workers.lastshare))
                                
                                WorkersView(rigName: workers.id, mHasrate: workers.hashrate, rating: String(workers.rating), lSeen: timeAgoSince(exactDate))
                            }
                        }
                    }.padding(.horizontal)
                }.frame(maxWidth: .infinity, maxHeight: 70)

                HStack() {
                    Text("Wallet".translate())
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(String(paymentCount.count) + " " + "payment(s)".translate())
                        .font(.caption)
                        .foregroundColor(Color(UIColor.systemGray))
                    
                    Spacer()
                }
                .padding(.leading, 20.0)
                
                Button {
                    self.showingPayout.toggle()
                } label: {
                    ZStack {
                        Rectangle().fill(Color(UIColor.tertiarySystemBackground)).frame(maxWidth: .infinity, maxHeight: 60).cornerRadius(15)
                        
                        HStack() {
                            VStack() {
                                HStack() {
                                    
                                    Image("ETHCard").resizable().frame(width: 40, height: 25).cornerRadius(6.25)
                                    
                                    Text("View wallet").bold()
                                        .foregroundColor(Color(UIColor.systemGray))
                                    
                                    
                                    
                                }
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right").foregroundColor(Color(UIColor.label))
                        }
                        .padding(.horizontal)
                    }
                    .padding(.horizontal)
                }.sheet(isPresented: $showingPayout){
                    PayoutsView(usd: currentETHUSD, eur: currentETHEUR)
                }


                Spacer()
                
                Text("1 ETC = " + self.ETH + "$".translate() ).foregroundColor(Color(UIColor.systemGray)).font(.caption2)
                
                Text(walletID!).foregroundColor(Color(UIColor.systemGray)).font(.caption2)
            }
        }.onAppear(perform: loadCurrentETHPrice)
    }
    
    func loadCurrentETHPrice() {
        guard let url = URL(string: "https://api.nanopool.org/v1/etc/prices") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            var result: currentETHBalance?
            do {
                result = try JSONDecoder().decode(currentETHBalance.self, from: data)
            }
            catch {
                print("Failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            self.currentETHUSD = json.data.price_usd
            self.currentETHEUR = json.data.price_eur
            
            self.loadUserSetting()
            
        }.resume()
    }
    
    func loadUserSetting() {
        
        guard let url = URL(string: "https://api.nanopool.org/v1/etc/usersettings/" + walletID!) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            var result: userSettings?
            do {
                result = try JSONDecoder().decode(userSettings.self, from: data)
            }
            catch {
                print("Failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            self.payout = json.data.payout
            
            self.loadData()
            
        }.resume()
    }
    
    func loadData() {
            guard let url = URL(string: "https://api.nanopool.org/v1/etc/user/" + walletID!) else {
                print("Invalid URL")
                return
            }
        
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("something went wrong")
                    return
                }
                
                var result: Response?
                do {
                    result = try JSONDecoder().decode(Response.self, from: data)
                }
                catch {
                    print("Failed to convert \(error.localizedDescription)")
                }
                
                guard let json = result else {
                    return
                }
                
                self.unconfirmedBalanceString = json.data.unconfirmed_balance.substring(toIndex: json.data.unconfirmed_balance.length - 4)
                self.currentBalance = json.data.balance.substring(toIndex: json.data.balance.length - 4)
                
                self.currentHasrate = json.data.hashrate
                
                if Locale.current.languageCode == "fr" {
                    let balanceInt = Float(json.data.balance)
                    
                    self.currentBalanceUSD = String(balanceInt!*Float(self.currentETHEUR))
                    
                    self.ETH = String(self.currentETHEUR)
                    
                    let balanceFloat = Float(json.data.balance)
                    
                    self.progressValue = balanceFloat!/Float(self.payout)
                    
                    self.progressText = String(self.progressValue*100).substring(toIndex: 5) + "% sur " + String(self.payout) + " ETC"
                    
                }else {
                    let balanceInt = Float(json.data.balance)
                    
                    self.ETH = String(self.currentETHUSD)
                    
                    self.currentBalanceUSD = String(balanceInt!*Float(self.currentETHUSD))
                    
                    let balanceFloat = Float(json.data.balance)
                    
                    self.progressValue = balanceFloat!/Float(self.payout)
                    
                    self.progressText = String(self.progressValue*100).substring(toIndex: 5) + "% of " + String(self.payout) + " ETC"
                    
                }
                let balanceInt = Float(json.data.balance)
                
                print(json.data.workers)
                
                self.workers = json.data.workers
                
                loadDatas()
                
            }.resume()
        }
    
    func loadDatas() {
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
                
                self.paymentCount = json.data
                
                for paymentCount in paymentCount {
                    self.totalPaymentETHS = self.totalPaymentETHS + paymentCount.amount
                }
                
                if Locale.current.languageCode == "fr" {
                    self.totalPaymentUSD = String(self.totalPaymentETHS*self.currentETHEUR)
                }else {
                    self.totalPaymentUSD = String(self.totalPaymentETHS*self.currentETHUSD)
                }
            }.resume()
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func translate() -> String {
        return NSLocalizedString(self, tableName: "Translation", bundle: .main, value: self,  comment: self)
    }
}
