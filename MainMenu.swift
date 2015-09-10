//
//  MainMenu.swift
//  Star Rush
//
//  Created by Alexander Saleh on 5/28/15.
//  Copyright (c) 2015 Moonwalk Studios. All rights reserved.
//



import SpriteKit
import UIKit
import Foundation
import AudioToolbox
import AVFoundation
import GameKit



class MainMenu: SKScene  {
    
    let background = SKSpriteNode(imageNamed: "Background")
    let highscoreButton = SKSpriteNode(imageNamed: "HighscoreButton")
    let startButton = SKSpriteNode(imageNamed: "StartButton")
    var startButtonTouch = SKSpriteNode(imageNamed: "StartButton")
    let highscoreText = SKLabelNode(fontNamed: "Menlo Bold")
    var highscoreshow = NSUserDefaults().integerForKey("highscore")
    let highscoreBar = SKSpriteNode(imageNamed: "HighscoreBarMenu")
    let infoButton = SKSpriteNode(imageNamed: "InfoButton")
    var timer = NSTimer()
    var counter: Double = 0
    var startButtonPressed = false
    var infoButtonPressed = false
    let InfoButtonMoveInSpeed = 5.8
    let buttonMovementSpeed = 12.4
    let buttonMovementSpeed2 = 16.5
    let buttonMovementSpeed3 = 7.7
    let buttonMovementSpeed4 = 13.3
    let InfoDoubleSpeed = 11.6
    let buttonMovementSpeedDouble1 = 24.8
    let buttonMovementSpeedDouble2 = 33.0
    let buttonMovementSpeedDouble3 = 15.4
    var timerValid: Bool = true
    var musicLoop: AVAudioPlayer!
    

    
    
    
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
    
    
    
