//
//  HelpScene.swift
//  Star Rush
//
//  Created by Alexander Saleh on 6/13/15.
//  Copyright (c) 2015 Moonwalk Studios. All rights reserved.
//

import SpriteKit
import UIKit
import Foundation
import AudioToolbox
import AVFoundation
import GameKit



class HelpScene: SKScene  {

    let background = SKSpriteNode(imageNamed: "Background")
    let backButton = SKSpriteNode(imageNamed: "BackButton")
    let info1 = SKSpriteNode(imageNamed: "Info1")
    let info2 = SKSpriteNode(imageNamed: "Info2")
    var musicLoop: AVAudioPlayer!
    var timer = NSTimer()
    var counter = Double()
    var backButtonPressed = false
    let buttonMovementSpeed = 14.0
    let doubleButtonSpeed = 30.0
    let doubleButtonSpeed2 = 28.0
    
    
    
    
    
    override func didMoveToView(view: SKView) {
        self.playMusicLoop("MenuStarRush.caf")
        
        self.background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(self.background)
        
        self.backButton.position = CGPointMake(CGRectGetMinX(self.frame) - 2 * self.backButton.size.width * 0.5, CGRectGetMinY(self.frame) + self.backButton.size.height * 0.5)
        self.addChild(self.backButton)

        self.updateCounter()
        
        self.info1.position = CGPointMake(CGRectGetMinX(self.frame) - 2 * self.info1.size.width / 2, CGRectGetMaxY(self.frame) - self.info1.size.height / 2)
        self.info2.position = CGPointMake(CGRectGetMaxX(self.frame) + 2 * self.info2.size.width / 2, CGRectGetMidY(self.frame) - self.info2.size.height / 2)
        self.addChild(self.info1)
        self.addChild(self.info2)
    }
    
    
    func runSceneTransitionToMenu() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.10, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    
    
    func updateCounter() {
        self.counter += 0.10
        if counter == 0.40 {
            self.moveSceneToMenu()
        }
    }

    func moveSceneToMenu() {
        var scene = MainMenu(size: self.size)
        let skView = self.view as SKView!
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        scene.size = skView.bounds.size
        scene.anchorPoint = CGPointMake(CGRectGetMidX(MainMenu().frame), CGRectGetMidY(MainMenu().frame))
        skView.presentScene(scene)
    }
    
    func playMusicLoop(filename: String) {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        if(url == nil) {
            println("could not find file: \(filename)")
            return
        }
        var error: NSError? = nil
        self.musicLoop = AVAudioPlayer(contentsOfURL: url, error: &error)
        if self.musicLoop == nil {
            println("Could not create audio player: \(error!)")
            return
        }
        
        self.musicLoop.numberOfLoops = -1
        self.musicLoop.prepareToPlay()
        self.musicLoop.volume = 0.4
        self.musicLoop.play()
        
    }
    
    
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if self.nodeAtPoint(location) == self.backButton {
                self.musicLoop.volume = 0.20
                
                //runAction(playButtonSound)
            }
        }
    }

    override func  touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if self.nodeAtPoint(location) == self.background {
                println("contact")
                self.musicLoop.volume = 0.4
            }
            
            
            if self.nodeAtPoint(location) == self.backButton {
                self.runSceneTransitionToMenu()
                self.musicLoop.stop()
                self.backButtonPressed = true
                
            }
            
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if self.backButtonPressed == true{
            self.backButton.position.x -= CGFloat(doubleButtonSpeed2)
            self.info1.position.x -= CGFloat(doubleButtonSpeed)
            self.info2.position.x += CGFloat(doubleButtonSpeed)
        }
        if self.backButton.position.x < CGRectGetMinX(self.frame) + self.backButton.size.width * 0.45 {
            self.backButton.position.x += CGFloat(buttonMovementSpeed)
        }
        if self.info1.position.x < CGRectGetMinX(self.frame) + self.info1.size.width / 2 {
            self.info1.position.x += CGFloat(buttonMovementSpeed)
        }
        if self.info2.position.x > CGRectGetMaxX(self.frame) - self.info2.size.width / 2 {
            self.info2.position.x -= CGFloat(buttonMovementSpeed)
        }
    }
    
}





