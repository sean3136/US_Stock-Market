
//
// ContentView.swift
// Stock Market
//
// Created by 李炘杰 on 2022/12/27.
//

import SwiftUI

struct ContentView: View {
    @State var symbol = ""
    @State private var items = [bestMatch]()
    var body: some View {
        NavigationView(){
            NavigationLink {
                ShowData(inputsymbol: symbol)
            } label: {
                List {
                    if let items {
                        ForEach(items, id: \.self) { item in
                            HStack {
                                Text(item.symbol)
                                Spacer()
                                Text(item.name).searchCompletion(item.name)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                symbol = item.symbol
                            }
                        }
                    }
                }
                .searchable(text: $symbol, placement: .navigationBarDrawer(displayMode: .always)){
                }
                .onChange(of: symbol){ symbol in
                    showSuggestion()
                }
                .onAppear(){
                    showSuggestion()
                }
            }
        }
        
    }
    func showSuggestion() {
        let apikey = "ONRFZBO0SB78ILH6"
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(symbol)&apikey=\(apikey)"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) {data, response, error in
                if let data {
                    let decoder = JSONDecoder()
                    do {
                        let matchdata = try decoder.decode(BestMatch.self, from: data)
                        items = matchdata.bestMatchs
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(symbol: "")
    }
}
