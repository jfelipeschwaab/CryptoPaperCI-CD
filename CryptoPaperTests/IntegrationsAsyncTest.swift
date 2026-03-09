//
//  IntegrationsAsyncTest.swift
//  CryptoPaperTests
//
//  Created by João Felipe Schwaab on 03/03/26.
//

import XCTest
@testable import CryptoPaper
import SwiftData

final class IntegrationsAsyncTest: XCTestCase {

    private var viewModel : CoinsViewModel!
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
    }
    
    func test_get_user_data() async throws {
        //Arrange
        let sut = CoinsViewModel()
        
        //Act
        sut.getData()
        
        try await Task.sleep(nanoseconds: 200_000_000)

        //Assert
        XCTAssertNotNil(sut.user)
        XCTAssertEqual(sut.user?.coins.first?.name, "usd")
        XCTAssertEqual(sut.user?.coins.first?.amount, 100000)
    }

//    func test_get_user_data() async throws {
//        let sut = CoinsViewModel()
//
//        await sut.getData()
//
//        XCTAssertNotNil(sut.user)
//        XCTAssertEqual(sut.user?.coins.first?.name, "usd")
//        XCTAssertEqual(sut.user?.coins.first?.amount, 100000)
//    }
}
