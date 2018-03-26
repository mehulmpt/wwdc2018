import PlaygroundSupport
import SpriteKit
let cfURL = Bundle.main.url(forResource: "Montserrat-Regular", withExtension: "ttf")! as CFURL
let cfURL2 = Bundle.main.url(forResource: "Montserrat-Bold", withExtension: "ttf")! as CFURL

CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
CTFontManagerRegisterFontsForURL(cfURL2, CTFontManagerScope.process, nil)


let viewController = UIViewController()
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 740, height: 640))

if let scene = IntroScene(fileNamed: "LearningScene") {
    scene.scaleMode = .aspectFit
    sceneView.presentScene(scene)
}

viewController.preferredContentSize = sceneView.frame.size
viewController.view = sceneView

PlaygroundSupport.PlaygroundPage.current.liveView = viewController