    override func didMoveToView(view: SKView) {
        
        NSUserDefaults().setInteger(highscoreshow, forKey: "highscore")

        playMusicLoop("MenuStarRush.caf")
        
        self.startButtonTouch.size.height = self.startButton.size.height / 2
        self.startButtonTouch.size.width = self.startButton.size.width / 2
        self.startButtonTouch.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        self.startButton.position = CGPointMake(CGRectGetMidX(self.frame) + 2 * self.startButton.size.width, CGRectGetMidY(self.frame))
        
        self.background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(self.background)
        
        self.highscoreButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) - 2 * self.highscoreButton.size.height * 0.4)
        self.addChild(self.highscoreButton)
        
        self.infoButton.position = CGPointMake(CGRectGetMaxX(self.frame) + 2 * self.infoButton.size.width * 0.5, CGRectGetMinY(self.frame) + self.infoButton.size.height * 0.5)
        self.addChild(self.infoButton)
        
        self.highscoreBar.position = CGPointMake(CGRectGetMidX(self.frame) - 2 * self.highscoreBar.size.width / 2, CGRectGetMaxY(self.frame) - self.highscoreBar.size.height / 2)
        self.addChild(self.highscoreBar)
        
        self.highscoreText.fontColor = UIColor.whiteColor()
        self.highscoreText.text = "\(highscoreshow)"
        self.highscoreText.fontSize = 28
        self.highscoreText.position = CGPointMake(CGRectGetMidX(self.frame) - 2 * self.highscoreBar.size.width / 2, CGRectGetMaxY(self.frame) - highscoreBar.size.height / 1.63)
        self.addChild(self.highscoreText)
        
        
     
        self.addChild(self.startButton)
        
        updateCounter()
    }
    
    
    
    func moveSceneToGame() {
        var scene = InGameScene(size: self.size)
        let skView = self.view as SKView!
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        scene.size = skView.bounds.size
        scene.anchorPoint = CGPointMake(CGRectGetMidX(MainMenu().frame), CGRectGetMidY(MainMenu().frame))
        skView.presentScene(scene)
    }
    
    func moveSceneToHelp() {
        var scene = HelpScene(size: self.size)
        let skView = self.view as SKView!
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        scene.size = skView.bounds.size
        scene.anchorPoint = CGPointMake(CGRectGetMidX(MainMenu().frame), CGRectGetMidY(MainMenu().frame))
        skView.presentScene(scene)
    }
    
    
    
    
    func runSceneTransitionToGame() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.15, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    func runSceneTransitionToHelp() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.15, target:self, selector: Selector("updateCounter2"), userInfo: nil, repeats: true)
    }
    
    /* Updates the counter*/
    func updateCounter() {
        counter += 0.15
        if counter == 0.60 {
            moveSceneToGame()
        }
    }
    
    func updateCounter2() {
        counter += 0.15
        if counter == 0.60 {
            moveSceneToHelp()
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
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if self.nodeAtPoint(location) == self.startButton {
            
                musicLoop.volume = 0.20
                
            //runAction(playButtonSound)
            }
            /*if self.nodeAtPoint(location) == self.highscoreButton {
            
            runAction(playButtonSound)
            */
        
            if self.nodeAtPoint(location) == self.infoButton {
            musicLoop.volume = 0.20
                
            //runAction(playButtonSound)
            }
        }
    }

    override func  touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    for touch: AnyObject in touches {
    let location = touch.locationInNode(self)
    if self.nodeAtPoint(location) == self.startButton {
    
    //runAction(transitionSound)
        self.startButtonPressed = true
        self.musicLoop.stop()
        self.runSceneTransitionToGame()
        }
        //
    
    if self.nodeAtPoint(location) == self.highscoreButton {
    println("contact")
        }
        if self.nodeAtPoint(location) == self.background {
            println("contact")
            self.musicLoop.volume = 0.4
        }
    /*saveHighscore(highscoreshow)
    GameViewController().showLeader()
        }*/
    
    if self.nodeAtPoint(location) == self.infoButton {
        self.infoButtonPressed = true
        self.runSceneTransitionToHelp()
        self.musicLoop.stop()
        
    
            }
        }
    
    }
    
    

    

    
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if self.startButton.position.x > CGRectGetMidX(self.frame) + self.startButton.size.width * 0.03 {
            self.startButton.position.x -= CGFloat(buttonMovementSpeed)
        }
        if self.highscoreButton.position.y < CGRectGetMinY(self.frame) + self.highscoreButton.size.height * 0.4 {
            self.highscoreButton.position.y += CGFloat(buttonMovementSpeed3)
        }
        if self.highscoreBar.position.x < CGRectGetMidX(self.frame) - self.highscoreBar.size.width * 0.030 {
            self.highscoreBar.position.x += CGFloat(buttonMovementSpeed)
        }
        if self.highscoreText.position.x < CGRectGetMidX(self.frame) - self.highscoreBar.size.width * 0.030 {
            self.highscoreText.position.x += CGFloat(buttonMovementSpeed)
        }
        if self.infoButton.position.x > CGRectGetMaxX(self.frame) - self.infoButton.size.width * 0.4 {
            self.infoButton.position.x -= CGFloat(InfoButtonMoveInSpeed)
        }
        
        if self.startButtonPressed == true {
            self.startButton.position.y += CGFloat(buttonMovementSpeed4)
            self.highscoreButton.position.y -= CGFloat(buttonMovementSpeedDouble3)
            self.highscoreBar.position.x += CGFloat(buttonMovementSpeed2)
            self.highscoreText.position.x += CGFloat(buttonMovementSpeed2)
            self.infoButton.position.x += CGFloat(InfoDoubleSpeed)
        }
        if self.infoButtonPressed == true {
            self.startButton.position.y -= CGFloat(buttonMovementSpeed2)
            self.highscoreButton.position.x -= CGFloat(buttonMovementSpeed2)
            self.highscoreBar.position.x -= CGFloat(buttonMovementSpeedDouble1)
            self.highscoreText.position.x -= CGFloat(buttonMovementSpeedDouble1)
            self.infoButton.position.x += CGFloat(InfoDoubleSpeed)
        }
        
        
    }
    
}

