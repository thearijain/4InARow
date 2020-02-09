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
    static var chipsPlayed = 0
    var frame: Frame!
    var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))

    override func viewDidLoad() {
        frame = Frame()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
            //Creates the label indicating who's turn it is
            label.center = CGPoint(x: 800, y: 50)
            label.textAlignment = .center
            label.text = "YOUR TURN"
            label.font = label.font.withSize(22)
            view.addSubview(label)
        
    }
    
    @IBAction func play(_ sender: UIButton) {
        
        let column  = sender.tag
        if (frame.isColumnFull(column: column)) {
            dropChip(chip: frame.currentChip, Column: column)
            frame.set(column: column)
            frame.switchColor()
            ViewController.chipsPlayed += 1
            
            if (frame.currentChip == Chip.green) {
                self.label.text = "COMPUTER'S TURN"
                //Allows code to run after 1 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.opponentTurn()
                }
            }
            //opponentTurn()
        }
    }
        
    func opponentTurn() {
        let column = Int.random(in: 0..<7)
        
        if (frame.isColumnFull(column: column)) {
            dropChip(chip: frame.currentChip, Column: column)
            frame.set(column: column)
            frame.switchColor()
            ViewController.chipsPlayed += 1
            label.text = "YOUR TURN"
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
}


