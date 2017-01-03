//
//  ViewController.swift
//  tictactoe
//
//  Created by Razvan Comsa on 12/26/16.
//  Copyright © 2016 castraea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 1 = noughts , 2 = crosses
    var moves = 0;
    var activePlayer = 1
    var gameActive = true
    var gameState = [0, 0 ,0 ,0 ,0 ,0 ,0, 0, 0]
    var winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0, 3, 6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    @IBOutlet var button: UIButton!
    
    
    @IBOutlet var gameOverLabel: UILabel!
    
    @IBOutlet var playAgainButton: UIButton!
    
    @IBAction func playAgainPressed(sender: AnyObject) {
        
        activePlayer = 1
        gameActive = true
        gameState = [0, 0, 0 ,0 ,0 ,0, 0, 0, 0]
        moves = 0
        
        var button:UIButton
        for i in 0 ..< 9  {
            button = view.viewWithTag(i) as! UIButton
            
            button.setImage(nil, forState: .Normal)
            
            gameOverLabel.hidden = true
            playAgainButton.hidden = true
            
            gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 400, gameOverLabel.center.y)
            playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y)
            
        }
        
        
    }
    
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        moves+=1
        
        
        if gameState[sender.tag] == 0 && gameActive == true {
            var image = UIImage()
            
            gameState[sender.tag] = activePlayer
            
            if activePlayer == 1 {
                
                image = UIImage(named: "nought.png")!
                activePlayer = 2
            }
            else {
                image = UIImage(named: "cross.png")!
                activePlayer = 1
            }
            
            
            sender.setImage(image, forState: .Normal)
            
            
            for combination in winningCombinations {
                var labelText = "It's a draw"
                
                if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] {
                    
                    labelText = "Noughts has won!"
                    
                    if gameState[combination[0]] == 2 {
                        labelText = "crosses has won!"
                    }
                    
                    
                    
                    gameOverLabel.text = labelText
                    
                    gameOverLabel.hidden = false
                    
                    playAgainButton.hidden = false
                    
                    UIView.animateWithDuration(0.5, animations: {
                        self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 400, self.gameOverLabel.center.y)
                        self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 400, self.playAgainButton.center.y)
                    })
                    
                    gameActive = false
                }
                    
                else {
                    if moves == 9 {
                        print("it's a draw")
                        gameOverLabel.text = labelText
                        
                        gameOverLabel.hidden = false
                        
                        playAgainButton.hidden = false
                        
                        UIView.animateWithDuration(0.5, animations: {
                            self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 400, self.gameOverLabel.center.y)
                            self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 400, self.playAgainButton.center.y)
                        })
                    }
                    
                    
                }
                
            }
            
        }
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameOverLabel.hidden = true
        playAgainButton.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 400, gameOverLabel.center.y)
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        
    }
    
    
}

