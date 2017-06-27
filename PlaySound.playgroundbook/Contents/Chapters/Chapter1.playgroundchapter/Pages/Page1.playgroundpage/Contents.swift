/*:
 # PlaySound
 ## Create your game scene by  sound
 Welcome on PlaySound!
 The aim of the game is to drive the sheriff until the final scene. Do you believe that is this easy?
 Sure, but careful! There are some stumbling blocks during the path. Well, do you think still that this is a common game? The PlaySound’s newness is the application of the music to move forward  across the unique way to get to the finishing line, because the sheriff can’t see the path!
 So you have to listen the track of the game to choose the actions that the sheriff will carry out during the path.
 ## Do you need some helps?
 * Bass Drum: `Jump()`
 * Bass Drum (x2): `DoubleJump()`
 * Roll: `SomerSault()`
 * Charleston: `Slide()`
 
 ## Great! 
 Before to start the game, take a look at following demo.
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
jump()
doubleJump()
somerSault()
jump()
jump()
slide()
//#-end-editable-code

//#-hidden-code

let frameWidth = 187.5
let frameHeight = 280.0
let myFrame = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
let view = SKView(frame: myFrame)

//Define the scene
var scene = GameFirstScene()

//Shows this scene on the SKView
view.presentScene(scene)
PlaygroundPage.current.liveView = view
//#-end-hidden-code
