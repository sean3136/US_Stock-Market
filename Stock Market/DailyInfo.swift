//
//  DailyInfo.swift
//  Stock Market
//
//  Created by 李炘杰 on 2023/1/3.
//

import SwiftUI

struct DailyInfo: View {
    @State var dailyinfo: Stock
    var body: some View {
        let result = (dailyinfo.close - dailyinfo.open) / 100.0
        VStack {
            Group {
                Text("Open\n" + String(dailyinfo.open))
                Divider()
                Text("Close\n" + String(dailyinfo.close))
                Divider()
                Text("High\n" + String(dailyinfo.high))
                Divider()
                Text("Low\n" + String(dailyinfo.low))
                Divider()
                Group {
                    Text("Adjusted close\n" + String(format: "%.2f", dailyinfo.adjustedclose))
                    Divider()
                    Text("Volume\n" + String(dailyinfo.volume))
                    Divider()
                    Text("Dividend amount\n" + String(dailyinfo.dividendamount))
                    Divider()
                    Text("Split coefficient\n" + String(dailyinfo.splitcoefficient))
                }
                HStack {
                    Text(String(format: "%.3f",result) + "%")
                        .font(.title)
                    Image(systemName: dailyinfo.open > dailyinfo.close ? "arrow.down" : "arrow.up")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                }
            }
            .multilineTextAlignment(.center)
            .font(.title3)
            
        }
        .navigationTitle("\(dailyinfo.date, style: .date)")
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(dailyinfo.open > dailyinfo.close ? Color.green : Color.red)
    }
}

struct DailyInfo_Previews: PreviewProvider {
    static var previews: some View {
        DailyInfo(dailyinfo: Stock(date: Date(), open:120.93, high:129.95, low:127.43, close:129.93, adjustedclose:129.93 ,volume:77034209 ,dividendamount:0.0, splitcoefficient:1.0))
    }
}











