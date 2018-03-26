import Foundation
import SpriteKit

public class RichNode: SKSpriteNode {
    
    private var imageNode: SKSpriteNode!
    private var labelNode: SKSpriteNode!
    
    private var id: CGFloat! = 0
    private let padWidth: CGFloat! = 100
    private var lastCoord: CGFloat! = 0
    private var lastNodeCoord: CGPoint! = nil
    
    private var allLabelNodes: [SKSpriteNode: SKSpriteNode]! = [:]
    private var allLittleBoxes: [SKSpriteNode: CGMutablePath]! = [:]
    private var i: CGFloat = 0
    private var allParentNodes: [SKSpriteNode] = []
    private var allImageNodes: [SKSpriteNode: SKSpriteNode] = [:]
    private var absNodePositions: [CGPoint]? = nil
    private var isHelpvoiceEnabled: Bool! = true
    
    private func drawPipeToLastNode(_ node: SKSpriteNode) {
        if(lastNodeCoord != nil) {
            let pathToDraw:CGMutablePath = CGMutablePath()
            let myLine:SKShapeNode = SKShapeNode(path:pathToDraw)
            
            
            myLine.name = "nodeX\(i)"
            
            myLine.isUserInteractionEnabled = false

            let point1 = CGPoint(x: 0, y: 0)
            let point2 = CGPoint(x: lastNodeCoord.x/2  - node.position.x/2, y: 0)
            let point3 = CGPoint(x: lastNodeCoord.x/2  - node.position.x/2, y: lastNodeCoord.y-node.position.y)
            let point4 = CGPoint(x: lastNodeCoord.x  - node.position.x, y: lastNodeCoord.y-node.position.y)
            let allPoints = [point1, point2, point3, point4]
            pathToDraw.addLines(between: allPoints.reversed())
            
            startBoxFlow(node, pathToDraw)

            myLine.lineWidth = 5.0
            myLine.path = pathToDraw
            myLine.strokeColor = .gray
            myLine.zPosition = -2
            node.addChild(myLine)
        }
    }
    
    public func giveMeRightBoundary() -> CGFloat {
        return convert(allParentNodes.last!.position, from: self.parent!).x - convert(allParentNodes[0].position, from: self.parent!).x
    }
    
    private func startBoxFlow(_ node: SKSpriteNode, _ pathToFollow: CGMutablePath) {
        let block = SKAction.run {
            let redBox = SKSpriteNode(color: UIColor(red: CGFloat(35.0/255.0), green: CGFloat(35.0/255.0), blue: CGFloat(35.0/255.0), alpha: CGFloat(1.0)), size: CGSize(width: 5, height: 5))
            redBox.isUserInteractionEnabled = false
            redBox.zPosition = -1
            node.addChild(redBox)
            let action1 = SKAction.follow(pathToFollow, speed: 25)
            redBox.run(action1) {
                redBox.removeAllActions()
                redBox.removeFromParent()
            }
        }
        
        let sequence = SKAction.sequence([SKAction.wait(forDuration: 2),block])
        
        run(SKAction.repeatForever(sequence))
        
        
    }
    
    
    public func create(image: String, infoText: String, heading: String, spriteFrames: Int, delay: Double) {
        let node = SKSpriteNode()
        let textNode = RichTooltip()
        var imageNode: SKSpriteNode
        
        textNode.userData = [:]
        if(spriteFrames > 1) {
            var walkFrames: [SKTexture] = []
            
            for i in 1...spriteFrames {
                let digit = String(format: "%02d", i-1)
                let texture = SKTexture(imageNamed: "\(image).atlas/frame-\(digit)")
                texture.size()
                walkFrames.append(texture)
            }
            
            
            imageNode = SKSpriteNode(texture: walkFrames[0])
            imageNode.run(SKAction.repeatForever(
                SKAction.animate(with: walkFrames,
                                 timePerFrame: delay,
                                 resize: false,
                                 restore: true)))
            
        } else {
            imageNode = SKSpriteNode(imageNamed: image)
        }
        
        imageNode.name = "image\(id)"
        textNode.name = "text\(id)"
        node.name = "node\(id)"
        textNode.alpha = 0
        
        id = CGFloat(id) + CGFloat(1)
        
        allLabelNodes[node] = textNode
        allImageNodes[node] = imageNode
        
        textNode.isUserInteractionEnabled = true
        
        let scale = imageNode.size.width/imageNode.size.height
        
        if(imageNode.size.height > 200) {
            imageNode.size = CGSize(width: 200*scale, height: 200)
        }
        
        var randomY: CGFloat = CGFloat(arc4random_uniform(101)) - CGFloat(50)
        
        while(randomY < 40 && randomY > -40) {
            randomY = CGFloat(arc4random_uniform(201)) - CGFloat(100)
        }
        
        textNode.options(text: infoText, heading: heading, arrowDirection: randomY > 0 ? "up": "down")
        
        if(lastCoord != 0) {
            if(imageNode.size.width > textNode.calculateAccumulatedFrame().size.width) {
                lastCoord = CGFloat(lastCoord) + imageNode.size.width/2 + padWidth
            } else {
                lastCoord = CGFloat(lastCoord) + textNode.calculateAccumulatedFrame().size.width/2 + padWidth
            }
        }
        
        
        lastCoord = lastCoord == 0 ? scene!.size.width/2 : lastCoord
        
        node.position = CGPoint(
            x: lastCoord,
            y: randomY
        )
        
        node.addChild(textNode)
        node.addChild(imageNode)
        
        drawPipeToLastNode(node)
        i+=1
        
        lastNodeCoord = CGPoint(x: node.position.x, y: randomY)
        
        if(randomY < 0) {
            textNode.position = CGPoint(x: 0, y: 0 + imageNode.size.height/2 + textNode.calculateAccumulatedFrame().size.height/2 + 10)
        } else {
            textNode.position = CGPoint(x: 0, y: 0 - imageNode.size.height/2 - textNode.calculateAccumulatedFrame().size.height/2 - 10)
        }
        
        allParentNodes.append(node)
        self.addChild(node)

        if(imageNode.size.width > textNode.calculateAccumulatedFrame().size.width) {
            lastCoord = CGFloat(lastCoord) + imageNode.size.width/2
        } else {
            lastCoord = CGFloat(lastCoord) + textNode.calculateAccumulatedFrame().size.width/2
        }
        
    }

