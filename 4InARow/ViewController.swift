//
//  ViewController.swift
//  4InARow
//
//  Created by Ari Jain on 2/7/20.
//  Copyright © 2020 Arihant Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    //Array of column buttons
    @IBOutlet var colButtons: [UIButton]!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var computerImage: UIImageView!
    @IBOutlet weak var youImage: UIImageView!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var endGamePopup: UIImageView!
    
    static var chipsPlayed = 0
    var frame: Frame!
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 21))

    override func viewDidLoad() {
        frame = Frame()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        youImage.isHighlighted = true
        playAgainButton.isHidden = true
        endGamePopup.isHidden = true
    }
    
    @IBAction func play(_ sender: UIButton) {
        
        let column  = sender.tag
        if (frame.isColumnFull(column: column) == false) {
            dropChip(chip: frame.currentChip, Column: column)
            
            let result = frame.set(column: column)
            if (result == 1) {
                youWon()
                return
            } else if (result == 2) {
                youLost()
                return
            }
            
            frame.switchColor()
            ViewController.chipsPlayed += 1
            
            //Calls the computer to play
            if (frame.currentChip == Chip.green) {
                stackView.isUserInteractionEnabled = false
                youImage.isHighlighted = false
                computerImage.isHighlighted = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.opponentTurn()
                    self.stackView.isUserInteractionEnabled = true
                }
            }
        }
        if (frame.isFrameFull()) { boardFull() }
    }
        
    func opponentTurn() {
        let column = Int.random(in: 0..<7)
        if (frame.isColumnFull(column: column) == false) {
            dropChip(chip: frame.currentChip, Column: column)
            
            let result = frame.set(column: column)
            if (result == 1) {
               youWon()
               return
            } else if (result == 2) {
               youLost()
                return
            }
            
            frame.switchColor()
            ViewController.chipsPlayed += 1
            youImage.isHighlighted = true
            computerImage.isHighlighted = false
        } else if (frame.isColumnFull(column: column) == true) {
            opponentTurn()
        }
        if (frame.isFrameFull()) {
            boardFull()
            return
        }
    }

    
    func dropChip(chip: Chip, Column column: Int) {
        let row = frame.isRowAvailable(column: column)!
        let (xcoor, ycoor) = chipPosition(Column: column, Row: row)
        let imageViewObj = UIImageView(frame: CGRect(x: xcoor, y: -chipSize() * 3, width: chipSize(), height: chipSize()))
        imageViewObj.image = UIImage(named:frame.currentChipName!)
        stackView.addSubview(imageViewObj)

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations:{
            imageViewObj.frame.origin.y = ycoor
        }, completion: nil)
    }
    
    func chipPosition(Column col: Int, Row row: Int) -> (x: CGFloat, y: CGFloat) {
        let button = colButtons[col]
        let x = button.frame.midX - (chipSize() / 2)
        let y = (button.frame.maxY - chipSize() / 2) - (chipSize() * CGFloat(frame.height - row))
        return (CGFloat(x), CGFloat(y))
    }
    
    
    func chipSize() -> CGFloat {
        return min(stackView.frame.height / 6 - 16, stackView.frame.width / 7 - 16)
    }
    
    func boardFull() {
        stackView.isUserInteractionEnabled = false
        endGamePopup.image = UIImage(named: "boardFull")
        playAgainButton.isHidden = false
        endGamePopup.isHidden = false
    }
    
    func youWon() {
        stackView.isUserInteractionEnabled = false
        endGamePopup.image = UIImage(named: "youWin")
        playAgainButton.isHidden = false
        endGamePopup.isHidden = false
    }
    
    func youLost() {
        stackView.isUserInteractionEnabled = false
        endGamePopup.image = UIImage(named: "youLost")
        playAgainButton.isHidden = false
        endGamePopup.isHidden = false
    }
    
    @IBAction func playAgain(_ sender: Any) {
        ViewController.chipsPlayed = 0
               
        for view in stackView.subviews{
            if view is UIButton {
                 //Do nothing
            } else {
                view.removeFromSuperview()
            }
        }

        frame = .init()
        youImage.isHighlighted = true
        playAgainButton.isHidden = true
        endGamePopup.isHidden = true
        stackView.isUserInteractionEnabled = true
    }
    
}


