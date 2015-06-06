//
//  GameViewController.swift
//  Tetris
//
//  Created by Chris Archibald on 6/5/15.
//  Copyright (c) 2015 Chris Archibald. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController, TetrisDelegate, UIGestureRecognizerDelegate {

    var scene: GameScene!
    var tetris: Tetris!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        //Configure the view
        let skView = self.view as! SKView
        skView.multipleTouchEnabled = false
        
        //Create and configure the Scene.
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.tick = didTick
        
        tetris = Tetris()
        tetris.delegate = self
        tetris.beginGame()
        
        //Present the scene.
        skView.presentScene(scene)
        
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        tetris.rotateShape()
    }
    
    func didTick() {
        tetris.letShapeFall()
    }
    
    func nextShape() {
        let newShapes = tetris.newShape()
        if let fallingShape = newShapes.fallingShape {
            self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
            self.scene.movePreviewShape(fallingShape) {
                self.view.userInteractionEnabled = true
                self.scene.startTicking()
            }
        }
    }
    
    func gameDidBegin(tetris: Tetris) {
        if tetris.nextShape != nil && tetris.nextShape!.blocks[0].sprint == nil {
            scene.addPreviewShapeToScene(tetris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(tetris: Tetris) {
        view.userInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(tetris: Tetris) {
        
    }
    
    func gameShapeDidDrop(tetris: Tetris) {
        
    }
    
    func gameShapeDidLand(tetris: Tetris) {
        scene.stopTicking()
        nextShape()
    }
    
    func gameShapeDidMove(tetris: Tetris) {
        scene.redrawShape(tetris.fallingShape!) {}
    }
}
