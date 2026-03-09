//
//  CoinsViewModel.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.
//
import Foundation
import Combine
import SwiftData

class CoinsViewModel {
    //TODO: TEST HERE
    @Published var coins: [CoinWrapper] = [] {
        didSet {
            getBalance()
        }
    }
    @Published var filteredCoins: [CoinWrapper] = []
    @Published var totalBalance: Double = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    private let serviceManager: ServiceManagerProtocol

    var user: User?
    

    init(serviceManager: ServiceManagerProtocol = ServiceManager()) {
        self.serviceManager = serviceManager
        fetchCoins()
        getData()
    }
    
    func getBalance() {
        totalBalance = 0.0
        if let coins = user?.coins {
            for coin in coins {
                if coin.name == "usd" {
                    totalBalance += coin.amount
                }else {
                    let coinFind = findCoin(byName: coin.name, in: self.coins)
                    if let coinFind {
                        totalBalance += (Double(coinFind.price) ?? 0.0) * coin.amount
                    }
                }
            }
        }
    }
    
//    TODO: TEST HERE
    func getData() {
        Task {
            user = await DataController.shared.fetchUser()
        }
    }
        
    
    //TODO: TEST HERE
    func fetchCoins() {
        serviceManager.fetchCoins(
            completion: { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let coins):
                        self?.coins = coins
                        self?.filteredCoins = coins
                    case .failure(let error):
                        print(error)
                    }
                }
            },
            filter: "USDT"
        )
    }
    
    func filterCoins(with searchText: String) {
        if searchText.isEmpty {
            filteredCoins = coins
        } else {
            filteredCoins = coins.filter { $0.symbol.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    private func findCoin(byName name: String, in coins: [Coin]) -> Coin? {
        return coins.first { $0.name == name }
    }
    
    private func findCoin(byName name: String, in coins: [CoinWrapper]) -> CoinWrapper? {
        return coins.first { $0.symbol == name }
    }
}