    private func toggleVisibility(node: RichTooltip) {
        if(node.alpha > 0.5) {
            VoiceModule.stop()
            let action1 = SKAction.fadeAlpha(to: 0, duration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0)
            let action2 = SKAction.moveBy(x: 0, y: node.position.y > 0 ? -5 : 5, duration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0)
            node.run(action1)
            node.run(action2)
        } else {
            switchShow(node: node)
        }
    }
    
    private func switchShow(node: RichTooltip) {
        let action1 = SKAction.fadeAlpha(to: 1, duration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0)
        let action2 = SKAction.moveBy(x: 0, y: node.position.y > 0 ? 5 : -5, duration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0)
        node.run(SKAction.group([action1, action2])) {
            if(self.isHelpvoiceEnabled) {
                VoiceModule.stop()
                VoiceModule.speak(text: node.rawText())
            }
        }
    }
    
    public func toggleTooltipVolume() {
        isHelpvoiceEnabled = !isHelpvoiceEnabled
    }
    
    public func popTooltip(cameraPosX cX: CGFloat) {
        if(absNodePositions == nil) {
            absNodePositions = []
            for node in allParentNodes {
                absNodePositions!.append(convert(node.position, from: self.parent!))
            }
        }

        let pad: CGFloat = 200
        let cameraPosX = cX + absNodePositions![0].x
        for (index, node) in allParentNodes.enumerated() {
            let pos = absNodePositions![index]
            let label = allLabelNodes[node]! as! RichTooltip
            if(label.userData!["autoTrigger"] == nil && pos.x - cameraPosX - scene!.size.width/2 + pad < 0) {
                label.userData!["autoTrigger"] = true
                switchShow(node: label)
            }
        }
        
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
        
        for parentNode in allParentNodes {
            
            let node = allImageNodes[parentNode]!
            
            let width = node.size.width
            let height = node.size.height
            let x = parentNode.position.x
            let y = parentNode.position.y
            
            let locX = location!.x
            let locY = location!.y
            
            
            
            if(locX > x - width/2 && locX < x + width/2 && locY > y - height/2 && locY < y + height/2) {
                allLabelNodes[parentNode]!.userData!["manualTrigger"] = true
                toggleVisibility(node: allLabelNodes[parentNode]! as! RichTooltip)
            }
        }
    }
    
}

