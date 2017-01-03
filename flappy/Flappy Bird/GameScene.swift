//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Rob Percival on 22/08/2014.
//  Copyright (c) 2014 Appfish. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var score = 0
    
    let music: SKAudioNode = SKAudioNode(fileNamed: "img/mp.mp3")
    
    
    
    var scoreLabel = SKLabelNode()
    var gameOverLabel = SKLabelNode()
    
    
    
    var bird = SKSpriteNode()
    var bg = SKSpriteNode()
    var labelHolder = SKSpriteNode()
    
    let birdGroup: UInt32 = 2
    
    let objectGroup: UInt32 = 3
    
    let gapGroup: UInt32 = 0
    
    var gameOver = 0
    
    var movingObjects = SKNode()
    
    
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        
        //set ost 
        addChild(music)
        
        music.positional = true
        
        music.position = CGPoint(x: -1024, y: 0)
        
        let to1 = CGPoint(x: 1024, y: 0)
        
        let to2 = CGPoint(x: -1024, y: 0)
        
        let moveForward = SKAction.moveTo(to1, duration: 2)
        let moveBack = SKAction.moveTo(to2, duration: 2)
        
        let sequence = SKAction.sequence([moveForward, moveBack])
        let repeatForever = SKAction.repeatActionForever(sequence)
        
        music.runAction(repeatForever)

        //set gravity
        
        self.physicsWorld.gravity = CGVectorMake(0, -5)
        
        self.addChild(movingObjects)
        
        makeBackground()
        
        self.addChild(labelHolder) // add label holder
        
        //update the score
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 70)
        scoreLabel.zPosition = 9
        self.addChild(scoreLabel)
        
        //set the bird texture
        let birdTexture = SKTexture(imageNamed: "img/flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "img/flappy2.png")
        
        let animation = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture)
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bird.runAction(makeBirdFlap)
        
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
        
        bird.physicsBody?.dynamic = true
        
        bird.physicsBody?.allowsRotation = false
        
        bird.physicsBody?.categoryBitMask = birdGroup
        
        // do something on collision with object group
        bird.physicsBody?.collisionBitMask = birdGroup //same as gap so they bird can pass through
        // contact
        bird.physicsBody?.contactTestBitMask = objectGroup
 
        
        bird.zPosition = 10
        
     
        
        
        
        self.addChild(bird)
        
        let ground = SKNode()
        
        ground.position = CGPointMake(0, 0)
        
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake( self.frame.size.width, 1))
        
        ground.physicsBody?.dynamic = false
        
        ground.physicsBody?.categoryBitMask = objectGroup

        
        self.addChild(ground)
        
        //spawn new pipes
        let timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(GameScene.makePipes), userInfo: nil, repeats: true)
        

        
        
    }
    
    //make BG
    
    func makeBackground() {
        //set background
        
        let bgTexture = SKTexture(imageNamed: "img/vaporBG.png")
        
        
        let movebg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        let replacebg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        let movebgForever = SKAction.repeatActionForever(SKAction.sequence([movebg, replacebg]))
        
        
        let fromValue = CGFloat(0.0)
        let toValue = CGFloat(3.0)
        let distance = CGFloat(1.0)
        let sequence = fromValue.stride(to: toValue, by: distance)
        
        for i:CGFloat in sequence {
            
            bg = SKSpriteNode(texture: bgTexture)
            
            
            
            bg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * i, y: self.frame.midY)
            bg.size.height = self.frame.height
            
            
            bg.runAction(movebgForever)
            
            
            movingObjects.addChild(bg)
            
        }
        
        bg.zPosition = 2

    }
    
    //mkae pipes
    func makePipes() {
        
        
        //add pipes with random height if game is not over 
        if gameOver == 0 {
       
        
        let gapHeight = bird.size.height * 4
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        
        let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        
        //move pipes left
        
        let movePipes = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: NSTimeInterval(self.frame.size.width / 100))
        
        // remove pipes from the left of the screen
        
        let removePipes = SKAction.removeFromParent()
        
        let moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])
        
        
        
        let pipeTexture1 = SKTexture(imageNamed: "img/pipe1")
        
        let pipe1 = SKSpriteNode(texture: pipeTexture1)
        
        pipe1.position = CGPoint(x: self.frame.midX + self.frame.size.width, y: self.frame.midY + pipe1.size.height / 2 + gapHeight / 2 + pipeOffset)
        
        pipe1.runAction(moveAndRemovePipes)
        
        pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipe1.size)
        
        pipe1.physicsBody?.dynamic = false
        
         pipe1.physicsBody?.categoryBitMask = objectGroup
        
           pipe1.zPosition = 5
        
        
        movingObjects.addChild(pipe1)

        
        let pipeTexture2 = SKTexture(imageNamed: "img/pipe2")
        
        let pipe2 = SKSpriteNode(texture: pipeTexture2)
        
        pipe2.position = CGPoint(x: self.frame.midX + self.frame.size.width, y: self.frame.midY - pipe2.size.height / 2 - gapHeight / 2 + pipeOffset)
        
        pipe2.runAction(moveAndRemovePipes)
        
        pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipe2.size)
        
        
        pipe2.physicsBody?.dynamic = false
        
         pipe2.physicsBody?.categoryBitMask = objectGroup
        
        pipe2.zPosition = 5
        
        movingObjects.addChild(pipe2)
            
            
            
            var gap = SKNode()
            
            gap.position = CGPoint(x: self.frame.midX + self.frame.size.width, y: self.frame.midY + pipeOffset)
            
            gap.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake( pipe1.size.width, gapHeight)) //same width as the pipe
            
            gap.runAction(moveAndRemovePipes)
            
            gap.physicsBody?.dynamic = false
            
            gap.physicsBody?.collisionBitMask = gapGroup // same as the one for the bird
            
            gap.physicsBody?.categoryBitMask = gapGroup
            
            gap.physicsBody?.contactTestBitMask = birdGroup //contact with bird
            
            movingObjects.addChild(gap)
            
        
            
             }
    }
    
    //contact function
    
    func didBeginContact(contact: SKPhysicsContact) {
     
        
        if contact.bodyA.categoryBitMask == gapGroup || contact.bodyB.categoryBitMask == gapGroup {
            
            score += 1
            
            scoreLabel.text = "\(score)"
            
        } else {
            
            if gameOver == 0 {
                
          
            
            gameOver = 1
            
            //stop all nodes in moving objects
            
            //ost stop
        
            music.runAction(SKAction.stop())
     

            
            movingObjects.speed = 0
            
            //update the score
            gameOverLabel.fontName = "Helvetica"
            gameOverLabel.fontSize = 25
            gameOverLabel.text = "Game Over ? It's all in your head .. "
            gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.midY)
            gameOverLabel.zPosition = 9
            
            labelHolder.addChild(gameOverLabel)
            
            
        }
        
  }
        
        
    }
    
    

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        if gameOver == 0 {
            
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            
            bird.physicsBody?.applyImpulse(CGVectorMake(0, 50))
        } else {
            
            score = 0
            
            scoreLabel.text = "0"
            
            movingObjects.removeAllChildren()
            
            //add bg again
            
            makeBackground()
            
            
            music.runAction(SKAction.play())
            
            //music.removeFromParent()
            
       
            
            bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
            
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            
            labelHolder.removeAllChildren() // remove game over label
            
            gameOver = 0
            
            movingObjects.speed = 1
           
            
            
            
        }
  
        
       
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
