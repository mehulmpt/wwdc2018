import Foundation
import SpriteKit


public class InfoScene: SKScene {
    private var httpLabel: SKLabelNode!
    private var rsaLabel: SKLabelNode!
    private var httpsLabel: SKLabelNode!
    private var dnsLabel: SKLabelNode!
    
    private var parentContainer: SKSpriteNode!
    private var elems: [String: [SKLabelNode: SKSpriteNode]]!
    
    
    private var httpImage: SKSpriteNode!
    private var httpsImage: SKSpriteNode!
    private var rsaImage: SKSpriteNode!
    private var dnsImage: SKSpriteNode!
    
    private var loadingLabel: SKLabelNode!
    
    override public func didMove(to view: SKView) {
        
        initObjects()
        VoiceModule.learnPause()
        VoiceModule.mainbgPlay()
        
    }
    
    private func startPhase1(dispVal: CGFloat) {
        let actionTL = SKAction.moveBy(x: -dispVal, y: dispVal, duration: 1, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0)
        let actionTR = SKAction.moveBy(x: dispVal, y: dispVal, duration: 1, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0)
        let actionBL = SKAction.moveBy(x: -dispVal, y: -dispVal, duration: 1, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0)
        let actionBR = SKAction.moveBy(x: dispVal, y: -dispVal, duration: 1, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0)
        
        let signs = [[-1, 1], [1, 1], [-1, -1], [1, -1]]
        
        var i = 0
        
        let actionsArr = [actionTL, actionTR, actionBL, actionBR]
        
        
        let rotate = SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 80))
        let antirotate = SKAction.repeatForever(SKAction.rotate(byAngle: -.pi, duration: 80))
        
        parentContainer.run(rotate)
        
        for (_, info) in elems {
            for (label, image) in info {
                label.userData = [
                    "xsign": signs[i][0],
                    "ysign": signs[i][1]
                ]
                label.run(actionsArr[i])
                image.run(actionsArr[i])
                
                i+=1
                
                label.run(antirotate, withKey: "infiniteBalance")
                image.run(antirotate, withKey: "infiniteBalance")
            }
        }
    }
    
    private func initObjects() {
        parentContainer = SKSpriteNode()
        
        loadingLabel = SKLabelNode(text: "Loading....")
        loadingLabel.alpha = 0
        loadingLabel.fontSize = 23
        
        httpLabel = SKLabelNode(text: "Let's learn about HTTP")
        httpsLabel = SKLabelNode(text: "Let's learn about HTTPS")
        rsaLabel = SKLabelNode(text: "Let's learn about RSA Encryption")
        dnsLabel = SKLabelNode(text: "Let's learn about DNS")
        
        httpLabel.name = "httpImageLabel"
        httpsLabel.name = "httpsImageLabel"
        rsaLabel.name = "rsaImageLabel"
        dnsLabel.name = "dnsImageLabel"
        
        httpLabel.alpha = 0
        httpsLabel.alpha = 0
        rsaLabel.alpha = 0
        dnsLabel.alpha = 0
        
        httpImage = SKSpriteNode(imageNamed: "http")
        httpsImage = SKSpriteNode(imageNamed: "https")
        rsaImage = SKSpriteNode(imageNamed: "rsa")
        dnsImage = SKSpriteNode(imageNamed: "dns")
        
        rsaImage.zPosition = 2
        
        httpImage.name = "httpImage"
        httpsImage.name = "httpsImage"
        rsaImage.name = "rsaImage"
        dnsImage.name = "dnsImage"
        
        httpImage.setScale(0.3)
        httpsImage.setScale(0.3)
        rsaImage.setScale(0.3)
        dnsImage.setScale(0.3)
        
        elems = [
            "httpImageLabel": [httpLabel: httpImage],
            "httpsImageLabel": [httpsLabel: httpsImage],
            "rsaImageLabel": [rsaLabel: rsaImage],
            "dnsImageLabel": [dnsLabel: dnsImage]
        ]
        
        for (_, info) in elems {
            for (label, image) in info {
                label.fontName = "Montserrat-Regular"
                parentContainer.addChild(label)
                parentContainer.addChild(image)
            }
        }
        
        addChild(loadingLabel)
        
        addChild(parentContainer)
        
        startPhase1(dispVal: 120)
    }
    
    private func startPhase2(_ ImageSprite: SKSpriteNode, _ labelSprite: SKLabelNode) {
        parentContainer.removeAllActions()
        labelSprite.removeAllActions()
        ImageSprite.removeAllActions()
        
        parentContainer.zRotation = 0
        labelSprite.zRotation = 0
        ImageSprite.zRotation = 0
        
        labelSprite.position = CGPoint(x: 0, y: 0)
        loadingLabel.position = CGPoint(x: 0, y: -(labelSprite.frame.height/2 + loadingLabel.frame.height/2 + 10))
        loadingLabel.fontName = "Montserrat-Bold"
        let action1 = SKAction.moveBy(x: 0, y: -150, duration: 1, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 1)
        let action1o1 = SKAction.moveBy(x: 0, y: -150, duration: 1, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 1)
        let action2 = SKAction.fadeAlpha(to: 1, duration: 1)
        
        
        loadingLabel.run(action1o1)
        loadingLabel.run(action2)
        
        labelSprite.run(action1)
        
        
        labelSprite.run(action2) {
            let action3 = SKAction.wait(forDuration: 0.9)
            let scene3: LearningScene! = LearningScene(fileNamed: "LearningScene")
            scene3.whatToLearn = labelSprite.name
            scene3.initScene()
            scene3.scaleMode = .aspectFit
            self.run(action3) {
                self.scene?.view?.presentScene(scene3, transition: SKTransition.doorsOpenVertical(withDuration: 1.5))
            }
        }
        
    }
    
    private func popOut(_ labelNode: SKLabelNode) {
        let action1 = SKAction.fadeAlpha(to: 1, duration: 0.5)
        
        let action2 = SKAction.move(to: CGPoint(x: CGFloat(labelNode.userData!["xsign"] as! CGFloat)*180, y: (labelNode.userData!["ysign"] as! CGFloat)*180), duration: 2, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 3)
        
        labelNode.run(action1)
        labelNode.run(action2)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        VoiceModule.click()
        let location = touches.first?.location(in: self)
        let node = self.atPoint(location!)
        if let name = node.name {
            if(name.suffix(5) == "Image") {
                let nodeName = name+"Label"
                let labelNode = Array(elems[nodeName]!.keys)[0]
                let imageNode = elems[nodeName]![labelNode]
                
                for (_, info) in elems {
                    for(label, img) in info {
                        if(img == imageNode) {
                            let action = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0)
                            img.run(action) {
                                self.startPhase2(img, label)
                            }
                        } else {
                            let action1 = SKAction.scale(to: 0, duration: 1)
                            let action2 = SKAction.move(to: CGPoint(x: CGFloat(label.userData!["xsign"] as! CGFloat)*500, y: (label.userData!["ysign"] as! CGFloat)*500), duration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0)
                            img.run(action1)
                            img.run(action2) {
                                img.removeFromParent()
                                label.removeFromParent()
                            }
                        }
                    }
                }
            }
        }
    }
}


