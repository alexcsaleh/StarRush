//
//  InGameScene.swift
//  Star Rush
//
//  Created by Alexander Saleh on 5/28/15.
//  Copyright (c) 2015 Moonwalk Studios. All rights reserved.
//

import Foundation

import SpriteKit
import UIKit
import Foundation
import AudioToolbox
import AVFoundation
import GameKit



class InGameScene: SKScene, SKPhysicsContactDelegate  {
    
    let transitionFade = SKTransition.fadeWithDuration(3.0)
    var background: SKSpriteNode
    var highscoreBar: SKSpriteNode
    var gameOver: SKSpriteNode
    var howToPlayGame: SKSpriteNode
    var lightning: SKSpriteNode

    var backgroundSpeed = 0.3
    var ball: SKSpriteNode
    let ballSpeed = 2
    var blackholeSpeed1: Double = 1.4
    var blackholeSpeed2: Double = 1.6
    var blackholeSpeed3: Double = 1.9
    var onGround = true
    var gameIsOVer = false
    var velocityY = CGFloat(0)
    var ballBaseline = CGFloat(0)
    
    // Put these in the initializer
    var blackhole1 = SKSpriteNode(imageNamed: "Blackhole1")
    var blackhole2 = SKSpriteNode(imageNamed: "Blackhole1")
    var blackhole3 = SKSpriteNode(imageNamed: "Blackhole1")
    var blackhole4 = SKSpriteNode(imageNamed: "Blackhole1")
    var blackhole5 = SKSpriteNode(imageNamed: "Blackhole1")
    var blackhole6 = SKSpriteNode(imageNamed: "Blackhole1")
    var blackholeHorizontal1 = SKSpriteNode(imageNamed: "Blackhole2")
    var blackholeHorizontal2 = SKSpriteNode(imageNamed: "Blackhole2")
    
    // Create image set for iphone 6 to change texture size
    var blackhole1Sktexture = SKTexture(imageNamed: "Blackhole1")
    var blackhole2Sktexture = SKTexture(imageNamed: "Blackhole1")
    var blackhole3Sktexture = SKTexture(imageNamed: "Blackhole1")
    var blackhole4Sktexture = SKTexture(imageNamed: "Blackhole1")
    var blackhole5Sktexture = SKTexture(imageNamed: "Blackhole1")
    var blackhole6Sktexture = SKTexture(imageNamed: "Blackhole1")
    var blackholeHorizontal1Sktexture = SKTexture(imageNamed: "Blackhole2")
    var blackholeHorizontal2Sktexture = SKTexture(imageNamed: "Blackhole2")
    
    var blackhole1Animation = [SKTexture]()
    var blackhole1AnimationIphone6Plus = [SKTexture]()
    var blackhole2Animation = [SKTexture]()
    var blackhole2AnimationIphone6Plus = [SKTexture]()
    var blackhole3Animation = [SKTexture]()
    var blackhole3AnimationIphone6Plus = [SKTexture]()
    var blackhole4Animation = [SKTexture]()
    var blackhole4AnimationIphone6Plus = [SKTexture]()
    var blackhole5Animation = [SKTexture]()
    var blackhole5AnimationIphone6Plus = [SKTexture]()
    var blackhole6Animation = [SKTexture]()
    var blackhole6AnimationIphone6Plus = [SKTexture]()
    var blackholeHorizontalAnimation1 = [SKTexture]()
    var blackholeHorizontalAnimation1Iphone6Plus = [SKTexture]()
    var blackholeHorizontalAnimation2 = [SKTexture]()
    var blackholeHorizontalAnimation2Iphone6Plus = [SKTexture]()
    
    
    var instructionsTextures = [SKTexture]()
    var instructionTexturesIphone6Plus = [SKTexture]()
    var lightningTextures = [SKTexture]()
    
    
    
    let ballXSpeed = 36
    let blackholeMoveInSpeed = 1.35
    let highscoreBarSpeed = 3
    let GameOverSpeed = 9
    
    var musicLoop: AVAudioPlayer!
    
    
    var heightOgBlackhole: CGFloat = 0

    
    var blackholeMaxX = CGFloat(0)
    var originalBlackholePosition = CGFloat(0)
    
    let scoreText = SKLabelNode(fontNamed: "Menlo Bold")
    var speedScore = 10
    var score = 0
    var value = 1

    var blackHoleTimer = NSTimer()
    var blackholeCounter: Int = 0
    
