//
//  _InARowTests.swift
//  4InARowTests
//
//  Created by Ari Jain on 2/7/20.
//  Copyright © 2020 Arihant Jain. All rights reserved.
//

import XCTest
@testable import _InARow

class _InARowTests: XCTestCase {
    var spaces = [[Chip]]()
    let width = 7
    let height = 6

    
    func testCheckBoardInitialized() {
        spaces = Array(repeating: Array(repeating: Chip.null, count: height), count: width)

        for i in 0..<height {
            for j in 0..<width {
               print(spaces[j][i], " ", terminator: "")
            }
           print("")
        }
    }
    
    func testSet() {
        spaces = Array(repeating: Array(repeating: Chip.null, count: height), count: width)
        let column = 3
        let row = 4
        spaces[column][row] = .pink
        
        for i in 0..<height {
             for j in 0..<width {
                print(spaces[j][i], " ", terminator: "")
             }
            print("")
         }
    }
    
    func testIsFrameFull() {
        
        for i in 0..<width {
            if spaces[i][0] == Chip.null {
                print (false)
            }
        }
        print (true)
    }
    
//I would have written tests for my diagonal method but running the project and creating the diagonals was more fun!

}
