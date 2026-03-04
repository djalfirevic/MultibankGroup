//
//  StockSymbol.swift
//  MultibankGroup
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import Foundation

struct StockSymbol: Identifiable, Hashable {

    // MARK: - Properties

    let id: String
    let name: String
    let description: String
    var price: Double
    var previousPrice: Double
    var priceChange: PriceChange {
        if price > previousPrice {
            return .up
        } else if price < previousPrice {
            return .down
        }
        return .unchanged
    }

    enum PriceChange {
        case up, down, unchanged
    }
}

extension StockSymbol {
    static let allSymbols: [StockSymbol] = [
        StockSymbol(id: "AAPL", name: "Apple Inc.", description: "Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide.", price: 0, previousPrice: 0),
        StockSymbol(id: "GOOG", name: "Alphabet Inc.", description: "Alphabet Inc. offers various products and platforms in the United States, Europe, the Middle East, Africa, the Asia-Pacific, Canada, and Latin America.", price: 0, previousPrice: 0),
        StockSymbol(id: "TSLA", name: "Tesla, Inc.", description: "Tesla, Inc. designs, develops, manufactures, leases, and sells electric vehicles, and energy generation and storage systems.", price: 0, previousPrice: 0),
        StockSymbol(id: "AMZN", name: "Amazon.com, Inc.", description: "Amazon.com, Inc. engages in the retail sale of consumer products, advertising, and subscription services through online and physical stores.", price: 0, previousPrice: 0),
        StockSymbol(id: "MSFT", name: "Microsoft Corporation", description: "Microsoft Corporation develops and supports software, services, devices, and solutions worldwide.", price: 0, previousPrice: 0),
        StockSymbol(id: "NVDA", name: "NVIDIA Corporation", description: "NVIDIA Corporation provides graphics and compute and networking solutions in the United States, Taiwan, China, Hong Kong, and internationally.", price: 0, previousPrice: 0),
        StockSymbol(id: "META", name: "Meta Platforms, Inc.", description: "Meta Platforms, Inc. engages in the development of products that enable people to connect and share through mobile devices, PCs, and other surfaces.", price: 0, previousPrice: 0),
        StockSymbol(id: "BRK.B", name: "Berkshire Hathaway", description: "Berkshire Hathaway Inc. engages in insurance, freight rail transportation, and utility businesses worldwide.", price: 0, previousPrice: 0),
        StockSymbol(id: "JPM", name: "JPMorgan Chase & Co.", description: "JPMorgan Chase & Co. operates as a financial services company worldwide in consumer and community banking.", price: 0, previousPrice: 0),
        StockSymbol(id: "V", name: "Visa Inc.", description: "Visa Inc. operates as a payments technology company worldwide, facilitating digital payments among consumers and merchants.", price: 0, previousPrice: 0),
        StockSymbol(id: "UNH", name: "UnitedHealth Group", description: "UnitedHealth Group Incorporated operates as a diversified health care company in the United States.", price: 0, previousPrice: 0),
        StockSymbol(id: "MA", name: "Mastercard Inc.", description: "Mastercard Incorporated is a technology company that provides transaction processing and other payment-related services.", price: 0, previousPrice: 0),
        StockSymbol(id: "HD", name: "The Home Depot, Inc.", description: "The Home Depot, Inc. operates as a home improvement retailer selling building materials and home improvement products.", price: 0, previousPrice: 0),
        StockSymbol(id: "DIS", name: "The Walt Disney Company", description: "The Walt Disney Company operates as an entertainment company worldwide across media, entertainment, and experiences.", price: 0, previousPrice: 0),
        StockSymbol(id: "NFLX", name: "Netflix, Inc.", description: "Netflix, Inc. provides entertainment services, offering TV series, documentaries, feature films, and games across various genres.", price: 0, previousPrice: 0),
        StockSymbol(id: "ADBE", name: "Adobe Inc.", description: "Adobe Inc. operates as a diversified software company worldwide, providing creative, document, and experience cloud solutions.", price: 0, previousPrice: 0),
        StockSymbol(id: "CRM", name: "Salesforce, Inc.", description: "Salesforce, Inc. provides customer relationship management technology that brings companies and customers together.", price: 0, previousPrice: 0),
        StockSymbol(id: "INTC", name: "Intel Corporation", description: "Intel Corporation designs, develops, manufactures, and sells computing and related products and technologies worldwide.", price: 0, previousPrice: 0),
        StockSymbol(id: "AMD", name: "Advanced Micro Devices", description: "Advanced Micro Devices, Inc. operates as a semiconductor company worldwide, offering processors and graphics technologies.", price: 0, previousPrice: 0),
        StockSymbol(id: "PYPL", name: "PayPal Holdings, Inc.", description: "PayPal Holdings, Inc. operates a technology platform for digital payments on behalf of merchants and consumers worldwide.", price: 0, previousPrice: 0),
        StockSymbol(id: "CSCO", name: "Cisco Systems, Inc.", description: "Cisco Systems, Inc. designs, manufactures, and sells Internet Protocol based networking and other products for communications.", price: 0, previousPrice: 0),
        StockSymbol(id: "PEP", name: "PepsiCo, Inc.", description: "PepsiCo, Inc. manufactures, markets, distributes, and sells various beverages and convenient foods worldwide.", price: 0, previousPrice: 0),
        StockSymbol(id: "AVGO", name: "Broadcom Inc.", description: "Broadcom Inc. designs, develops, and supplies various semiconductor and infrastructure software solutions.", price: 0, previousPrice: 0),
        StockSymbol(id: "COST", name: "Costco Wholesale Corp.", description: "Costco Wholesale Corporation operates membership warehouses and e-commerce websites in various countries.", price: 0, previousPrice: 0),
        StockSymbol(id: "ORCL", name: "Oracle Corporation", description: "Oracle Corporation offers products and services that address enterprise information technology environments worldwide.", price: 0, previousPrice: 0)
    ]
}
