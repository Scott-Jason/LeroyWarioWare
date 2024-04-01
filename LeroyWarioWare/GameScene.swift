//
//  GameScene.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/20/24.
//

import SpriteKit
import GameplayKit

var oh = 0
//when return back here play something based off win or lose
// add sound effects for win and loss

var highScore = 0
var score = 0
var win = false
var lives = 3
var level = -2
var timerNode = SKShapeNode()
var remainingTime: CGFloat = 2.0  // Initial remaining time
var totalTime: CGFloat = 2.0  // Total time for the timer in seconds

class GameScene: SKScene {
    
    
    
    var lastGame = false
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    let label1 = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
    
    
    public var gameRunTime = 0
    let soundW = SKAction.playSoundFileNamed("levelwin", waitForCompletion: false)
    let soundL = SKAction.playSoundFileNamed("levelloss", waitForCompletion: false)
    var bone1 = SKSpriteNode()
    var bone2 = SKSpriteNode()
    var bone3 = SKSpriteNode()
    
    override func sceneDidLoad(){
      
        label1.position = CGPoint(x: 200, y: 260)
        label1.fontSize = 20
        label1.text = "Highscore: \(highScore) Score: \(score)"
        label1.zPosition = 30
        label1.fontName = "WarioWare,Inc.MegaMicrogame$Big"
        label1.fontColor = UIColor.red
        
        
        label.position = CGPoint(x: 410, y: 190)
        label.fontSize = 70
        label.zPosition = 30
        label.fontName = "WarioWare,Inc.MegaMicrogame$Big"
        label.fontColor = UIColor.magenta
        if(level < 0){
            label.text = "Ready, Set, Go!"
            label.run(soundW)
        }
        if(win && level >= 0){
            score += 1
            label.fontSize = 50
            label.text = "nice! You have \(lives) lives!!"
            label.run(soundW)
        }
        if(win == false && level >= 0){
            score += 1
            lives -= 1
            label.fontSize = 50
            label.text = "awful! You have \(lives) lives!!"
            label.run(soundL)
        }
        if(lives == 0){ //resets game loop
            score = 0
            lives = 3
            level = -2
        }
        if(score > highScore){
            highScore = score
        }
        
        makeBackground()
        print(lastGame)
        win = false
      
        addChild(label1)
        addChild(label)
        level += 1
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        gameRunTime += 1
        //random code for first time thing
        if(oh == 0){
            oh += 1
            if let view = self.view {
                // Assuming NewGameScene is the name of your new GameScene class
                let sammy = GameScene(size: view.bounds.size)
                let transition = SKTransition.fade(withDuration: 0.4)
                view.presentScene(sammy, transition: transition)
            }
        }
        
     
        
        //next game that plays
        if(gameRunTime == 50){ //when it goes to sammy  keep it on 50
            //swaps to relevant scene
            if let view = self.view {
                var nextGame: SKScene
                switch level{
                case 0:
                    nextGame = BatSwat(size: view.bounds.size)
                case 1:
                    nextGame = pullup(size: view.bounds.size)
                case 2:
                    nextGame = Coffee(size: view.bounds.size)
                case 3:
                    nextGame = Pong(size: view.bounds.size)
                case 4:
                    nextGame = doomScroll(size: view.bounds.size)
                case 5:
                    nextGame = jackBelly(size: view.bounds.size)
                case 6:
                    nextGame = SammySoy(size: view.bounds.size)
                    level = -1
                default:
                    nextGame = GameScene(size: view.bounds.size)
                }
                
                let transition = SKTransition.fade(withDuration: 0.4)
                view.presentScene(nextGame, transition: transition)
            }
        }
        
    }
    
    func makeBackground(){
        let houseTexture: [SKTexture] = [
            SKTexture(imageNamed: "house1"),
            SKTexture(imageNamed: "house2")
          ]
        
        var houseS: SKSpriteNode
    
        houseS = SKSpriteNode(texture: houseTexture[0])
        houseS.zPosition = 1
        houseS.position = CGPoint(x: 400, y: 186)
        houseS.yScale = 0.6
        houseS.xScale = 1
        addChild(houseS)
            
        //house changing pixelation on loop
        func cycling(){
            
            let cycleTime = SKAction.animate(with:houseTexture, timePerFrame: 0.2)
            let repeatForever = SKAction.repeatForever(cycleTime)
            houseS.run(repeatForever)
        }
        cycling();
        let boneTexture: [SKTexture] = [
            SKTexture(imageNamed: "bone1"),
            SKTexture(imageNamed: "bone2")
          ]
        
        bone1 = SKSpriteNode(texture: boneTexture[0])
        bone1.zPosition = 2
        bone1.position = CGPoint(x: 200, y: 80)
        bone1.yScale = 0.13
        bone1.xScale = 0.13
        
        bone2 = SKSpriteNode(texture: boneTexture[1])
        bone2.zPosition = 2
        bone2.position = CGPoint(x: 400, y: 80)
        bone2.yScale = 0.13
        bone2.xScale = 0.13
        
        bone3 = SKSpriteNode(texture: boneTexture[0])
        bone3.zPosition = 2
        bone3.position = CGPoint(x: 600, y: 80)
        bone3.yScale = 0.13
        bone3.xScale = 0.13
       
        let boneTime = SKAction.animate(with:boneTexture, timePerFrame: 0.22)
        let repeatForever1 = SKAction.repeatForever(boneTime)
        let rotateLeft = SKAction.rotate(byAngle: .pi / 4, duration: 0.2)
        let rotateRight = SKAction.rotate(byAngle: -.pi / 3, duration: 0.2)
    
        let rotateSequence = SKAction.sequence([rotateLeft, rotateRight])
        let rotateForever = SKAction.repeatForever(rotateSequence)

        bone1.run(SKAction.group([repeatForever1, rotateForever]))
        bone2.run(SKAction.group([repeatForever1, rotateForever]))
        bone3.run(SKAction.group([repeatForever1, rotateForever]))

       
        
        if(lives == 3 && level >= 0){
            addChild(bone1)
            addChild(bone2)
            addChild(bone3)
        }
        if(lives == 2 && level >= 0){
            addChild(bone1)
            addChild(bone2)
        }
        if(lives == 1 && level >= 0){
            addChild(bone1)
        }
    }
}
