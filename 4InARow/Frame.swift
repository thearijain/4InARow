//
//  Frame.swift
//  4InARow
//
//  Created by Ari Jain on 2/7/20.
//  Copyright © 2020 Arihant Jain. All rights reserved.
//

import UIKit

enum Chip: Int {
    case null = 0
    case pink
    case green
}

class Frame: NSObject {
    
    let width = 7
    let height = 6
    var currentChip: Chip
    var currentChipName: String!
    var playerChip: Chip = Chip.pink
    var computerChip: Chip = Chip.green
    

    //2D Backing Array
    var spaces = [[Chip]]()
    
    override init() {
        spaces = Array(repeating: Array(repeating: Chip.null, count: height), count: width)
        currentChip = Chip.pink
        currentChipName = "pinkChip"
        
        super.init()
    }
    
    //Checks if the frame is full
    func isFrameFull() -> Bool {
        for i in 0..<width {
            if spaces[i][0] == Chip.null {
                return false
            }
        }
        return true;
    }
    
    //Iterates through passed in column, checks if any row is available
    func isRowAvailable(column: Int) -> Int? {
        for row in (0..<height).reversed() {
            if spaces[column][row] == Chip.null {
                return row
            }
        }
        return nil
    }
    
    //Checks if the passed in column is full
    func isColumnFull(column: Int) -> Bool {
        return isRowAvailable(column: column) == nil
    }
    
    //Sets the 2D array at a certain point to the currentChip
    func set(column: Int) -> Int {
        if let row = isRowAvailable(column: column) {
            spaces[column][row] = currentChip
            if (isWin(Row: row, Column: column, ChipColor: currentChip)) {
                if (currentChip == .pink) {
                    return 1
                } else if (currentChip == .green) {
                    return 2
                }
            }
        }
        return 0
    }
    
    
    //Switches the chip colors
    func switchColor() {
        if (currentChip == playerChip) {
            currentChip = computerChip
            currentChipName = "greenChip"
        } else {
            currentChip = playerChip
            currentChipName = "pinkChip"
        }
    }
    
    
    //Checks if there is a win only from the most recently added chip
    func isWin(Row row: Int, Column column: Int, ChipColor: Chip) -> Bool {
        
        //Keeping count of a diagonal 4 in a row
        var count = 0
        
        //Checks if atleast 7 chips have been played
        if (ViewController.chipsPlayed < 6) { return false }
        
        //Checks the column
        for i in (0..<3) {
            if ((spaces[column][i] == ChipColor) && (spaces[column][i + 1] == ChipColor) && (spaces[column][i + 2] == ChipColor) && (spaces[column][i + 3] == ChipColor)) {
                return true
            }
        }
        
        //Checks the row 
        for i in (0..<4) {
            if ((spaces[i][row] == ChipColor) && (spaces[i + 1][row] == ChipColor) && (spaces[i + 2][row] == ChipColor) && (spaces[i + 3][row] == ChipColor)) {
                return true
            }
        }
        
        //Calls the correct check diagonal function
        //Diagonal lines intersecting in row 5
        if ((column == (height - 1 - row) + 3) || (column == row - 2)) {
            count += diagonalRow5(Row: row, Column: column, ChipColor: ChipColor)
        }
        
        //Diagonal lines intersecting in row 4
        if ((column == (height - 1 - row) + 2) || (column == row - 1)) {
            count += diagonalRow4(Row: row, Column: column, ChipColor: ChipColor)
        }
        
        //Column is 1 bigger than row
        if ((column == (height - 1 - row) + 1) || (row == column)) {
            count += diagonalRow3(Row: row, Column: column, ChipColor: ChipColor)
        }
        
        //Column = Row
        if ((column == (height - 1 - row) || (column == row + 1))) {
            count += diagonalRow2(Row: row, Column: column, ChipColor: ChipColor)
        }
        
        //Row is 1 bigger than Column
        if (column + 1 == (height - 1 - row) || (column == row + 2)) {
            count += diagonalRow1(Row: row, Column: column, ChipColor: ChipColor)
        }
        
        //Row is 2 bigger than Column
        if ((column + 2 == (height - 1 - row)) || (column == row + 3)) {
            count += diagonalRow0(Row: row, Column: column, ChipColor: ChipColor)
        }
        
        //Check for four in a row
        if (count >= 1) { return true }
        
        return false
    }
    
