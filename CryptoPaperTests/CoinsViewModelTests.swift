//
//  CoinsViewModelTests.swift
//  CryptoPaperTests
//
//  Created by João Felipe Schwaab on 03/03/26.
//

import XCTest
@testable import CryptoPaper

final class MockServiceManager: ServiceManagerProtocol {
    
    // MARK: - Controle de comportamento
    var shouldReturnError = true
    var mockCoins: [CoinWrapper] = []
    var mockError: Error = NSError(domain: "MockError", code: 0)
    
    // MARK: - Verificações
    private(set) var fetchCoinsCalled = false
    private(set) var receivedFilter: String?
    
    func fetchCoins(
        completion: @escaping (Result<[CoinWrapper], Error>) -> Void,
        filter: String
    ) {
        fetchCoinsCalled = true
        receivedFilter = filter
        
        if shouldReturnError {
            completion(.failure(mockError))
        } else {
            completion(.success(mockCoins))
        }
    }
}

final class CoinsViewModelTests: XCTestCase {

    private var sut : CoinsViewModel!
    private var mock : MockServiceManager!
    
    override func setUp() {
        mock = MockServiceManager()
        mock.mockCoins = [CoinWrapper(symbol: "BTC", price: "20000")]
        sut = CoinsViewModel(serviceManager: mock)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_fetchCoins_whenServiceSucceeds_shouldUpdateCoins() {
        let expectation = XCTestExpectation(description: "Coins updated")
        //Arrange
        mock.shouldReturnError = false

        
        //Act
        sut.fetchCoins()
        
        DispatchQueue.main.async {
            //Assert
            XCTAssertEqual(self.sut.coins.count, 1)
            XCTAssertEqual(self.sut.coins.first?.symbol, "BTC")
            expectation.fulfill()
        }
        
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_withAsync_fetchCoins_whenServiceSucceeds_shouldUpdateCoins() async throws {
        //Arrange
        mock.shouldReturnError = false

        //Act
        sut.fetchCoins()

        try? await Task.sleep(nanoseconds: 200_000_000)

        //Assert
        XCTAssertEqual(sut.coins.count, 1)
    }
    
    
    
    
    
}

