/*:
 # PlaySound
 ## Do you need some helps?
 * Bass Drum: `Jump()`
 * Bass Drum (x2): `DoubleJump()`
 * Roll: `SomerSault()`
 * Charleston: `Slide()`
 
 ## Are you ready?
 Come on, what're you waiting for? Listen the track on PlayMusic(), than write the actions that the sheriff will carry out.
 */

//#-hidden-code
import PlaygroundSupport
import SpriteKit

func playMusic(){
    music = true
}
func jump(){
    mySolution.append("j")
}
func doubleJump(){
    mySolution.append("dj")
}
func somerSault(){
    mySolution.append("ss")
}
func slide(){
    mySolution.append("s")
}
//#-end-hidden-code

//#-code-completion(everything, hide)
//#-code-completion(identifier, show, jump(), doubleJump(), somerSault(), slide(), playMusic())
//#-editable-code Tap to write your code
playMusic()
//#-end-editable-code

//#-hidden-code

let frameWidth = 187.5
let frameHeight = 280.0
let myFrame = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
let view = SKView(frame: myFrame)

//Define the scene
var scene = GameSecondScene()

//Shows this scene on the SKView
view.presentScene(scene)

PlaygroundPage.current.liveView = view
//#-end-hidden-code
