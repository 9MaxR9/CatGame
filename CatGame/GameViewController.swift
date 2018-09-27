//
//  GameViewController.swift
//  CatGame
//
//  Created by Maxime Ruys on 5/07/17.
//  Copyright © 2017 Maxime Ruys. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
            if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = Menu(size: CGSize(width: 1536, height: 2048))
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                view.showsFPS = true
                view.showsNodeCount = true
                // Present the scene
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
