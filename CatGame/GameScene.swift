//
//  GameScene.swift
//  CatGame
//
//  Created by Maxime Ruys on 5/07/17.
//  Copyright © 2017 Maxime Ruys. All rights reserved.
//

import SpriteKit

struct PhysicsCatagory{
    static let Enemyp : UInt32 = 1
    static let Playerp : UInt32 = 2
    static let Worldp : UInt32 = 3
    static let Bulletp : UInt32 = 4
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player = SKSpriteNode()
    var Enemy  = SKSpriteNode()
    var Bullet = SKSpriteNode()
    var Background = SKSpriteNode()
    var EnemyTimer = Timer()
    var World = SKSpriteNode()
    var ScoreLabel = SKLabelNode()
    var StartLabel = SKLabelNode()
    var coinsLabel = SKLabelNode()
    var MenuBtn = SKSpriteNode()
    var score = 0
    var coins = UserDefaults.standard.integer(forKey: "coinsSaved")
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        startLevel()
        addScoreLabel()
        addCoinsLabel()
        StartLabel.text = "TAP TO START!"
        EnemyTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(GameScene.spawnEnemy), userInfo: nil, repeats: true)
        
    }
    
    func startLevel(){
        background()
        world()
        PLayer()
        addStartLabel()
        addMenuBtn()
    }
    
    func PLayer(){
        player = SKSpriteNode(imageNamed: "GrumpyCat")
        player.position = CGPoint(x: self.size.width / 2, y: 1633.35205078125)
        player.size = CGSize(width: 350, height: 350)
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.height / 2)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = false
        player.physicsBody?.categoryBitMask = PhysicsCatagory.Playerp
        player.physicsBody?.contactTestBitMask = PhysicsCatagory.Enemyp & PhysicsCatagory.Worldp
        self.addChild(player)
        
    }
    
    func runPlayerSequence(){
        let PlayerAction = SKAction.moveTo(y: 37.859130859375, duration: 10)
        //let PlayerRemove = SKAction.removeFromParent()
        let PlayerMoveUp = SKAction.moveTo(y: 1633.35205078125, duration: 0.01)
        let PlayerSequence = SKAction.sequence([PlayerAction, PlayerMoveUp])
        player.run(PlayerSequence)
    }
    
    func addCoinsLabel(){
        coinsLabel = SKLabelNode(text: "Coins: " + String(coins))
        coinsLabel.position = CGPoint(x: self.size.width / 2 + 400, y: 1700)
        coinsLabel.fontSize = 80
        coinsLabel.zPosition = 1
        self.addChild(coinsLabel)
    }
    
    func addScoreLabel(){
        ScoreLabel = SKLabelNode(text: String(score))
        ScoreLabel.position = CGPoint(x: self.size.width / 2, y: 1700)
        ScoreLabel.fontSize = 150
        ScoreLabel.zPosition = 1
        self.addChild(ScoreLabel)
    }
    
    func addStartLabel(){
        StartLabel = SKLabelNode()
        StartLabel.position = CGPoint(x: self.size.width / 2, y: 1900)
        StartLabel.fontSize = 150
        StartLabel.zPosition = 1
        self.addChild(StartLabel)
    }
    
    func addMenuBtn(){
        MenuBtn = SKSpriteNode(imageNamed: "BuBTN.png")
        MenuBtn.position = CGPoint(x: self.size.width / 2 - 500, y: self.size.height / 2 + 500)
        MenuBtn.size = CGSize(width: 500, height: 150)
        MenuBtn.name = "BtnMenu"
        self.addChild(MenuBtn)
    }
    
    
    func fireBullet(){
        Bullet = SKSpriteNode(imageNamed: "bullet")
        Bullet.position = player.position
        let BulletAction = SKAction.moveTo(y: -700.816345214844, duration: 0.5)
        let BulletRemove = SKAction.removeFromParent()
        let Bulletseq = SKAction.sequence([BulletAction, BulletRemove])
        Bullet.size = CGSize(width: 50, height: 40)
        Bullet.run(Bulletseq)
        Bullet.zPosition = 2
        Bullet.zRotation = CGFloat(M_PI_2)*2
        Bullet.physicsBody = SKPhysicsBody(circleOfRadius: Bullet.size.height)
        Bullet.physicsBody?.affectedByGravity = false
        Bullet.physicsBody?.isDynamic = false
        Bullet.physicsBody?.categoryBitMask = PhysicsCatagory.Bulletp
        Bullet.physicsBody?.contactTestBitMask = PhysicsCatagory.Enemyp
        self.addChild(Bullet)
    }
    
    func background(){
        Background = SKSpriteNode(imageNamed: "background")
        Background.position = CGPoint(x: self.size.width / 2, y: self.size.height/2)
        Background.size = CGSize(width: self.size.width, height: self.size.height)
        Background.zPosition = 0
        self.addChild(Background)
    }

    @objc func spawnEnemy(){
        Enemy = SKSpriteNode(imageNamed: "enemyShip")
        Enemy.position.y = -100
        Enemy.size = CGSize(width: 200, height: 150)
        let position = arc4random() % 4
        switch position {
        case 0:
            Enemy.position.x = 261.408477783203
            break
        case 1:
            Enemy.position.x = 472.338073730469
            break
        case 2:
            Enemy.position.x = 724.732482910156
            break
        case 3:
            Enemy.position.x = 939.267700195312
            break
        default:
            Enemy.position.x = 1155.60571289062
            break
        }
        let EnemyAction = SKAction.moveTo(y: 2200, duration: 2.5)
        let EnemyRemove = SKAction.removeFromParent()
        let Enemyseq = SKAction.sequence([EnemyAction, EnemyRemove])
        Enemy.run(Enemyseq)
        Enemy.zPosition = 1
        Enemy.zRotation = CGFloat(M_PI/2.0)
        Enemy.physicsBody = SKPhysicsBody(circleOfRadius: Enemy.size.height)
        Enemy.physicsBody?.affectedByGravity = false
        Enemy.physicsBody?.isDynamic = true
        Enemy.physicsBody?.categoryBitMask = PhysicsCatagory.Enemyp
        Enemy.physicsBody?.contactTestBitMask = PhysicsCatagory.Bulletp & PhysicsCatagory.Playerp
        self.addChild(Enemy)
    }
    
    func world(){
        World = SKSpriteNode(imageNamed: "World")
        World.position = CGPoint(x: self.size.width / 2, y: 108.169067382812)
        World.size = CGSize(width: 300, height: 300)
        World.physicsBody = SKPhysicsBody(circleOfRadius: World.size.height)
        World.physicsBody?.affectedByGravity = false
        World.physicsBody?.isDynamic = false
        World.physicsBody?.categoryBitMask = PhysicsCatagory.Worldp
        World.physicsBody?.contactTestBitMask = PhysicsCatagory.Playerp
        World.zPosition = 2
        self.addChild(World)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            print(location)
            enumerateChildNodes(withName: "//*") { (node, stop) in
                if(node.name == "BtnMenu"){
                    if(node.contains(touch.location(in: self))){
                        let scene = Menu(size: self.size)
                        let transistionScene = SKTransition.fade(withDuration: 0.5)
                        self.view!.presentScene(scene,transition: transistionScene)
                    }
                }
            }
            
        }
        StartLabel.isHidden = true
        MenuBtn.isHidden = true
        runPlayerSequence()
        fireBullet()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let prevlocation = touch.previousLocation(in: self)
            let amountdragged = location.x - prevlocation.x
            player.position.x += amountdragged
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Hello")
        var firstBody : SKPhysicsBody = contact.bodyA
        var secondBody : SKPhysicsBody = contact.bodyB
        if ((firstBody.categoryBitMask == PhysicsCatagory.Enemyp) && (secondBody.categoryBitMask == PhysicsCatagory.Bulletp) || (firstBody.categoryBitMask == PhysicsCatagory.Bulletp) && (secondBody.categoryBitMask == PhysicsCatagory.Enemyp)){
            collisionwithBullet(enemyB: firstBody.node as! SKSpriteNode, bulletB: secondBody.node as! SKSpriteNode)
        }
        
        else if ((firstBody.categoryBitMask == PhysicsCatagory.Enemyp) && (secondBody.categoryBitMask == PhysicsCatagory.Playerp) || (firstBody.categoryBitMask == PhysicsCatagory.Playerp) && (secondBody.categoryBitMask == PhysicsCatagory.Enemyp)){
            collisionwithPlayer(enemyB: firstBody.node as! SKSpriteNode, playerB: secondBody.node as! SKSpriteNode)
        }
        
        else if ((firstBody.categoryBitMask == PhysicsCatagory.Playerp) && (secondBody.categoryBitMask == PhysicsCatagory.Worldp) || (firstBody.categoryBitMask == PhysicsCatagory.Worldp) && (secondBody.categoryBitMask == PhysicsCatagory.Playerp)){
            collisionwithWorld(playerB: firstBody.node as! SKSpriteNode, worldB: secondBody.node as! SKSpriteNode)
        }
    }
    
    func collisionwithBullet(enemyB: SKSpriteNode, bulletB: SKSpriteNode){
        enemyB.removeFromParent()
        bulletB.removeFromParent()
        score += 10
        coins += 1
        ScoreLabel.text = String(score)
        coinsLabel.text = "Coins: " + String(coins)
    }
    
    func collisionwithPlayer(enemyB: SKSpriteNode, playerB: SKSpriteNode){
        playerB.removeFromParent()
        enemyB.removeFromParent()
        score = 0
        UserDefaults.standard.set(coins, forKey: "coinsSaved")
        ScoreLabel.text = String(score)
        startLevel()
        StartLabel.text = "TAP TO RESTART!"
        MenuBtn.isHidden = false
        //self.view?.presentScene(SKScene(fileNamed: "GameOverScene"))
        
    }
    
    func collisionwithWorld(playerB: SKSpriteNode, worldB: SKSpriteNode){
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
