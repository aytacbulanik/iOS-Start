//
//  GameScene.swift
//  angryBirdGame
//
//  Created by Caner Uçar on 20.08.2018.
//  Copyright © 2018 Caner Uçar. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    //var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode()
    
    var box = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var box6 = SKSpriteNode()
    
    var gameStarted = false
    
    var originalPosition : CGPoint!
    
    enum ColliderType: UInt32 {
        case Bird = 1
        case Box = 2
    }
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        //kuşun tanımlamasını GameScene'den sürükle bırak ile yaptığımız için tekradan aşağıdaki işlemleri yapmamıza gerek yok
        let birdTexture = SKTexture(imageNamed: "bird.png")
        
        //bird
        bird = childNode(withName: "bird") as! SKSpriteNode //tasarımda yaptığımızı kod içinde tanımladık binevi
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 12) //yerçekimi
        
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.1 //kuşun kütlesi
        bird.physicsBody?.affectedByGravity = false
        
        originalPosition = bird.position
        
        //physicsBody
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame) //ekranın çerçevesini oluşturduk objeler düşmesin diye
        
        //delegate
        
        physicsWorld.contactDelegate = self
        
        
        bird.physicsBody!.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody!.collisionBitMask = ColliderType.Box.rawValue
        
        
        
        /*
        Kuşumuzu kod ile de oluşturabiliyoruz
 
        let texture2 = SKTexture(imageNamed: "bird.png")
        
        bird2 = SKSpriteNode(texture: texture2)
        bird2.position = CGPoint(x: 0, y: 0)
        bird2.size = CGSize(width: self.frame.width / 15, height: self.frame.height / 10)
        bird2.zPosition = 2
        self.addChild(bird2)
         */
        
        let boxTexture = SKTexture(imageNamed: "box.png")
        let size = CGSize(width: boxTexture.size().width / 5, height: boxTexture.size().height / 5)
        
        box = childNode(withName: "box") as! SKSpriteNode
        box.physicsBody = SKPhysicsBody(rectangleOf: size)
        box.physicsBody?.isDynamic = true
        box.physicsBody?.affectedByGravity = true
        box.physicsBody?.allowsRotation = true
        
        box.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true
        
        box2.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true
        
        box3.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true
        
        box4.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true
        
        box5.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box6 = childNode(withName: "box6") as! SKSpriteNode
        box6.physicsBody = SKPhysicsBody(rectangleOf: size)
        box6.physicsBody?.isDynamic = true
        box6.physicsBody?.affectedByGravity = true
        box6.physicsBody?.allowsRotation = true
        
        box6.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 3
        self.addChild(scoreLabel)

    }
    
    //kullanıcı ekrana dokunmaya başladığında ne olacak
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                        
                    }
                }
            }
        }
        
        
        /* Kuş Yukarı Aşağı Zıplatma
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 80))
        bird.physicsBody?.affectedByGravity = true
         */
        
     
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyB.collisionBitMask  == ColliderType.Bird.rawValue || contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue {
            
            score = score + 1
            scoreLabel.text = String(score)
            
        }
    }
    
    //kullanıcı elini koyup hareket ettirince
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                        
                    }
                }
            }
        }
       
    }
    //Dokunmalar bitince ne olacak
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                
                                let dx = -(touchLocation.x - originalPosition.x)
                                let dy = -(touchLocation.y - originalPosition.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                            }
                        }
                        
                    }
                }
            }
        }
       
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    
    //Dokunmaktan vazgeçerse
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if let birdPhysicsBody = bird.physicsBody {
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zRotation = 0
                bird.position = originalPosition
                
                score = 0
                scoreLabel.text = String(score)
                
                gameStarted = false
                
                
                
            }
        }
    }
        
    }

