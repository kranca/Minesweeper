//
//  MinesweeperTests.swift
//  MinesweeperTests
//
//  Created by Raúl Carrancá on 24/08/22.
//

import XCTest
@testable import Minesweeper

class MinesweeperTests: XCTestCase {
    
    let game = Game(width: 8, height: 8)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class and is used to clear Data that was changed or created during the test.
    }

    func testNeighboursOfMiddleLocation() throws {
//        let game = Game(width: 8, height: 8)
        let location = Location(x: 5, y: 3)
        
        XCTAssertEqual(game.neighbours(of: location).count, 8, "Expected 8 neighbouring locations")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 4, y: 2)), "Expected Location(x: 4, y: 2) to be a neighbour of Location(x: 5, y: 3)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 5, y: 2)), "Expected Location(x: 5, y: 2) to be a neighbour of Location(x: 5, y: 3)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 6, y: 2)), "Expected Location(x: 6, y: 2) to be a neighbour of Location(x: 5, y: 3)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 4, y: 3)), "Expected Location(x: 4, y: 3) to be a neighbour of Location(x: 5, y: 3)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 6, y: 3)), "Expected Location(x: 6, y: 3) to be a neighbour of Location(x: 5, y: 3)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 4, y: 4)), "Expected Location(x: 4, y: 4) to be a neighbour of Location(x: 5, y: 3)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 5, y: 4)), "Expected Location(x: 5, y: 4) to be a neighbour of Location(x: 5, y: 3)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 6, y: 4)), "Expected Location(x: 6, y: 4) to be a neighbour of Location(x: 5, y: 3)")
    }
    
    func testNeighboursOfLeftUpperCornerLocation() throws {
        let location = Location(x: 0, y: 0)
        
        XCTAssertEqual(game.neighbours(of: location).count, 3, "Expected 3 neighbouring locations")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 1, y: 0)), "Expected Location(x: 1, y: 0) to be a neighbour of Location(x: 0, y: 0)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 0, y: 1)), "Expected Location(x: 0, y: 1) to be a neighbour of Location(x: 0, y: 0)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 1, y: 1)), "Expected Location(x: 1, y: 1) to be a neighbour of Location(x: 0, y: 0)")
    }
    
    func testNeighboursOfRightLowerCornerLocation() throws {
        let location = Location(x: 7, y: 7)
        
        XCTAssertEqual(game.neighbours(of: location).count, 3, "Expected 3 neighbouring locations")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 6, y: 6)), "Expected Location(x: 6, y: 6) to be a neighbour of Location(x: 7, y: 7)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 7, y: 6)), "Expected Location(x: 7, y: 6) to be a neighbour of Location(x: 7, y: 7)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 6, y: 7)), "Expected Location(x: 6, y: 7) to be a neighbour of Location(x: 7, y: 7)")
    }
    
    func testNeighboursOfUpperSideLocation() throws {
        let location = Location(x: 3, y: 0)
        
        XCTAssertEqual(game.neighbours(of: location).count, 5, "Expected 5 neighbouring locations")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 2, y: 0)), "Expected Location(x: 2, y: 0) to be a neighbour of Location(x: 3, y: 0)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 4, y: 0)), "Expected Location(x: 4, y: 0) to be a neighbour of Location(x: 3, y: 0)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 2, y: 1)), "Expected Location(x: 2, y: 1) to be a neighbour of Location(x: 3, y: 0)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 3, y: 1)), "Expected Location(x: 3, y: 1) to be a neighbour of Location(x: 3, y: 0)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 4, y: 1)), "Expected Location(x: 4, y: 1) to be a neighbour of Location(x: 3, y: 0)")
    }
    
    func testNeighboursOfLowerSideLocation() throws {
        let location = Location(x: 4, y: 7)
        
        XCTAssertEqual(game.neighbours(of: location).count, 5, "Expected 5 neighbouring locations")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 3, y: 6)), "Expected Location(x: 3, y: 6) to be a neighbour of Location(x: 4, y: 7)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 4, y: 6)), "Expected Location(x: 4, y: 6) to be a neighbour of Location(x: 4, y: 7)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 5, y: 6)), "Expected Location(x: 5, y: 6) to be a neighbour of Location(x: 4, y: 7)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 3, y: 7)), "Expected Location(x: 3, y: 7) to be a neighbour of Location(x: 4, y: 7)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 5, y: 7)), "Expected Location(x: 5, y: 7) to be a neighbour of Location(x: 4, y: 7)")
    }
    
    func testNeighboursOfLeftSideLocation() throws {
        let location = Location(x: 0, y: 1)
        
        XCTAssertEqual(game.neighbours(of: location).count, 5, "Expected 5 neighbouring locations")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 0, y: 0)), "Expected Location(x: 0, y: 0) to be a neighbour of Location(x: 0, y: 1)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 1, y: 0)), "Expected Location(x: 1, y: 0) to be a neighbour of Location(x: 0, y: 1)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 1, y: 1)), "Expected Location(x: 1, y: 1) to be a neighbour of Location(x: 0, y: 1)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 0, y: 2)), "Expected Location(x: 0, y: 2) to be a neighbour of Location(x: 0, y: 1)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 1, y: 2)), "Expected Location(x: 1, y: 2) to be a neighbour of Location(x: 0, y: 1)")
    }
    
    func testNeighboursOfRightSideLocation() throws {
        let location = Location(x: 7, y: 6)
        
        XCTAssertEqual(game.neighbours(of: location).count, 5, "Expected 5 neighbouring locations")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 6, y: 5)), "Expected Location(x: 6, y: 5) to be a neighbour of Location(x: 7, y: 6)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 7, y: 5)), "Expected Location(x: 7, y: 5) to be a neighbour of Location(x: 7, y: 6)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 6, y: 6)), "Expected Location(x: 6, y: 6) to be a neighbour of Location(x: 7, y: 6)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 6, y: 7)), "Expected Location(x: 6, y: 7) to be a neighbour of Location(x: 7, y: 6)")
        XCTAssert(game.neighbours(of: location).contains(Location(x: 7, y: 7)), "Expected Location(x: 7, y: 7) to be a neighbour of Location(x: 7, y: 6)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