    //Checks a diagonal
    func diagonalRow5 (Row row: Int, Column column: Int, ChipColor: Chip) -> Int {
        if (((spaces[3][5] == ChipColor) && (spaces[4][4] == ChipColor) && (spaces[5][3] == ChipColor) && (spaces[6][2] == ChipColor)) || ((spaces[3][5] == ChipColor) && (spaces[2][4] == ChipColor) && (spaces[1][3] == ChipColor) && (spaces[0][2] == ChipColor))) {
            return 1
        }
        return 0
    }
    
    //Checks a diagonal
    func diagonalRow4 (Row row: Int, Column column: Int, ChipColor: Chip) -> Int {
        for i in 0..<2 {
            if (((spaces[2 + i][5 - i] == ChipColor) && (spaces[3 + i][4 - i] == ChipColor) && (spaces[4 + i][3 - i] == ChipColor) && (spaces[5 + i][2 - i] == ChipColor)) || ((spaces[4 - i][5 - i] == ChipColor) && (spaces[3 - i][4 - i] == ChipColor) && (spaces[2 - i][3 - i] == ChipColor) && (spaces[1 - i][2 - i] == ChipColor))) {
                return 1
            }
        }
        return 0
    }
    
    //Checks a diagonal
    func diagonalRow3 (Row row: Int, Column column: Int, ChipColor: Chip) -> Int {
        for i in 0..<3 {
            if (((spaces[1 + i][5 - i] == ChipColor) && (spaces[2 + i][4 - i] == ChipColor) && (spaces[3 + i][3 - i] == ChipColor) && (spaces[4 + i][2 - i] == ChipColor)) || ((spaces[5 - i][5 - i] == ChipColor) && (spaces[4 - i][4 - i] == ChipColor) && (spaces[3 - i][3 - i] == ChipColor) && (spaces[2 - i][2 - i] == ChipColor))) {
                return 1
            }
        }
        return 0
    }
    
    //Check a diagonal
    func diagonalRow2 (Row row: Int, Column column: Int, ChipColor: Chip) -> Int {
        for i in 0..<3 {
            if (((spaces[0 + i][5 - i] == ChipColor) && (spaces[1 + i][4 - i] == ChipColor) && (spaces[2 + i][3 - i] == ChipColor) && (spaces[3 + i][2 - i] == ChipColor)) || ((spaces[6 - i][5 - i] == ChipColor) && (spaces[5 - i][4 - i] == ChipColor) && (spaces[4 - i][3 - i] == ChipColor) && (spaces[3 - i][2 - i] == ChipColor))) {
                return 1
            }
        }
        return 0
    }
    
    //Checks a diagonal
    func diagonalRow1 (Row row: Int, Column column: Int, ChipColor: Chip) -> Int {
        for i in 0..<2 {
            if (((spaces[0 + i][4 - i] == ChipColor) && (spaces[1 + i][3 - i] == ChipColor) && (spaces[2 + i][2 - i] == ChipColor) && (spaces[3 + i][1 - i] == ChipColor)) || ((spaces[6 - i][4 - i] == ChipColor) && (spaces[5 - i][3 - i] == ChipColor) && (spaces[4 - i][2 - i] == ChipColor) && (spaces[3 - i][1 - i] == ChipColor))) {
                   return 1
               }
           }
           return 0
    }
    
    //Checks a diagonal
    func diagonalRow0 (Row row: Int, Column column: Int, ChipColor: Chip) -> Int {
        if (((spaces[0][3] == ChipColor) && (spaces[1][2] == ChipColor) && (spaces[2][1] == ChipColor) && (spaces[3][0] == ChipColor)) || ((spaces[6][3] == ChipColor) && (spaces[5][2] == ChipColor) && (spaces[4][1] == ChipColor) && (spaces[3][0] == ChipColor))){
            return 1
        }
        return 0
    }
    
   

}
