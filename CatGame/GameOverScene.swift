//
//  GameOverScene.swift
//  CatGame
//
//  Created by Maxime Ruys on 6/07/17.
//  Copyright © 2017 Maxime Ruys. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view?.presentScene(SKScene(fileNamed: "GameScene"))
    }
    
}
