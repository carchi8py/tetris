//
//  GameViewController.swift
//  Tetris
//
//  Created by Chris Archibald on 6/5/15.
//  Copyright (c) 2015 Chris Archibald. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

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
        tetris.beginGame()
        
        //Present the scene.
        skView.presentScene(scene)
        
        scene.addPreviewShapeToScene(tetris.nextShape!) {
            self.tetris.nextShape?.moveTo(StartingColumn, row: StartingColumn)
            self.scene.movePreviewShape(self.tetris.nextShape!) {
                let nextShapes = self.tetris.newShape()
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(nextShapes.nextShape!) {}
            }
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func didTick() {
        tetris.fallingShape?.lowerShapeByOneRow()
        scene.redrawShape(tetris.fallingShape!, completion: {})
    }
}
