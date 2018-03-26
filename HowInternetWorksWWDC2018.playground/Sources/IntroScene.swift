import Foundation
import SpriteKit

public class IntroScene: SKScene {
    
    private var webLogo : SKSpriteNode!
    private var shakingTimer : Timer!
    private var backgroundTimer : Timer!
    private var howWebWorksLabel: SKLabelNode!
    private var bgImage: SKSpriteNode!
    private var clickButton: SKLabelNode!
    private var currentPhase: Int = 0
    private var phase1DownwardDisplacement: CGFloat = 100
    
    override public func didMove(to view: SKView) {
        
        VoiceModule.learnPause()
        VoiceModule.mainbgPlay()
        
        howWebWorksLabel = SKLabelNode(text: "How Internet Works?")
        howWebWorksLabel.alpha = 0
        howWebWorksLabel.fontName = "Montserrat-Regular"
        addChild(howWebWorksLabel)
        
        clickButton = SKLabelNode(text: "Click to continue!")
        clickButton.position = CGPoint(x: 0, y: -phase1DownwardDisplacement - howWebWorksLabel.fontSize - 100)
        clickButton.alpha = 0
        
        clickButton.name = "clickButton"
        clickButton.fontName = "Montserrat-Bold"
        
        webLogo = SKSpriteNode(imageNamed: "logo")
        webLogo.size = CGSize(width: 200, height: 200)
        
        let action1 = SKAction.rotate(byAngle: .pi, duration: 2)
        let action2 = SKAction.rotate(byAngle: 2 * .pi, duration: 1)
        let actionX = SKAction.run {
            self.run(SKAction.colorize(with: self.randomColor(), colorBlendFactor: 0, duration: 1))
        }
        
        let group = SKAction.group([action2, actionX])
        
        webLogo.run(SKAction.repeatForever(SKAction.sequence([action1, group])))
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 2), group])))
        
        addChild(webLogo)
        addChild(clickButton)
    }
    
    private func randomColor() -> SKColor {
        let color: CGFloat = CGFloat(arc4random_uniform(256)) / 1337.0
        return SKColor(red: color, green: color, blue: color, alpha: 1.0)
    }
    
    private func startPhase1(yValue: CGFloat) {
        
        
        
        let action1 = SKAction.moveTo(y: yValue, duration: 2, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0)
        let action2 = SKAction.moveTo(y: -yValue, duration: 2, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0)
        let action3 = SKAction.fadeAlpha(to: 1, duration: 2)
        
        
        
        webLogo.run(action1)
        howWebWorksLabel.run(SKAction.group([action2, action3])) {
            self.startPhase2()
        }
    }
    
    private func startPhase2() {
        let action = SKAction.fadeAlpha(to: 1, duration: 0.8)
        action.timingMode = .easeIn
        clickButton.run(action)
    }
    
    private func startPhase3() {
        
        let sendout1 = SKAction.moveTo(x: size.width/2 + webLogo.size.width/2, duration: 4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5)
        let sendout2 = SKAction.moveTo(x: -size.width/2 - howWebWorksLabel.frame.size.width/2, duration: 4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1)
        let sendout3 = SKAction.fadeAlpha(to: 0, duration: 2)
        
        webLogo.run(sendout1)
        howWebWorksLabel.run(sendout2)
        clickButton.run(sendout3) {
            self.startPhase4()
        }
    }
    
    private func startPhase4() {
        let scene2: InfoScene! = InfoScene(fileNamed: "LearningScene")
        scene2.scaleMode = .aspectFit
        scene?.view?.presentScene(scene2, transition: SKTransition.doorsCloseHorizontal(withDuration: 1.4))
    }
    
    private func shiftBackground() {
        let action = SKAction.moveBy(x: -10, y: 0, duration: 0.5)
        action.timingMode = .linear
        
        bgImage.run(SKAction.repeatForever(action))
    }

    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        VoiceModule.click()
        if(currentPhase == 0) {
            currentPhase = 1
            startPhase1(yValue: phase1DownwardDisplacement)
        }
        
        let location = touches.first?.location(in: self)
        let node = self.atPoint(location!)
        if (node.name == "clickButton") {
            startPhase3()
        }
    }
}


