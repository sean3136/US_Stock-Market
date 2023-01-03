//
//  ShowData.swift
//  Stock Market
//
//  Created by 李炘杰 on 2023/1/3.
//

import SwiftUI

struct ShowData: View {
    var inputsymbol: String
    @State var stockdaily = [Stock]()
    var body: some View {
        List {
            ForEach(stockdaily) { s in
                NavigationLink{
                    DailyInfo(dailyinfo: s)
                } label: {
                    HStack {
                        Text(s.date, style: .date)
                        Spacer()
                        Group {
                            Text("Open\n" + String(s.open))
                            Spacer()
                            Text("Close\n" + String(s.close))
                            Spacer()
                        }
                    }
                    .background(s.open > s.close ? Color.green : Color.red)
                    .cornerRadius(15)
                    .frame(width: 310)
                }
            }
        }.onAppear(){
            fetchStockData(symbol: inputsymbol) { stocks in
                self.stockdaily = stocks
            }
            print(inputsymbol)
        }
        .navigationTitle("\(inputsymbol)")
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        
    }
}

func fetchStockData(symbol: String, completion: @escaping ([Stock]) -> ()) {
    let apikey = "ONRFZBO0SB78ILH6"
    let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=\(symbol)&apikey=\(apikey)"
    print(urlString)
    if let url = URL(string: urlString) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data {
                do {
                    var stockResponse = try JSONDecoder().decode(StockResponse.self, from: data)
                    stockResponse.stocks = [Stock]()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    for(key, value) in stockResponse.TimeSeriesDailys{
                        let date = formatter.date(from: key)!
                        let open = Double(value["1. open"]!)!
                        let high = Double(value["2. high"]!)!
                        let low = Double(value["3. low"]!)!
                        let close = Double(value["4. close"]!)!
                        let adjustedclose = Double(value["5. adjusted close"]!)!
                        let volume = Int(value["6. volume"]!)!
                        let dividendamount = Double(value["7. dividend amount"]!)!
                        let splitcoefficient = Double(value["8. split coefficient"]!)!
                        let stock = Stock(date:date, open:open, high:high, low:low, close:close, adjustedclose:adjustedclose, volume:volume, dividendamount:dividendamount, splitcoefficient:splitcoefficient)
                        stockResponse.stocks?.append(stock)
                    }
                    stockResponse.stocks?.sort(by:{
                        $0.date > $1.date
                    })
                    completion(stockResponse.stocks!)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

struct ShowData_Previews: PreviewProvider {
    static var previews: some View {
        ShowData(inputsymbol: "QQQ")
    }
}
