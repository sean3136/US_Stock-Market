import Foundation

struct StockResponse: Codable {
    let Metadatas: Metadata
    let TimeSeriesDailys: [String: [String: String]]
    
    enum CodingKeys:String, CodingKey {
        case Metadatas = "Meta Data"
        case TimeSeriesDailys = "Time Series (Daily)"
    }
    var stocks: [Stock]?
}

struct Metadata: Codable {
    let Information: String
    let Symbol: String
    let LastRefreshed: String
    let OutputSize: String
    let TimeZone: String
    
    enum CodingKeys: String, CodingKey {
        case Information = "1. Information"
        case Symbol = "2. Symbol"
        case LastRefreshed = "3. Last Refreshed"
        case OutputSize = "4. Output Size"
        case TimeZone = "5. Time Zone"
    }
}

struct Stock: Identifiable{
    let id = UUID()
    let date:Date
    let open: Double
    let high: Double
    let low: Double
    let close:Double
    let adjustedclose: Double
    let volume: Int
    let dividendamount:Double
    let splitcoefficient:Double
}

