//
//  ServiceManagerTests.swift
//  CryptoPaperTests
//
//  Created by João Felipe Schwaab on 03/03/26.
//

import XCTest
@testable import CryptoPaper

final class ServiceManagerTests: XCTestCase {
    
    
    private var sut : ServiceManager!

    override func setUp() {
        super.setUp()
        //Arrange - Instanciando o ServiceManager
        sut = ServiceManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    
}
