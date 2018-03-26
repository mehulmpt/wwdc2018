import Foundation
import SpriteKit

public class LearningScene: SKScene {
    
    public var whatToLearn: String!
    public var cameraNode: SKCameraNode!
    private var buttons: [SKSpriteNode: SKShapeNode]!
    private var nodes: RichNode!
    
    private var learning: String!
    private var leftBoundary: CGFloat!
    private var rightBoundary: CGFloat!
    
    private var progressBar: SKSpriteNode!
    
    private var fireworksShown: Bool! = false
    private var volButton: SKSpriteNode!
    
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        VoiceModule.mainbgPause()
        VoiceModule.learnPlay()
    }
    
    
    
    public func initScene() {
        backgroundColor = SKColor(red: CGFloat(35.0/255.0), green: CGFloat(35.0/255.0), blue: CGFloat(35.0/255.0), alpha: CGFloat(1.0))
        VoiceModule.speak(text: "")
        leftBoundary = 0

        cameraNode = SKCameraNode()
        addChild(cameraNode)
        cameraNode.position = CGPoint(x: leftBoundary, y: 0)
        addHUD()
        camera = cameraNode
        
        nodes = RichNode()
        addChild(nodes)
        nodes.isUserInteractionEnabled = true
        
        let data = learnData[learning]!
        
        for node in data {
            let frames = node["spriteFrames"]
            if(frames != nil) {
                nodes.create(image: node["image"]!, infoText: node["tooltip"]!, heading: node["heading"]!, spriteFrames: Int(frames!)!, delay: Double(node["delay"]!)!)
            } else {
                nodes.create(image: node["image"]!, infoText: node["tooltip"]!, heading: node["heading"]!, spriteFrames: 1, delay: 0)
            }
        }
        
        let action = SKAction.run {
            self.nodes.popTooltip(cameraPosX: self.cameraNode.position.x)
        }
        
        rightBoundary = nodes.giveMeRightBoundary()
        
        let cameraCheck = SKAction.run {
            if(self.cameraNode.position.x < self.leftBoundary) {
                self.cameraNode.removeAction(forKey: "left")
                self.progressBar.removeAction(forKey: "leftProgress")
            } else if(self.cameraNode.position.x > self.rightBoundary) {
                self.cameraNode.removeAction(forKey: "right")
                self.progressBar.removeAction(forKey: "rightProgress")
                if(!self.fireworksShown) {
                    self.fireworksShown = true
                    self.fireworks()
                }
            }
        }
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 0.1), action, cameraCheck])))
        addNavigationButtons()
        nodes.position = CGPoint(x: -size.width/2, y: 0)
        
    }
    
    private func fireworks() {
        let emitter = SKEmitterNode(fileNamed: "completed")!
        emitter.particleTexture = SKTexture(imageNamed: "particles.atlas/spark")
        emitter.position = CGPoint(x: 0, y: 0)
        
        cameraNode.addChild(emitter)
        
        let waitAction = SKAction.wait(forDuration: 1)
        let removeAction = SKAction.run({
            emitter.removeFromParent()
        })
        let sequence = SKAction.sequence([waitAction, removeAction])
        
        emitter.run(sequence)
    }
    
    private func addHUD() {
        let padding: CGFloat = 10
        let exitButton = SKSpriteNode(imageNamed: "exitButton")
        exitButton.size = CGSize(width: 18, height: 18)
        
        let exitButtonBorder = SKShapeNode(circleOfRadius: 20)
        exitButtonBorder.name = "exitButtonBorder"
        exitButton.name = "exitButtonImage"
        exitButtonBorder.position = CGPoint(
            x: scene!.size.width/2 - exitButtonBorder.frame.width/2 - padding,
            y: scene!.size.height/2 - exitButtonBorder.frame.height/2 - padding
        )
        exitButtonBorder.addChild(exitButton)
        
        cameraNode.addChild(exitButtonBorder)
        
        let grayedProgessBar = SKSpriteNode(color: .gray, size: CGSize(width: scene!.size.width, height: 10))
        
        progressBar = SKSpriteNode(color: SKColor(red: CGFloat(96.0/255.0), green: CGFloat(205.0/255.0), blue: CGFloat(52.0/255.0), alpha: CGFloat(1.0)), size: CGSize(width: scene!.size.width, height: 10))
        progressBar.position = CGPoint(
            x: -scene!.size.width,
            y: exitButtonBorder.position.y - exitButtonBorder.calculateAccumulatedFrame().height/2 - padding - progressBar.size.height/2
        )
        grayedProgessBar.position.y = progressBar.position.y
        cameraNode.addChild(grayedProgessBar)
        cameraNode.addChild(progressBar)
        
        var learnIntro: String!
        var learnImage: SKSpriteNode!
        
        switch(whatToLearn) {
        case "httpImageLabel":
            learning = "http"
            learnIntro = "Now Learning - How HTTP Works"
            learnImage = SKSpriteNode(imageNamed: "http")
        case "httpsImageLabel":
            learning = "https"
            learnIntro = "Now Learning - How HTTPS Works"
            learnImage = SKSpriteNode(imageNamed: "https")
        case "rsaImageLabel":
            learning = "rsa"
            learnIntro = "Now Learning - How RSA Encryption Works"
            learnImage = SKSpriteNode(imageNamed: "rsa")
        case "dnsImageLabel":
            learning = "dns"
            learnIntro = "Now Learning - How DNS Works"
            learnImage = SKSpriteNode(imageNamed: "dns")
        default:
            learnIntro = "Now Learning - ????"
            learnImage = SKSpriteNode(imageNamed: "logo")
        }
        
        let label = SKLabelNode(text: learnIntro)
        label.fontName = "Montserrat-Bold"
        learnImage.size = CGSize(width: 40, height: 40)
        
        label.fontSize = 20
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        
        learnImage.position = CGPoint(
            x: -scene!.size.width/2 + learnImage.frame.width/2 + padding,
            y: scene!.size.height/2 - learnImage.frame.height/2 - padding
        )
        
        label.position = CGPoint(
            x: -scene!.size.width/2 + label.frame.width/2 + CGFloat(2*padding) + learnImage.frame.width,
            y: learnImage.position.y
        )
        
        cameraNode.addChild(label)
        cameraNode.addChild(learnImage)
        
    }
    
    private func addNavigationButtons() {
        let padding: CGFloat = 20
        
        let goRight = SKSpriteNode(imageNamed: "imageRight")
        let goLeft = SKSpriteNode(imageNamed: "imageLeft")
        volButton = SKSpriteNode(imageNamed: "volon")
        
        volButton.userData = [:]
        volButton.userData!["mode"] = "on"
        goRight.size = CGSize(width: 25, height: 25)
        goLeft.size = goRight.size
        volButton.size = goRight.size
        
        let goRightBorder = SKShapeNode(circleOfRadius: 30)
        goRightBorder.name = "rightNavButton"
        goRight.name = "rightNavButtonImage"
        goRightBorder.position = CGPoint(
            x: scene!.size.width/2 - goRightBorder.frame.width/2 - padding,
            y: -scene!.size.height/2 + goRightBorder.frame.height/2 + padding
        )
        goRightBorder.addChild(goRight)
        
        let goLeftBorder = SKShapeNode(circleOfRadius: 30)
        goLeftBorder.name = "leftNavButton"
        goLeft.name = "leftNavButtonImage"
        goLeftBorder.position = CGPoint(
            x: -scene!.size.width/2 + goLeftBorder.frame.width/2 + padding,
            y: -scene!.size.height/2 + goLeftBorder.frame.height/2 + padding
        )
        goLeftBorder.addChild(goLeft)
        
        let volBorder = SKShapeNode(circleOfRadius: 30)
        volBorder.name = "volumeButton"
        volButton.name = "volumeButtonImage"
        volBorder.position = CGPoint(
            x: 0,
            y: -scene!.size.height/2 + goLeftBorder.frame.height/2 + padding
        )
        volBorder.addChild(volButton)
        
        buttons = [
            goRight: goRightBorder,
            goLeft: goLeftBorder
        ]

        cameraNode.addChild(goRightBorder)
        cameraNode.addChild(volBorder)
        cameraNode.addChild(goLeftBorder)
    }
    
    private func changeColor(_ node: Any) {
        let button = node as? SKSpriteNode
        if(button == nil) {
            // image is not tapped, directly change the color
            (node as! SKShapeNode).fillColor = .gray
        } else {
            buttons[button!]!.fillColor = .gray
        }
    }
    
    private func moveCamRight() {
        let dist: CGFloat = 80
        let dur: Double = 0.25
        let rightMove = SKAction.moveBy(x: dist, y: 0, duration: dur)
        let rightMoveProgress = SKAction.moveBy(x: dist*scene!.size.width/nodes.giveMeRightBoundary(), y: 0, duration: dur)
        progressBar.run(SKAction.repeatForever(rightMoveProgress), withKey: "rightProgress")
        cameraNode.run(SKAction.repeatForever(rightMove), withKey: "right")
    }
    
    private func moveCamLeft() {
        
        let dist: CGFloat = 80
        let dur: Double = 0.25
        let leftMove = SKAction.moveBy(x: -dist, y: 0, duration: dur)
        
        let leftMoveProgress = SKAction.moveBy(x: -dist*scene!.size.width/nodes.giveMeRightBoundary(), y: 0, duration: dur)
        progressBar.run(SKAction.repeatForever(leftMoveProgress), withKey: "leftProgress")
        
        cameraNode.run(SKAction.repeatForever(leftMove), withKey: "left")
    }
    
    private func quit() {
        let scene2: InfoScene! = InfoScene(fileNamed: "LearningScene")
        scene2.scaleMode = .aspectFit
        self.scene?.view?.presentScene(scene2, transition: SKTransition.doorsCloseVertical(withDuration: 1.4))
    }
    
    private func quit2() {
        let scene2: IntroScene! = IntroScene(fileNamed: "LearningScene")
        scene2.scaleMode = .aspectFit
        self.scene?.view?.presentScene(scene2, transition: SKTransition.doorsCloseVertical(withDuration: 1.4))
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        VoiceModule.click()
        let location = touches.first?.location(in: self)
        let node = self.atPoint(location!)
        if let name = node.name as String! {
            switch name {
            case "rightNavButtonImage":
                fallthrough
            case "rightNavButton":
                changeColor(node)
                if(cameraNode.position.x < rightBoundary) {
                    moveCamRight()
                }
            case "leftNavButtonImage":
                fallthrough
            case "leftNavButton":
                changeColor(node)
                if(cameraNode.position.x > leftBoundary) {
                    moveCamLeft()
                }
            case "exitButtonImage":
                fallthrough
            case "exitButtonBorder":
                let myAlert: UIAlertController = UIAlertController(title: "Exit To?", message: "Where do you want to go?", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "Bubbles", style: .destructive) { (action:UIAlertAction) in
                    self.quit()
                    VoiceModule.stop()
                }
                let action2 = UIAlertAction(title: "Main Screen", style: .destructive) { (action:UIAlertAction) in
                    self.quit2()
                    VoiceModule.stop()
                }
                let action3 = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in

                }
                
                myAlert.addAction(action1)
                myAlert.addAction(action2)
                myAlert.addAction(action3)
                
                scene!.view?.window?.rootViewController?.present(myAlert, animated: true, completion: nil)
            case "volumeButton":
                fallthrough
            case "volumeButtonImage":
                if(volButton.userData!["mode"] as! String == "on") {
                    volButton.userData!["mode"] = "off"
                    VoiceModule.stop()
                    volButton.texture = SKTexture(imageNamed: "voloff")
                } else {
                    volButton.userData!["mode"] = "on"
                    volButton.texture = SKTexture(imageNamed: "volon")
                }
                nodes.toggleTooltipVolume()
            default:
                print("")
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
        let node = self.atPoint(location!)
        if let name = node.name as String! {
            switch name {
            case "rightNavButtonImage":
                fallthrough
            case "rightNavButton":
                fallthrough
            case "leftNavButtonImage":
                fallthrough
            case "leftNavButton":
                cameraNode.removeAllActions()
                progressBar.removeAllActions()
                let button = node as? SKSpriteNode
                if(button == nil) {
                    (node as! SKShapeNode).fillColor = .clear
                } else {
                    buttons[button!]!.fillColor = .clear
                }
            default:
                print("")
            }
        }
    }
}



