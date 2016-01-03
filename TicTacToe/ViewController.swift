//
//  ViewController.swift
//  TicTacToe
//
//  Created by Krish Furia on 1/2/16.
//  Copyright © 2016 Krish Furia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var playAgainOutlet: UIButton!
    
    @IBAction func playAgainButton(sender: AnyObject) {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        activePlayer = 1
        
        moveCount = 0
        
        gameActive = true
        
        resultLabel.hidden = true
        
        playAgainOutlet.hidden = true
        
        resultLabel.center = CGPointMake(resultLabel.center.x - 500, resultLabel.center.y)
        
        playAgainOutlet.center = CGPointMake(playAgainOutlet.center.x - 500, playAgainOutlet.center.y)
        
        var buttonToClear : UIButton
        
        for index in 0...8 {
            buttonToClear = view.viewWithTag(index) as! UIButton
            buttonToClear.setImage(nil, forState: .Normal)
        }
    }
    
    var moveCount = 0
    
    var activePlayer = 1 // 1 == Cross and 2 == Nought
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var winningCombination = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    var gameActive = true

    @IBOutlet var button: UIButton!
    
    @IBAction func buttonPressed(sender: AnyObject) {
//        var noWinner = true Alternate AI
        if gameState[sender.tag] == 0 && gameActive {
            moveCount++
            gameState[sender.tag] = activePlayer
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "cross.png"), forState: .Normal)
                
                activePlayer = 2
//                noWinner = checkWin(sender.tag) Alternate AI
            }
            else {
                sender.setImage(UIImage(named: "nought.png"), forState: .Normal)
                activePlayer = 1
//                noWinner = checkWin(sender.tag) Alternate AI
            }
            for combination in winningCombination {
                if (gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]) {
                    
                    gameActive = false
                    
                    if gameState[combination[0]] == 1 {

                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.resultLabel.hidden = false
                            self.playAgainOutlet.hidden = false
                            self.resultLabel.center = CGPointMake(self.resultLabel.center.x + 500, self.resultLabel.center.y)
                            self.playAgainOutlet.center = CGPointMake(self.playAgainOutlet.center.x + 500, self.playAgainOutlet.center.y)
                            self.resultLabel.backgroundColor = UIColor.greenColor()
                            self.resultLabel.text = "Cross wins"
                        })
                        
                    }
                    else {
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.resultLabel.hidden = false
                            self.playAgainOutlet.hidden = false
                            self.resultLabel.center = CGPointMake(self.resultLabel.center.x + 500, self.resultLabel.center.y)
                            self.playAgainOutlet.center = CGPointMake(self.playAgainOutlet.center.x + 500, self.playAgainOutlet.center.y)
                            self.resultLabel.backgroundColor = UIColor.greenColor()
                            self.resultLabel.text = "Nought wins"
                        })
                    }
                }
            }
            if moveCount == 9 {
                self.resultLabel.hidden = false
                self.playAgainOutlet.hidden = false
                self.resultLabel.center = CGPointMake(self.resultLabel.center.x + 500, self.resultLabel.center.y)
                self.playAgainOutlet.center = CGPointMake(self.playAgainOutlet.center.x + 500, self.playAgainOutlet.center.y)
                self.resultLabel.backgroundColor = UIColor.redColor()
                self.resultLabel.text = "Its a Draw"
            }
        }
        
/*
        ******** Alternate AI *********
        if noWinner {
            if activePlayer == 1{
                resultLabel.text = "Nought Wins"
            }
            else {
                resultLabel.text = "Cross Wins"
            }
        }
*/
    }
    
/*
******** Alternate AI *********
    
    
    func checkWin(tag:Int) -> Bool {
        var noWinner = true
        if tag % 2 == 0 {
            noWinner = checkDia()
            if noWinner {
                noWinner = checkRow(tag)
                if noWinner {
                    noWinner = checkCol(tag)
                    if noWinner {
                        return false
                    }
                    else {
                        return true
                    }
                }
                else {
                    return true
                }
            }
            else {
                return true
            }
        }
        else {
            noWinner = checkRow(tag)
            if noWinner {
                noWinner = checkCol(tag)
                if noWinner {
                    return false
                }
                else {
                    return true
                }
            }
            else {
                return true
            }
        }
    }
    
    func checkDia() -> Bool{
        if gameState[0] == gameState[4] && gameState[4] == gameState[8] && gameState[8] != 0 {
            return false
        }
        else if gameState[2] == gameState[4] && gameState[4] == gameState[6] && gameState[6] != 0 {
            return false
        }
        else {
            return true
        }
    }
    
    func checkRow(tag:Int) -> Bool{
        if tag < 3 {
            if gameState[0] == gameState[1] && gameState[1] == gameState[2] && gameState[2] != 0 {
                return false
            }
            else {
                return true
            }
        }
        else if tag < 6 {
            if gameState[3] == gameState[4] && gameState[4] == gameState[5] && gameState[5] != 0 {
                return false
            }
            else {
                return true
            }
        }
        else {
            if gameState[6] == gameState[7] && gameState[7] == gameState[8] && gameState[8] != 0 {
                return false
            }
            else {
                return true
            }
        }
    }
    
    func checkCol(tag:Int) -> Bool{
        if tag == 0 || tag == 3 || tag == 6 {
            if gameState[0] == gameState[3] && gameState[3] == gameState[6] && gameState[6] != 0 {
                return false
            }
            else {
                return true
            }
        }
        else if tag == 1 || tag == 4 || tag == 7  {
            if gameState[1] == gameState[4] && gameState[4] == gameState[7] && gameState[7] != 0 {
                return false
            }
            else {
                return true
            }
        }
        else {
            if gameState[2] == gameState[5] && gameState[5] == gameState[8] && gameState[8] != 0 {
                return false
            }
            else {
                return true
            }
        }
    }

*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultLabel.hidden = true
        playAgainOutlet.hidden = true
        resultLabel.center = CGPointMake(resultLabel.center.x - 500, resultLabel.center.y)
        playAgainOutlet.center = CGPointMake(playAgainOutlet.center.x - 500, playAgainOutlet.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

