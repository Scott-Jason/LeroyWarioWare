//
//  doomScroll.swift
//  LeroyWarioWare
//
//  Created by Jason Scott on 3/23/24.
// gonna try to set this file up as more of a generic blueprint for other microgames
//

// add the win screen and funny max face and a label and transition. pretty good
// maybe mess with the sum amount needed for it to be deleted

import SpriteKit
import GameplayKit

class doomScroll: SKScene {
    
    var sum = 0
    var initialTouchLocation: CGPoint?
    var currentTouchLocation: CGPoint?
    
    var lock = false
    var whichScreen = 0
    
    var screen = SKSpriteNode()
    var screen2 = SKSpriteNode()
    var screen3 = SKSpriteNode()
    var hitScreen = false
    var hand = SKSpriteNode()
    var hitbox = SKSpriteNode()
 //   let customFont = UIFont(name: "wariofont", size: 16.0)// check if this works
    let label = SKLabelNode(fontNamed: "WarioWare,Inc.MegaMicrogame$Big")
  

    var sx = 380
    var sy = 170
    var sm = 7
    var dy = 0
    
    
    override func sceneDidLoad(){
        makeBackground()
        makeFeature()
        makeFeature2()
        makeFeature3()
        makeFeature4()
        //makeFeature()
     //   makeFeature();
      //  makeSoy();
        
        
        
        
    }
    
    override func didMove(to view: SKView) {
        
     
    }

    

    
    func touchDown(atPoint pos : CGPoint) {
     
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        initialTouchLocation = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
      
        // Calculate the difference in the Y direction
        
        //this needs to be fixed
        let deltaY = touchLocation.y - previousLocation.y
        sum += Int(deltaY)
        print(sum)
        sy += sum / 10
        
        if(sum > 90 && lock == false){
            lock = true
            switch whichScreen{
                case 0:
                    screen.removeFromParent()
                case 1:
                    screen2.removeFromParent()
                case 2:
                    screen3.removeFromParent()
                default:
                    var id = 3
            }
           whichScreen += 1
            sx = 380
            sy = 170
            sum = 0
            
           
        }
        

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        sum = 0
        sx = 380
        sy = 170
        lock = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        hand.position = CGPoint(x:sx + 230, y:sy - 100)
        switch whichScreen {
        case 0:
            screen.position = CGPoint(x:sx, y:sy)
        case 1:
            screen2.position = CGPoint(x:sx, y:sy)
        case 2:
            screen3.position = CGPoint(x:sx, y:sy)
        default:
            var _ = 1
        }
        
        //game goes back to menu hud
        
    
        
        
        
    }
    
    
    func makeBackground(){
        let background = SKSpriteNode(imageNamed: "phone")
        background.position = CGPoint(x: 400, y: 200) //where its at
        background.zPosition = 0 //kind of like layers in photoshop 0 furthest back 100000 foreground
        background.xScale = 0.37
        background.yScale = 0.23
        addChild(background)
        
        let topPhone = SKSpriteNode(imageNamed: "phonetop")
        topPhone.position = CGPoint(x: 400, y: 365) //where its at
        topPhone.zPosition = 5 //kind of like layers in photoshop 0 furthest back 100000 foreground
        topPhone.xScale = 0.37
        topPhone.yScale = 0.23
        addChild(topPhone)
      
    
        
        /*
        label.position = CGPoint(x: 380, y: 190)
        label.fontSize = 50
        label.zPosition = 30
        label.fontName = "WarioWare,Inc.MegaMicrogame$Big"
        label.text = "Squirt!"
        addChild(label) */
      
    }
    
    func makeFeature(){
        //this will be hand that scrolls
        hand = SKSpriteNode(imageNamed:"hand")
        hand.position = CGPoint(x: sx, y: sy)
        hand.zPosition = 5
        hand.zRotation = 30
        hand.xScale = -0.75
        hand.yScale = -0.65
        addChild(hand)
    }
    
    func makeFeature2(){
        //this will be the screen
        screen = SKSpriteNode(imageNamed: "eefoc")
        screen.position = CGPoint(x: sx, y: sy)
        screen.zPosition = 3
        screen.xScale = 0.4
        screen.yScale = 0.4
        addChild(screen)
    }
    func makeFeature3(){
        //this will be the screen
        screen2 = SKSpriteNode(imageNamed: "buoy")
        screen2.position = CGPoint(x: sx, y: sy)
        screen2.zPosition = 2
        screen2.xScale = 0.26
        screen2.yScale = 0.25
        addChild(screen2)
    }
    func makeFeature4(){
        //this will be the screen
        screen3 = SKSpriteNode(imageNamed: "pizza")
        screen3.position = CGPoint(x: sx, y: sy)
        screen3.zPosition = 1
        screen3.xScale = 0.96
        screen3.yScale = 0.9
        addChild(screen3)
    }
}