    var InstructionTimer = NSTimer()
    var instructionCounter: Double = 0.0
    
    
    
    
    
    
    
    
    override init(size: CGSize) {
        self.howToPlayGame = SKSpriteNode(texture: SKTexture(imageNamed: "howToPlayGame1"))
        self.background = SKSpriteNode(imageNamed: "Background")
        self.highscoreBar = SKSpriteNode(imageNamed: "HighscoreBar")
        self.gameOver = SKSpriteNode(imageNamed: "GameOver")
        self.ball = SKSpriteNode(imageNamed: "Ball")
        self.lightning = SKSpriteNode(texture: SKTexture(imageNamed: "lightning0"))
        self.musicLoop = AVAudioPlayer()
        
        
        if DeviceType.IS_IPHONE_6 {
            self.howToPlayGame = SKSpriteNode(texture: SKTexture(imageNamed: "howToPlayGame1"))
            self.howToPlayGame.size.width = self.howToPlayGame.size.width * 1.172
            self.howToPlayGame.size.height = self.howToPlayGame.size.height * 1.174
            self.background = SKSpriteNode(imageNamed: "Background")
            self.background.size.width = self.background.size.width * 1.172
            self.background.size.height = self.background.size.height * 1.174
            self.highscoreBar = SKSpriteNode(imageNamed: "HighscoreBar")
            self.highscoreBar.size.width = self.highscoreBar.size.width * 1.172
            self.highscoreBar.size.height = self.highscoreBar.size.height * 1.174
            self.gameOver = SKSpriteNode(imageNamed: "GameOver")
            self.gameOver.size.width = self.gameOver.size.width * 1.172
            self.gameOver.size.height = self.gameOver.size.height * 1.174
            self.ball = SKSpriteNode(imageNamed: "Ball")
            self.ball.size.width = self.ball.size.width * 1.172
            self.ball.size.height = self.ball.size.height * 1.174
        }
        
        if DeviceType.IS_IPHONE_5 {
            self.howToPlayGame = SKSpriteNode(texture: SKTexture(imageNamed: "howToPlayGame1"))
            self.background = SKSpriteNode(imageNamed: "Background")
            self.highscoreBar = SKSpriteNode(imageNamed: "HighscoreBar")
            self.gameOver = SKSpriteNode(imageNamed: "GameOver")
            self.ball = SKSpriteNode(imageNamed: "Ball")
        }
        if DeviceType.IS_IPHONE_6P {
            
        }
        
        
        super.init(size: size)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    enum UIUserInterfaceIdiom : Int
    {
        case Unspecified
        case Phone
        case Pad
    }
    struct ScreenSize
    {
        static let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
        static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS =  UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }
    
    
    
    enum ColliderType: UInt32 {
        case Ball = 1
        case Blackhole1 = 2
        case Blackhole2 = 3
     
    }
    
    
    
    
    override func didMoveToView(view: SKView) {
        loadAllAnimations()
        loadInstructionTextures()
        runInstructions()
        playMusicLoop("Upnow.caf")
        loadPhysics()
        startBlackholeTimer()
        updateBlackholeCounter()
        loadLightningTextures()
        updateInstructionTimeCounter()
        instructionTimeUpdate()
        AnimateBlackholeAnimation()
        AnimateHorizontalBlackhole()
        
        self.heightOgBlackhole = self.blackhole1.size.height * 0.8
        
        self.blackhole1.zPosition = 1
        self.blackhole2.zPosition = 1
        self.blackhole3.zPosition = 1
        self.blackhole4.zPosition = 1
        self.blackhole5.zPosition = 1
        self.blackhole6.zPosition = 1
        
        
        self.scoreText.text = "0"
        self.scoreText.fontSize = 22.5
        self.scoreText.fontColor = UIColor.whiteColor()
        self.scoreText.position = CGPointMake(CGRectGetMinX(self.frame) - self.highscoreBar.size.width / 3.8, (CGRectGetMaxY(self.frame) - self.highscoreBar.size.height / 5))
        self.scoreText.zPosition = 6
        
        self.howToPlayGame.position = CGPointMake(CGRectGetMinX(self.frame) + self.howToPlayGame.size.width / 2, CGRectGetMinY(self.frame) + self.howToPlayGame.size.height / 2)
        
        self.lightning.position = CGPointMake(CGRectGetMinX(self.frame) + self.highscoreBar.size.width / 5.4, CGRectGetMaxY(self.frame) - self.highscoreBar.size.height / 1.55)

        
        self.blackholeHorizontal1.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) + self.blackholeHorizontal1.size.height / 2.5)
        self.blackholeHorizontal1.yScale = self.blackholeHorizontal1.yScale * -1
        self.blackholeHorizontal2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) - self.blackholeHorizontal1.size.height / 2.5)
        
        
        self.background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.ball.position = CGPointMake(CGRectGetMinX(self.frame) - self.ball.size.width, CGRectGetMidY(self.frame))
        self.ballBaseline = self.ball.position.y
        
        self.highscoreBar.position = CGPointMake(CGRectGetMinX(self.frame) - highscoreBar.size.width / 3.0, CGRectGetMaxY(self.frame) - highscoreBar.size.height / 2)
        self.highscoreBar.zPosition = 5
        
        
        
        self.blackhole1.name = "blackhole1"
        self.blackhole2.name = "blackhole2"
        self.blackhole3.name = "blackhole3"
        self.blackhole4.name = "blackhole4"
        self.blackhole5.name = "blackhole5"
        self.blackhole6.name = "blackhole6"
        
        
        //self.gameOver.runAction(SKAction.fadeOutWithDuration(0.0001))
        self.gameOver.position = (CGPointMake(CGRectGetMaxX(self.frame) + 1 * self.gameOver.size.width, CGRectGetMidY(self.frame)))
        self.gameOver.zPosition = 4
        
        self.lightning.zPosition = -4
        
        self.addChild(self.background)
        self.addChild(self.blackholeHorizontal1)
        self.addChild(self.blackholeHorizontal2)
        self.addChild(self.ball)
        self.addChild(self.lightning)
        self.addChild(self.highscoreBar)
        self.addChild(self.scoreText)
        self.addChild(self.gameOver)
        self.addChild(self.howToPlayGame)
        
        
        
    }
    
    
    func loadAllAnimations() {
        if DeviceType.IS_IPHONE_5 {
            LoadAnimation1()
            LoadAnimation2()
            LoadAnimation3()
            LoadAnimation4()
            LoadAnimation5()
            LoadAnimation6()
            LoadAnimationHorizontalBlackhole1()
            LoadAnimationHorizontalBlackhole2()
        }
        if DeviceType.IS_IPHONE_6P {
            LoadAnimation1Iphone6Plus()
            LoadAnimation2Iphone6Plus()
            LoadAnimation3Iphone6Plus()
            LoadAnimation4Iphone6Plus()
            LoadAnimation5Iphone6Plus()
            LoadAnimation6Iphone6Plus()
            LoadAnimationHorizontalBlackhole1Iphone6Plus()
            LoadAnimationHorizontalBlackhole2Iphone6Plus()
        }
    }
    
    
    func playMusicLoop(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        if(url == nil) {
            println("could not find file: \(filename)")
            return
        }
        var error: NSError? = nil
        musicLoop = AVAudioPlayer(contentsOfURL: url, error: &error)
        if musicLoop == nil {
            println("Could not create audio player: \(error!)")
            return
        }
        
        musicLoop.numberOfLoops = -1
        musicLoop.prepareToPlay()
        musicLoop.volume = 0.4
        musicLoop.play()
        
    }
    
    
    
    
    func LoadAnimation1() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimations")
        
        for i in 0...4 {
            var textureName = "blackhole_animation\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackhole1Animation.append(temp)
        }
    }
    func LoadAnimation1Iphone6Plus() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimationIphone6Plus")
        
        for i in 0...4 {
            var textureName = "blackhole_animation\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackhole1AnimationIphone6Plus.append(temp)
        }
    }

    func LoadAnimation2() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimations")
        
        for i in 0...4 {
            var textureName = "blackhole_animation\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackhole2Animation.append(temp)
        }
    }
    func LoadAnimation2Iphone6Plus() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimationIphone6Plus")
        
        for i in 0...4 {
            var textureName = "blackhole_animation\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackhole2AnimationIphone6Plus.append(temp)
        }
    }
    func LoadAnimation3() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimations")
        
        for i in 0...4 {
            var textureName = "blackhole_animation\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackhole3Animation.append(temp)
        }
    }
    func LoadAnimation3Iphone6Plus() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimationIphone6Plus")
        
        for i in 0...4 {
            var textureName = "blackhole_animation\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackhole3AnimationIphone6Plus.append(temp)
        }
    }
    func LoadAnimation4() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimations")
        
        for i in 0...4 {
            var textureName = "blackhole_animation\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackhole4Animation.append(temp)
        }
    }
    func LoadAnimation4Iphone6Plus() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimationIphone6Plus")
        
        for i in 0...4 {
            var textureName = "blackhole_animation\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackhole4AnimationIphone6Plus.append(temp)
        }
    }
    func LoadAnimation5() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimations")
        
        for i in 0...4 {
            var textureName = "blackhole_animation\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackhole5Animation.append(temp)
        }
    }
    func LoadAnimation5Iphone6Plus() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimationIphone6Plus")
        
        for i in 0...4 {
            var textureName = "blackhole_animation\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackhole5AnimationIphone6Plus.append(temp)
        }
    }
    func LoadAnimation6() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimations")
        
        for i in 0...4 {
            var textureName = "blackhole_animation\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackhole6Animation.append(temp)
        }
    }
    func LoadAnimation6Iphone6Plus() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimationIphone6Plus")
        
        for i in 0...4 {
            var textureName = "blackhole_animation\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackhole6AnimationIphone6Plus.append(temp)
        }
    }
    
    
    func AnimateBlackholeAnimation() {
        if DeviceType.IS_IPHONE_5 {
            blackhole1.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackhole1Animation, timePerFrame: 0.02, resize: false, restore: true)), withKey: "runBlackhole1")
            blackhole2.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackhole2Animation, timePerFrame: 0.02, resize: false, restore: true)), withKey: "runBlackhole1")
            blackhole3.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackhole3Animation, timePerFrame: 0.02, resize: false, restore: true)), withKey: "runBlackhole1")
            blackhole4.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackhole4Animation, timePerFrame: 0.02, resize: false, restore: true)), withKey: "runBlackhole1")
            blackhole5.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackhole5Animation, timePerFrame: 0.02, resize: false, restore: true)), withKey: "runBlackhole1")
            blackhole6.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackhole6Animation, timePerFrame: 0.02, resize: false, restore: true)), withKey: "runBlackhole1")
        }
        if DeviceType.IS_IPHONE_6P {
            blackhole1.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackhole1AnimationIphone6Plus, timePerFrame: 0.07, resize: false, restore: true)), withKey: "runBlackhole1")
            blackhole2.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackhole2AnimationIphone6Plus, timePerFrame: 0.07, resize: false, restore: true)), withKey: "runBlackhole1")
            blackhole3.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackhole3AnimationIphone6Plus, timePerFrame: 0.07, resize: false, restore: true)), withKey: "runBlackhole1")
            blackhole4.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackhole4AnimationIphone6Plus, timePerFrame: 0.07, resize: false, restore: true)), withKey: "runBlackhole1")
            blackhole5.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackhole5AnimationIphone6Plus, timePerFrame: 0.07, resize: false, restore: true)), withKey: "runBlackhole1")
            blackhole6.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackhole6AnimationIphone6Plus, timePerFrame: 0.07, resize: false, restore: true)), withKey: "runBlackhole1")
        }
    }
    
    
    
    
    func LoadAnimationHorizontalBlackhole1() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeHorizontalAnimation")
        
        for i in 0...19 {
            var textureName = "blackhole_animationhor\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackholeHorizontalAnimation1.append(temp)
        }
    }
    func LoadAnimationHorizontalBlackhole1Iphone6Plus() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeHorizontalAnimationIphone6Plus")
        
        for i in 0...19 {
            var textureName = "blackhole_animationhor\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackholeHorizontalAnimation1Iphone6Plus.append(temp)
        }
    }
    func LoadAnimationHorizontalBlackhole2() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeAnimation")
        
        for i in 0...19 {
            var textureName = "blackhole_animationhor\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackholeHorizontalAnimation2.append(temp)
        }
    }
    func LoadAnimationHorizontalBlackhole2Iphone6Plus() {
        var loadingLeftBlack = SKTextureAtlas(named: "BlackholeHorizontalAnimationIphone6Plus")
        
        for i in 0...19 {
            var textureName = "blackhole_animationhor\(i)"
            var temp = loadingLeftBlack.textureNamed(textureName)
            blackholeHorizontalAnimation2Iphone6Plus.append(temp)
        }
    }
    
    
    func AnimateHorizontalBlackhole() {
        if DeviceType.IS_IPHONE_5 {
        blackholeHorizontal1.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackholeHorizontalAnimation1, timePerFrame: 0.05, resize: false, restore: true)), withKey: "runBlackhole1")
        blackholeHorizontal2.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackholeHorizontalAnimation2, timePerFrame: 0.05, resize: false, restore: true)), withKey: "runBlackhole1")
        }
        if DeviceType.IS_IPHONE_6P {
            blackholeHorizontal1.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackholeHorizontalAnimation1Iphone6Plus, timePerFrame: 0.05, resize: false, restore: true)), withKey: "runBlackhole1")
            blackholeHorizontal2.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(blackholeHorizontalAnimation2Iphone6Plus, timePerFrame: 0.05, resize: false, restore: true)), withKey: "runBlackhole1")
        }
    
    }
    
    
    
    
    
    func loadPhysics() {
        self.physicsWorld.contactDelegate = self
        
        self.ball.physicsBody = SKPhysicsBody(circleOfRadius: self.ball.size.width * 0.15)
        self.ball.physicsBody?.affectedByGravity = false
        self.ball.physicsBody?.categoryBitMask = ColliderType.Ball.rawValue
        self.ball.physicsBody?.contactTestBitMask = ColliderType.Blackhole1.rawValue
        self.ball.physicsBody?.collisionBitMask = ColliderType.Blackhole1.rawValue
        
        
        self.blackhole1.physicsBody = SKPhysicsBody(texture: blackhole1Sktexture, size: self.blackhole1.size)
        self.blackhole1.physicsBody?.dynamic = false
        self.blackhole1.physicsBody?.categoryBitMask = ColliderType.Blackhole1.rawValue
        self.blackhole1.physicsBody?.contactTestBitMask = ColliderType.Ball.rawValue
        self.blackhole1.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        
        self.blackhole2.physicsBody = SKPhysicsBody(texture: blackhole2Sktexture, size: self.blackhole2.size)
        self.blackhole2.physicsBody?.dynamic = false
        self.blackhole2.physicsBody?.categoryBitMask = ColliderType.Blackhole1.rawValue
        self.blackhole2.physicsBody?.contactTestBitMask = ColliderType.Ball.rawValue
        self.blackhole2.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        
        self.blackhole3.physicsBody = SKPhysicsBody(texture: blackhole3Sktexture, size: self.blackhole3.size)
        self.blackhole3.physicsBody?.dynamic = false
        self.blackhole3.physicsBody?.categoryBitMask = ColliderType.Blackhole1.rawValue
        self.blackhole3.physicsBody?.contactTestBitMask = ColliderType.Ball.rawValue
        self.blackhole3.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        
        self.blackhole4.physicsBody = SKPhysicsBody(texture: blackhole4Sktexture, size: self.blackhole4.size)
        self.blackhole4.physicsBody?.dynamic = false
        self.blackhole4.physicsBody?.categoryBitMask = ColliderType.Blackhole1.rawValue
        self.blackhole4.physicsBody?.contactTestBitMask = ColliderType.Ball.rawValue
        self.blackhole4.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        
        self.blackhole5.physicsBody = SKPhysicsBody(texture: blackhole5Sktexture, size: self.blackhole5.size)
        self.blackhole5.physicsBody?.dynamic = false
        self.blackhole5.physicsBody?.categoryBitMask = ColliderType.Blackhole1.rawValue
        self.blackhole5.physicsBody?.contactTestBitMask = ColliderType.Ball.rawValue
        self.blackhole5.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        
        self.blackhole6.physicsBody = SKPhysicsBody(texture: blackhole6Sktexture, size: self.blackhole6.size)
        self.blackhole6.physicsBody?.dynamic = false
        self.blackhole6.physicsBody?.categoryBitMask = ColliderType.Blackhole1.rawValue
        self.blackhole6.physicsBody?.contactTestBitMask = ColliderType.Ball.rawValue
        self.blackhole6.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        
        self.blackholeHorizontal1.physicsBody = SKPhysicsBody(texture: blackholeHorizontal1Sktexture, size: self.blackholeHorizontal1.size)
        self.blackholeHorizontal1.physicsBody?.dynamic = false
        self.blackholeHorizontal1.physicsBody?.categoryBitMask = ColliderType.Blackhole1.rawValue
        self.blackholeHorizontal1.physicsBody?.contactTestBitMask = ColliderType.Ball.rawValue
        self.blackholeHorizontal1.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
        
        
        self.blackholeHorizontal2.physicsBody = SKPhysicsBody(texture: blackholeHorizontal2Sktexture, size: self.blackholeHorizontal2.size)
        self.blackholeHorizontal2.physicsBody?.dynamic = false
        self.blackholeHorizontal2.physicsBody?.categoryBitMask = ColliderType.Blackhole1.rawValue
        self.blackholeHorizontal2.physicsBody?.contactTestBitMask = ColliderType.Ball.rawValue
        self.blackholeHorizontal2.physicsBody?.collisionBitMask = ColliderType.Ball.rawValue
    }
    
    
    
    func didBeginContact(SKPhysicsContact) {
        var defaults = NSUserDefaults()
        
        var highscore = defaults.integerForKey("highscore")
        
        
        if (score > highscore){
            defaults.setInteger(score, forKey: "highscore")
        }
         var highscoreshow = defaults.integerForKey("highscore")
        

        println("contact")
        /*let fadeIn = SKAction.fadeInWithDuration(0.01)
        let fadeOut = SKAction.fadeOutWithDuration(0.001)
        let sequenceGameOver = SKAction.sequence([fadeIn,fadeOut])
        self.gameOver.runAction(sequenceGameOver)*/
        self.gameIsOVer = true
        self.musicLoop.stop()
        var scene = MainMenu(size: self.size)
        let skView = self.view as SKView!
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        scene.size = skView.bounds.size
        scene.anchorPoint = CGPointMake(CGRectGetMidX(MainMenu().frame), CGRectGetMidY(MainMenu().frame))
        skView.presentScene(scene, transition: transitionFade)
        }
    
    func startBlackholeTimer() {
        blackHoleTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector: Selector("updateBlackholeCounter"), userInfo: nil, repeats: true)
    }
    
    func updateBlackholeCounter() {
        blackholeCounter = blackholeCounter + 1
        
        if blackholeCounter == 3 {
            randomBlackhole1StartingPosition()
            randomBlackhole2StartingPosition()
            randomBlackhole3StartingPosition()
            randomBlackhole4StartingPosition()
            randomBlackhole5StartingPosition()
            randomBlackhole6StartingPosition()
            self.addChild(self.blackhole1)
            self.addChild(self.blackhole2)
            self.addChild(self.blackhole3)
            self.addChild(self.blackhole4)
            self.addChild(self.blackhole5)
            self.addChild(self.blackhole6)
        }
    }
    
    
    func loadLightningTextures() {
        var lightningAtlas = SKTextureAtlas(named: "LightningAnimation")
        
        for i in 1...19 {
            var textureName = "lightning\(i)"
            var temp = lightningAtlas.textureNamed(textureName)
            lightningTextures.append(temp)
        }
    }
    
    func runLightning() {
        self.lightning.runAction(SKAction.animateWithTextures(lightningTextures, timePerFrame: 0.035, resize: false, restore: true), withKey: "runLightning")
        
    }
    
    
    
    
    
    func loadInstructionTextures() {
        var instructionsAtlas = SKTextureAtlas(named: "HowToPlayInstructions")
        
        for i in 1...2 {
            var textureName = "howToPlayGame\(i)"
            var temp = instructionsAtlas.textureNamed(textureName)
            instructionsTextures.append(temp)
        }
    }
    
    
    
    
    func runInstructions() {
        self.howToPlayGame.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(instructionsTextures, timePerFrame: 0.9, resize: false, restore: true)), withKey: "runInstruction")
    }

    
    func instructionTimeUpdate() {
        InstructionTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateInstructionTimeCounter"), userInfo: nil, repeats: true)
    }
    func updateInstructionTimeCounter() {
        instructionCounter++
        if instructionCounter == 5 {
            self.howToPlayGame.runAction(SKAction.fadeOutWithDuration(5))

        }
    }
   


    
    
    
    
    func randomBlackhole1StartingPosition() {
        var availableSpots:Array = [CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 2.4 * heightOgBlackhole), CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 5.4 * self.heightOgBlackhole) ]
        var randomIndex = Int(arc4random_uniform(UInt32(availableSpots.count)))
        self.blackhole1.position = availableSpots[randomIndex]
    }
    func blackHoleRunner1() {
        if blackhole1.position.x < CGRectGetMinX(self.frame) - self.blackhole1.size.width / 2 {
            var availableSpots:Array = [CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 2.4 * heightOgBlackhole), CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 5.4 * self.heightOgBlackhole) ]
            var randomIndex = Int(arc4random_uniform(UInt32(availableSpots.count)))
            self.blackhole1.position = availableSpots[randomIndex]
            self.score += 10

            
        }
    }
    func randomBlackhole5StartingPosition() {
        var availableSpots:Array = [CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width + (0.75 * self.frame.width), CGRectGetMaxY(self.frame) - 2.4 * heightOgBlackhole), CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width + (0.75 * self.frame.width), CGRectGetMaxY(self.frame) - 5.4 * self.heightOgBlackhole) ]
        var randomIndex = Int(arc4random_uniform(UInt32(availableSpots.count)))
        self.blackhole5.position = availableSpots[randomIndex]
    }
    func blackHoleRunner5() {
        
        if blackhole5.position.x < CGRectGetMinX(self.frame) - self.blackhole1.size.width / 2 {
            var availableSpots:Array = [CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 2.4 * heightOgBlackhole), CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 5.4 * self.heightOgBlackhole) ]
            var randomIndex = Int(arc4random_uniform(UInt32(availableSpots.count)))
            self.blackhole5.position = availableSpots[randomIndex]
            self.score += 10

        }
    }
    
    
    
    
    
    func randomBlackhole2StartingPosition() {
        var availableSpots:Array = [CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 3.9 * heightOgBlackhole), CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 8.4 * self.heightOgBlackhole) ]
        var randomIndex = Int(arc4random_uniform(UInt32(availableSpots.count)))
        self.blackhole2.position = availableSpots[randomIndex]
    }
    func blackHoleRunner2() {
        if blackhole2.position.x < CGRectGetMinX(self.frame) - self.blackhole2.size.width / 2  {
            var availableSpots:Array = [CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 3.9 * heightOgBlackhole), CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 8.4 * self.heightOgBlackhole) ]
            var randomIndex = Int(arc4random_uniform(UInt32(availableSpots.count)))
            self.blackhole2.position = availableSpots[randomIndex]
            self.score += 10

            
        }
    }
    func randomBlackhole4StartingPosition() {
        var availableSpots:Array = [CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width + (0.75 * self.frame.width), CGRectGetMaxY(self.frame) - 3.9 * heightOgBlackhole), CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width + (0.75 * self.frame.width), CGRectGetMaxY(self.frame) - 8.4 * self.heightOgBlackhole) ]
        var randomIndex = Int(arc4random_uniform(UInt32(availableSpots.count)))
        self.blackhole4.position = availableSpots[randomIndex]
    }
    func blackHoleRunner4() {
        
        if blackhole4.position.x < CGRectGetMinX(self.frame)  - self.blackhole1.size.width / 2/*- 0.25 * (CGRectGetMidX(self.frame))*/ {
            var availableSpots:Array = [CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 3.9 * heightOgBlackhole), CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 8.4 * self.heightOgBlackhole) ]
            var randomIndex = Int(arc4random_uniform(UInt32(availableSpots.count)))
            self.blackhole4.position = availableSpots[randomIndex]
            self.score += 10

        }
    }

    

    func randomBlackhole3StartingPosition() {
        var availableSpots:Array = [CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 6.9 * heightOgBlackhole), CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 9.9 * self.heightOgBlackhole) ]
        var randomIndex = Int(arc4random_uniform(UInt32(availableSpots.count)))
        self.blackhole3.position = availableSpots[randomIndex]
    }
    func blackHoleRunner3() {
        if blackhole3.position.x < CGRectGetMinX(self.frame) - self.blackhole3.size.width / 2 {
            var availableSpots:Array = [CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 6.9 * heightOgBlackhole), CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 9.9 * self.heightOgBlackhole) ]
            var randomIndex = Int(arc4random_uniform(UInt32(availableSpots.count)))
            self.blackhole3.position = availableSpots[randomIndex]
            self.score += 10

            
        }
    }
    
    func randomBlackhole6StartingPosition() {
        var availableSpots:Array = [CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width + (0.75 * self.frame.width), CGRectGetMaxY(self.frame) - 6.9 * heightOgBlackhole), CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width + (0.75 * self.frame.width), CGRectGetMaxY(self.frame) - 9.9 * self.heightOgBlackhole) ]
        var randomIndex = Int(arc4random_uniform(UInt32(availableSpots.count)))
        self.blackhole6.position = availableSpots[randomIndex]
    }
    
    func blackHoleRunner6() {
        if blackhole6.position.x < CGRectGetMinX(self.frame) - self.blackhole1.size.width / 2 {
            var availableSpots:Array = [CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 6.9 * heightOgBlackhole), CGPointMake(CGRectGetMaxX(self.frame) + self.blackhole1.size.width, CGRectGetMaxY(self.frame) - 9.9 * self.heightOgBlackhole) ]
            var randomIndex = Int(arc4random_uniform(UInt32(availableSpots.count)))
            self.blackhole6.position = availableSpots[randomIndex]
            self.score += 10
        }
    }
    
    
    
    
    

    
    
    
    

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
            self.velocityY = -3.1
            }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.velocityY = 3.1
    }
    
    
    
    
    
    
    func updateSpeed() {
        
        
        if score == 500 {
            self.lightning.zPosition = 0
            runLightning()
            blackholeSpeed1 = blackholeSpeed1 + 0.01
            blackholeSpeed2 = blackholeSpeed2 + 0.01
            blackholeSpeed3 = blackholeSpeed3 + 0.01
            self.backgroundSpeed  = self.backgroundSpeed + 0.01
        }
        if score == 1500 {
            runLightning()
            blackholeSpeed1 = blackholeSpeed1 + 0.012
            blackholeSpeed2 = blackholeSpeed2 + 0.012
            blackholeSpeed3 = blackholeSpeed3 + 0.012
            self.backgroundSpeed  = self.backgroundSpeed + 0.012
        }
        if score == 1000 {
            runLightning()
            blackholeSpeed1 = blackholeSpeed1 + 0.01
            blackholeSpeed2 = blackholeSpeed2 + 0.01
            blackholeSpeed3 = blackholeSpeed3 + 0.01
            self.backgroundSpeed  = self.backgroundSpeed + 0.01
        }
        if score == 2000 {
            runLightning()
            blackholeSpeed1 = blackholeSpeed1 + 0.012
            blackholeSpeed2 = blackholeSpeed2 + 0.012
            blackholeSpeed3 = blackholeSpeed3 + 0.012
            self.backgroundSpeed  = self.backgroundSpeed + 0.012
        }
        if score == 2500 {
            runLightning()
            blackholeSpeed1 = blackholeSpeed1 + 0.01
            blackholeSpeed2 = blackholeSpeed2 + 0.01
            blackholeSpeed3 = blackholeSpeed3 + 0.01
            self.backgroundSpeed  = self.backgroundSpeed + 0.01
        }
        if score == 3000 {
            runLightning()
            blackholeSpeed1 = blackholeSpeed1 + 0.012
            blackholeSpeed2 = blackholeSpeed2 + 0.012
            blackholeSpeed3 = blackholeSpeed3 + 0.012
            self.backgroundSpeed  = self.backgroundSpeed  + 0.012
        }
        if score == 3500 {
            runLightning()
            blackholeSpeed1 = blackholeSpeed1 + 0.01
            blackholeSpeed2 = blackholeSpeed2 + 0.01
            blackholeSpeed3 = blackholeSpeed3 + 0.01
            self.backgroundSpeed  = self.backgroundSpeed + 0.01
        }
        if score == 4000 {
            runLightning()
            blackholeSpeed1 = blackholeSpeed1 + 0.01
            blackholeSpeed2 = blackholeSpeed2 + 0.01
            blackholeSpeed3 = blackholeSpeed3 + 0.01
            self.backgroundSpeed  = self.backgroundSpeed + 0.01
        }
        if score == 5500 {
            runLightning()
            blackholeSpeed1 = blackholeSpeed1 + 0.01
            blackholeSpeed2 = blackholeSpeed2 + 0.01
            blackholeSpeed3 = blackholeSpeed3 + 0.01
            self.backgroundSpeed  = self.backgroundSpeed + 0.01
        }
        if score == 6500 {
            runLightning()
            blackholeSpeed1 = blackholeSpeed1 + 0.012
            blackholeSpeed2 = blackholeSpeed2 + 0.012
            blackholeSpeed3 = blackholeSpeed3 + 0.012
            self.backgroundSpeed  = self.backgroundSpeed + 0.012
        }
        if score == 8500 {
            runLightning()
            blackholeSpeed1 = blackholeSpeed1 + 0.01
            blackholeSpeed2 = blackholeSpeed2 + 0.01
            blackholeSpeed3 = blackholeSpeed3 + 0.01
            self.backgroundSpeed  = self.backgroundSpeed + 0.01
        }
        if score == 11500 {
            runLightning()
            blackholeSpeed1 = blackholeSpeed1 + 0.01
            blackholeSpeed2 = blackholeSpeed2 + 0.01
            blackholeSpeed3 = blackholeSpeed3 + 0.01
            self.backgroundSpeed  = self.backgroundSpeed + 0.01
        }

    }
    
    
    func blackholeRunners() {
        blackHoleRunner1()
        blackHoleRunner2()
        blackHoleRunner3()
        blackHoleRunner4()
        blackHoleRunner5()
        blackHoleRunner6()
    }
    
    func moveBlackholes() {
        if blackholeCounter >= 3 {
            self.blackhole1.position.x -= CGFloat(self.blackholeSpeed1)
            self.blackhole2.position.x -= CGFloat(self.blackholeSpeed2)
            self.blackhole3.position.x -= CGFloat(self.blackholeSpeed3)
            self.blackhole4.position.x -= CGFloat(self.blackholeSpeed2)
            self.blackhole5.position.x -= CGFloat(self.blackholeSpeed1)
            self.blackhole6.position.x -= CGFloat(self.blackholeSpeed3)
        }

    }
    
    
    func moveSun() {
        // Move the ball
        self.ball.position.y -= velocityY
        if self.ball.position.x <= (CGRectGetMinX(self.frame) + self.ball.size.width) {
            self.ball.position.x += CGFloat(ballSpeed)
        }

    }
    
    func rotations() {
        var degreeRotationBackground = CDouble(self.backgroundSpeed) * M_PI / 180
        var degreeRotationBall = CDouble(self.ballSpeed) * M_PI / 180
        self.background.zRotation -= CGFloat(degreeRotationBackground)
        self.ball.zRotation -= CGFloat(degreeRotationBall)
    }
    
    
    func moveInObjects() {
        if self.highscoreBar.position.x <= (CGRectGetMinX(self.frame) + self.highscoreBar.size.width / 8) {
            self.highscoreBar.position.x += CGFloat(highscoreBarSpeed)
        }
        if self.scoreText.position.x <= (CGRectGetMinX(self.frame) + self.highscoreBar.size.width / 5) {
            self.scoreText.position.x += CGFloat(highscoreBarSpeed)
        }
        
        if self.blackholeHorizontal1.position.y >= CGRectGetMaxY(self.frame) - self.blackholeHorizontal1.size.height / 4.0 {
            blackholeHorizontal1.position.y -= CGFloat(blackholeMoveInSpeed)
        }
        if self.blackholeHorizontal2.position.y <= CGRectGetMinY(self.frame) + self.blackholeHorizontal1.size.height / 4.0 {
            blackholeHorizontal2.position.y += CGFloat(blackholeMoveInSpeed)
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.scoreText.text = String(self.score)
        

        moveInObjects()
        rotations()
        moveSun()
        blackholeRunners()
        moveBlackholes()
        if score > 10 {
            speedScore = score
        }
        updateSpeed()
        
        
        
        
        if self.gameOver.position.x >= CGRectGetMidX(self.frame) {
            if self.gameIsOVer == true {
            self.gameOver.position.x -= CGFloat(GameOverSpeed)
            }
        }
    }
    
}
