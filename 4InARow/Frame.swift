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
            if spaces[i][5] == Chip.null {
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
        return isRowAvailable(column: column) != nil
    }
    
    //Sets the 2D array at a certain point to the currentChip
    func set(column: Int) {
        if let row = isRowAvailable(column: column) {
            spaces[column][row] = currentChip
            print(isWin(Row: row, Column: column, ChipColor: currentChip))
        }
        
        //PRINTOUT ARR
        for i in 0..<height {
            for j in 0..<width {
                print(spaces[j][i], "   ", terminator : "")
            }
            print(" ")
        }
        
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
        print(column, ", ", row)
        
        //Checks if atleast 7 chips have been played
        if (ViewController.chipsPlayed < 6) { print("didnt run")
            return false }
        
        //Checks right horizontally
        var count = 1
        for i in 1..<4 {
            if column + 3 > width - 1 {
                break
            }
            if spaces[column + i][row] == ChipColor {
                count += 1
            }
        }
        if count == 4 { return true }
        
        //Checks left horizontally
        count = 1
        for i in 1..<4 {
           if column - 3 < 0 {
               break
           }
           if spaces[column - i][row] == ChipColor {
               count += 1
           }
        }
        if count == 4 { return true }
        
        //Checks upward vertically
        count = 1
        for i in 1..<4 {
          if row + 3 > height - 1 {
              break
          }
          if spaces[column][row + i] == ChipColor {
              count += 1
          }
       }
       if count == 4 { return true }
        
        
        //Checks downward vertically
        count = 1
        for i in 1..<4 {
            if row - 3 < 0 {
                break
            }
            if spaces[column][row - i] == ChipColor {
                count += 1
            }
        }
        if count == 4 { return true }
        
        //Checks upright diagonol
        count = 1
        for i in 1..<4 {
            if ((column + 3 > width - 1) || (row + 3 > height - 1)) {
                break
            }
            if spaces[column + i][row + i] == ChipColor {
                count += 1
            }
        }
        if count == 4 { return true }
        
        //Checks downright diagonal
        count = 1
        for i in 1..<4 {
            if ((column + 3 > width - 1) || (row - 3 < 0)) {
                break
            }
            if spaces[column + i][row - i] == ChipColor {
                count += 1
            }
        }
        if count == 4 { return true }
        
        //Checks upleft diagonal
        count = 1
        for i in 1..<4 {
            if ((column - 3 < 0) || (row + 3 > height - 1)) {
                break
            }
            if spaces[column - i][row + i] == ChipColor {
                count += 1
            }
        }
        if count == 4 { return true }
        
        //Checks downleft diagonal
        count = 1
        for i in 1..<4 {
            if ((column - 3 < 0) || (row - 3 < 0)) {
                break
            }
            if spaces[column - i][row - i] == ChipColor {
                count += 1
            }
        }
        if count == 4 { return true }
        
        return false
    }
    
   

}
