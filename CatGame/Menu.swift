//
//  Menu.swift
//  CatGame
//
//  Created by Maxime Ruys on 14/09/18.
//  Copyright © 2018 Maxime Ruys. All rights reserved.
//

import SpriteKit

class Menu: SKScene {
    var titleLabel = SKLabelNode()
    var btnStart = SKSpriteNode()
    var charsBtn = SKSpriteNode()
    var btnBuyCoins = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.view?.backgroundColor = SKColor.black
        titleLabel = SKLabelNode(text: "CAT GAME")
        titleLabel.position = CGPoint(x: self.size.width / 2, y: self.size.width / 2 + 800)
        titleLabel.fontSize = 150
        self.addChild(titleLabel)
        
        btnStart = SKSpriteNode(imageNamed: "StartBTN.png")
        btnStart.name = "BtnStart"
        btnStart.size = CGSize(width: 500, height: 150)
        btnStart.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 200)
        self.addChild(btnStart)
        
        charsBtn = SKSpriteNode(imageNamed: "StartBTN.png")
        charsBtn.name = "BtnChars"
        charsBtn.size = CGSize(width: 500, height: 150)
        charsBtn.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 - 100)
        self.addChild(charsBtn)
        
        btnBuyCoins = SKSpriteNode(imageNamed: "BuBTN.png")
        btnBuyCoins.name = "BtnBuy"
        btnBuyCoins.size = CGSize(width: 500, height: 150)
        btnBuyCoins.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 - 400)
        self.addChild(btnBuyCoins)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            enumerateChildNodes(withName: "//*") { (node, stop) in
                if(node.name == "BtnStart"){
                    if(node.contains(touch.location(in: self))){
                        let scene = GameScene(size: self.size)
                        let transistionScene = SKTransition.fade(withDuration: 0.5)
                        self.view!.presentScene(scene,transition: transistionScene)
                    }
                }
                else if(node.name == "BtnChars"){
                    if(node.contains(touch.location(in: self))){
                        let scene = Chars(size: self.size)
                        let transistionScene = SKTransition.fade(withDuration: 0.5)
                        self.view!.presentScene(scene, transition: transistionScene)
                    }
                }
                else if(node.name == "BtnBuy"){
                    if(node.contains(touch.location(in: self))){
                        
                    }
                }
            }
        }
    }
}
