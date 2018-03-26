import Foundation
import SpriteKit

class RichTooltip: SKSpriteNode {
    
    private let fontSize: CGFloat = 15
    private let headingFontSize: CGFloat = 18
    private let lineHeight: CGFloat = 17
    
    private let vertiPad: CGFloat = 25
    private let horizPad: CGFloat = 30
    private var rawLabel: String!
    
    private var firstRowCoord: CGPoint!
    
    public func options(text: String, heading: String, arrowDirection: String) {
        let node = SKSpriteNode()
        let pathToDraw: CGMutablePath = CGMutablePath()
        
        let borderNode: SKShapeNode = SKShapeNode(path: pathToDraw)
        
        let textNode = multiLine(text: text, heading: heading)
        
        if(arrowDirection == "up") {
            pathToDraw.addLines(between: UpArrowPoints(textNode))
        } else {
            pathToDraw.addLines(between: DownArrowPoints(textNode))
        }
        
        borderNode.path = pathToDraw
        borderNode.strokeColor = SKColor.clear
        borderNode.fillColor = .gray
        
        borderNode.position = CGPoint(x: 0, y: 0)
        textNode.position = CGPoint(x: 0, y: -textNode.calculateAccumulatedFrame().size.height/2)
        
        borderNode.addChild(textNode)
        node.addChild(borderNode)
        self.addChild(node)
    }
    
    private func UpArrowPoints(_ textNode: SKLabelNode) -> [CGPoint] {
        
        let width: CGFloat = textNode.calculateAccumulatedFrame().size.width + horizPad
        let height: CGFloat = textNode.calculateAccumulatedFrame().size.height + vertiPad
        
        let topLeft = CGPoint(
            x: -width/2,
            y: height/2 - 10
        )
        
        let bottomLeft = CGPoint(
            x: -width/2,
            y: -height/2 + 10
        )
        
        let ooo1 = CGPoint(
            x: -width/2 + 10,
            y: -height/2
        )
        
        let bottomRight = CGPoint(
            x: width/2 - 10,
            y: -height/2
        )
        
        let ooo2 = CGPoint(
            x: width/2,
            y: -height/2 + 10
        )
        
        let topRight = CGPoint(
            x: width/2,
            y: height/2 - 10
        )
        
        let ooo3 = CGPoint(
            x: width/2 - 10,
            y: height/2
        )
        
        let toArrowFromRight = CGPoint(
            x: 0 + 10,
            y: height/2
        )
        
        let arrowTipUp = CGPoint(
            x: 0,
            y: height/2 + 10
        )
        
        let arrowTipDown = CGPoint(
            x: -10,
            y: height/2
        )
        
        let ooo4 = CGPoint(
            x: -width/2 + 10,
            y: height/2
        )
        
        return [topLeft, bottomLeft, ooo1, bottomRight, ooo2, topRight, ooo3, toArrowFromRight, arrowTipUp, arrowTipDown, ooo4]
    }
    
    private func DownArrowPoints(_ textNode: SKLabelNode) -> [CGPoint] {
        
        let width = textNode.calculateAccumulatedFrame().size.width + horizPad
        let height = textNode.calculateAccumulatedFrame().size.height + vertiPad
        
        let bottomLeft = CGPoint(
            x: -width/2,
            y: -height/2 + 10
        )
        
        let topLeft = CGPoint(
            x: -width/2,
            y: height/2 - 10
        )
        
        let ooo1 = CGPoint(
            x: -width/2 + 10,
            y: height/2
        )
        
        let topRight = CGPoint(
            x: width/2 - 10,
            y: height/2
        )
        
        let ooo2 = CGPoint(
            x: width/2,
            y: height/2 - 10
        )
        
        let bottomRight = CGPoint(
            x: width/2,
            y: -height/2 + 10
        )
        
        let ooo3 = CGPoint(
            x: width/2 - 10,
            y: -height/2
        )
        
        let toArrowFromRight = CGPoint(
            x: 0 + 10,
            y: -height/2
        )
        
        let arrowTipUp = CGPoint(
            x: 0,
            y: -height/2 - 10
        )
        
        let arrowTipDown = CGPoint(
            x: -10,
            y: -height/2
        )
        
        let ooo4 = CGPoint(
            x: -width/2 + 10,
            y: -height/2
        )
        
        return [bottomLeft, topLeft, ooo1, topRight, ooo2, bottomRight, ooo3, toArrowFromRight, arrowTipUp, arrowTipDown, ooo4]
        
    }
    
    public func rawText() -> String {
        return rawLabel
    }
    
    private func isAlphaNum(char: Character) -> Bool {
        switch char {
        case "a"..."z":
            return true
        case "A"..."Z":
            return true
        case "0"..."9":
            return true
        default:
            return false
        }
    }
    
    
    private func multiLine(text: String, heading: String) -> SKLabelNode {
        let textNode = SKLabelNode()
        
        var lineAt: CGFloat = 0
        
        var lines = text.components(separatedBy: "\n")
        
        if(isAlphaNum(char: heading.last!)) {
            rawLabel = heading + ". " + lines.joined(separator: " ")
        } else {
            rawLabel = heading + " " + lines.joined(separator: " ")
        }
        
        
        lines = lines.reversed()
        for line in lines {
            
            let labelNode = SKLabelNode()
            labelNode.fontSize = fontSize
            labelNode.position = CGPoint(x: 0, y: lineAt)
            labelNode.text = line
            labelNode.fontName = "Montserrat-Regular"
            textNode.addChild(labelNode)
            lineAt += lineHeight
        }
        
        let headingNode = SKLabelNode(text: heading)
        headingNode.fontSize = headingFontSize
        headingNode.fontName = "Montserrat-Bold"
        headingNode.position = CGPoint(x: 0, y: lineAt+10)
        
        textNode.addChild(headingNode)
        
        return textNode
    }
}

