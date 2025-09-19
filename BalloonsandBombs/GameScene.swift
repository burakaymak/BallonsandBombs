import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var timer = Timer()
    var countdownTimer = Timer()
    
    var startButton = SKLabelNode(text: "Start")
    var gameName = SKLabelNode(text: "Balloons and Bombs")
    var scoreLabel = SKLabelNode()
    var secondLabel = SKLabelNode()
    var retryButton = SKLabelNode()
    var levelLabel = SKLabelNode()
    
    var score = 0
    var second = 45
    var levelCount = 1
    
    // Level parametreleri
    var spawnSpeed: Double = 1.0       // objelerin spawn aralığı
    var disappearTime: Double = 1.0    // objelerin yok olma süresi
    
    override func didMove(to view: SKView) {
        
        gameName.fontSize = 80
        gameName.fontColor = .white
        gameName.fontName = "Chalkduster"
        gameName.position = CGPoint(x: 0, y: 0)
        gameName.zPosition = 2
        addChild(gameName)
        
        startButton.name = "startButton"
        startButton.fontSize = 60
        startButton.fontColor = .white
        startButton.fontName = "Chalkduster"
        startButton.position = CGPoint(x: 0, y: -self.frame.height / 4)
        startButton.zPosition = 2
        addChild(startButton)
        
        scoreLabel.name = "scoreLabel"
        scoreLabel.text = "Score : 0"
        scoreLabel.fontColor = .black
        scoreLabel.fontName = "Chalkduster"
        scoreLabel.fontSize = 30
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 5)
        scoreLabel.zPosition = 2
        scoreLabel.alpha = 0
        addChild(scoreLabel)
        
        secondLabel.name = "secondLabel"
        secondLabel.text = "Time : \(second)"
        secondLabel.fontColor = .black
        secondLabel.fontName = "Chalkduster"
        secondLabel.fontSize = 40
        secondLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        secondLabel.zPosition = 2
        secondLabel.alpha = 0
        addChild(secondLabel)
        
        retryButton.name = "retryButton"
        retryButton.text = "Retry"
        retryButton.fontSize = 40
        retryButton.fontName = "Chalkduster"
        retryButton.fontColor = .red
        retryButton.position = CGPoint(x: 0, y: 0)
        retryButton.zPosition = 2
        retryButton.alpha = 0
        addChild(retryButton)
        
        levelLabel.name = "levelLabel"
        levelLabel.text = "Level \(levelCount)"
        levelLabel.fontSize = 50
        levelLabel.fontColor = .white
        levelLabel.fontName = "Chalkduster"
        levelLabel.position = CGPoint(x: 0, y: 0)
        levelLabel.zPosition = 2
        levelLabel.alpha = 0
        addChild(levelLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let node = atPoint(touch.location(in: self))
            
            if node.name == "startButton" {
                startButton.alpha = 0
                gameName.alpha = 0
                showLevel()
            }
            
            if node.name == "balloon" {
                score += 1
                scoreLabel.text = "Score : \(score)"
                node.removeFromParent()
                
                if score == 20 
                { // level geçme şartı
                    nextLevel()
                }
            }
            
            if node.name == "bomb" {
                score = max(0, score - 1)
                scoreLabel.text = "Score : \(score)"
                node.removeFromParent()
            }
            
            if node.name == "retryButton" {
                restartGame()
            }
        }
    }
    
    func showLevel() {
        
        levelLabel.text = "Level \(levelCount)"
        levelLabel.alpha = 1
        let seq = SKAction.sequence([
            SKAction.wait(forDuration: 1.5),
            SKAction.fadeOut(withDuration: 0.5),
            SKAction.run { self.startGame() }
        ])
        levelLabel.run(seq)
    }
    
    func startGame() {
        score = 0
        second = 45
        scoreLabel.text = "Score : 0"
        secondLabel.text = "Time : \(second)"
        scoreLabel.alpha = 1
        secondLabel.alpha = 1
        
        timer.invalidate()
        countdownTimer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: spawnSpeed, target: self, selector: #selector(spawnObject), userInfo: nil, repeats: true)
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    func nextLevel() {
        timer.invalidate()
        countdownTimer.invalidate()
        
        secondLabel.isHidden = true
        scoreLabel.isHidden = true
        
        levelCount += 1
        spawnSpeed *= 0.8       // hızlanıyor
        disappearTime *= 0.8    // daha hızlı yok oluyor
        
        levelLabel.alpha = 1
        levelLabel.text = "Level \(levelCount)"
        
        let seq = SKAction.sequence([
            SKAction.wait(forDuration: 2.0),
            SKAction.fadeOut(withDuration: 0.5),
            SKAction.run { self.startGame() }
        ])
        levelLabel.run(seq)
        
        secondLabel.isHidden = false
        scoreLabel.isHidden = false
        
       
    }
    
    func restartGame() {
        levelCount = 1
        spawnSpeed = 1.0
        disappearTime = 1.0
        secondLabel.fontColor = .red
        retryButton.alpha = 0
        
        showLevel()
    }
    
    @objc func spawnObject() {
        let isBalloon = Int.random(in: 0..<100) < 70
        let obj = SKSpriteNode(imageNamed: isBalloon ? "balloon" : "bomb")
        obj.name = isBalloon ? "balloon" : "bomb"
        obj.size = CGSize(width: 80, height: 80)
        
        let randomX = CGFloat.random(in: -self.size.width/4 ... self.size.width/4)
        let randomY = CGFloat.random(in: -self.size.height/3 ... self.size.height/10)
        obj.position = CGPoint(x: randomX, y: randomY)
        obj.zPosition = 1
        
        let disappear = SKAction.sequence([
            SKAction.wait(forDuration: disappearTime),
            SKAction.removeFromParent()
        ])
        obj.run(disappear)
        addChild(obj)
    }
    
    @objc func countDown() {
        if second > 0 {
            second -= 1
            secondLabel.text = "Time : \(second)"
        } else {
            
            for child in children {
                if child.name == "balloon" || child.name == "bomb"
                {
                    child.removeFromParent()
                }
            }
            timer.invalidate()
            countdownTimer.invalidate()
            retryButton.alpha = 1
            secondLabel.fontColor = .red
            secondLabel.text = "Game Over!"
        }
    }
}

