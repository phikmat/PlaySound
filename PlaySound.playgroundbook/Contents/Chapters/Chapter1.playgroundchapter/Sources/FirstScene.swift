import PlaygroundSupport
import SpriteKit

public let myWidth = 187.5
public let myHeight = 280.0
public let gameFrame = CGRect(x: 0, y: 0, width: myWidth, height: myHeight)
public let ostacoliWidth = gameFrame.size.width * 1.33
public var mySolution = [String]()
public var music = false
public var actualScene = 1
public let firstSolution = ["j", "dj", "ss", "j", "j", "s"]
public let secondSolution = ["s", "dj", "ss", "j"]

public class GameFirstScene: SKScene{
    var fontColor = SKColor.white
    
    let backgroundNode = BackgroundNode()
    var gameObstacleNodeScene = GameObstacleNodeFirstScene()
    var gameSheriffNodeScene = GameSheriffNodeFirstScene()
    var restartGameNode = RestartGameNode()
    
    public override func didMove(to view: SKView) {
        self.size = gameFrame.size
        self.backgroundColor = SKColor.white
        
        backgroundNode.position = CGPoint(x: 0, y: 0)
        self.addChild(backgroundNode)
        
        gameObstacleNodeScene.position = CGPoint(x: 0, y: 0)
        
        gameSheriffNodeScene.position = CGPoint(x: 0, y: 0)
        
        
        if (mySolution.count == 6){
            self.addChild(gameObstacleNodeScene)
            self.addChild(gameSheriffNodeScene)
            if music == false{
                let bgMusic = SKAction.repeatForever(SKAction.playSoundFileNamed("countryMusic.mp3", waitForCompletion: true))
                self.run(bgMusic)
            } else {
                let bgMusic = SKAction.repeatForever(SKAction.playSoundFileNamed("ProjectPlayground-Audio1.mp3", waitForCompletion: true))
                self.run(bgMusic)
            }
        } else {
            self.addChild(restartGameNode)
            if music == true{
                self.run(SKAction.playSoundFileNamed("ProjectPlayground-Audio1.mp3", waitForCompletion: false))
            }
        }
    }
    
    public class BackgroundNode: SKNode{
        //First Background Layer: Sky
        let sky = SKSpriteNode(imageNamed: "myBackground.png")
        //Second Background Layer: First Hill
        let hill1 = SKSpriteNode(imageNamed: "mySecondMountain.png")
        //Second Background Layer: Second Hill
        let hill2 = SKSpriteNode(imageNamed: "myMountain.png")
        //Third Background Layer: Clouds
        let clouds = SKSpriteNode(imageNamed: "myClouds.png")
        //Third Background Layer: Ground
        let ground = SKSpriteNode(imageNamed: "myGround.png")
        
        override init(){
            super.init()
            self.addBgNode(bgNode: sky, width: gameFrame.size.width, action: false, duration: 0)
            self.addBgNode(bgNode: hill1, width: gameFrame.size.width*3, action: true, duration: 13)
            self.addBgNode(bgNode: hill2, width: gameFrame.size.width*3, action: true, duration: 11)
            self.addBgNode(bgNode: clouds, width: gameFrame.size.width*3, action: true, duration: 9)
            self.addBgNode(bgNode: ground, width: gameFrame.size.width*3, action: true, duration: 3)
        }
        required public init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func addBgNode(bgNode: SKSpriteNode, width:CGFloat, action:Bool, duration: TimeInterval){
            bgNode.size = CGSize(width: width, height: gameFrame.size.height)
            bgNode.position = CGPoint(x: gameFrame.size.width/2.0, y: gameFrame.size.height/2.0)
            if action{
                bgNode.run(SKAction.repeatForever(SKAction.sequence([
                    SKAction.moveBy(x: -(gameFrame.size.width), y: 0, duration:duration),
                    SKAction.moveBy(x: gameFrame.size.width, y: 0, duration: 0)
                    ])))
            }
            self.addChild(bgNode)
        }
    }
    
    public class RestartGameNode: SKNode{
        //Labels
        var loseString = myLabel("You Lose")
        var errorString = myLabel("Error")
        var errorSubString = mySubLabel("You must call six actions")
        //Sheriff in listening
        let sheriffListner = SKSpriteNode(imageNamed: "idle0001.png")
        //Headphones
        let headphones = SKSpriteNode(imageNamed: "cuffieSmall.png")
        
        var restartGame = SKAction()
        override init(){
            super.init()
            //Setting for listening
            sheriffListner.position = CGPoint(x: gameFrame.size.width/2, y: gameFrame.size.height/13.0*3.0)
            sheriffListner.setScale(0.5)
            //Setting of Headphones
            headphones.setScale(0.4)
            headphones.position = CGPoint(x: gameFrame.size.width/2, y: gameFrame.size.height/1.5)
            //Action of Sestart Game
            self.restartGame = SKAction.sequence([SKAction.run({() -> Void in
                if !music {
                    self.addChild(self.errorString)
                    self.addChild(self.errorSubString)
                    self.addChild(self.sheriffListner)
                } else {
                    self.addChild(self.headphones)
                }
                mySolution = [String]()
            }), SKAction.wait(forDuration: 6), SKAction.run({() -> Void in
                PlaygroundPage.current.finishExecution()
            })])
            self.run(restartGame)
        }
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    public class GameObstacleFirstScene{
        //Primo Ostacolo
        public let ostacolo1 = SKSpriteNode(imageNamed: "myHaySquareObj.png")
        //Secondo Ostacolo
        public let ostacolo2 = SKSpriteNode(imageNamed: "cactus.png")
        //Terzo Ostacolo
        public let ostacolo3 = SKSpriteNode(imageNamed: "myHayTriangleObj.png")
        //Quarto Ostacolo
        public let ostacolo4 = SKSpriteNode(imageNamed: "myHaySquareObj.png")
        //Quinto Ostacolo
        public let ostacolo5 = SKSpriteNode(imageNamed: "myHaySquareObj.png")
        //Sesto Ostacolo
        public let ostacolo6 = SKSpriteNode(imageNamed: "myeagle.png")
        
        init(){
            self.ostacolo2.setScale(0.3)
            self.ostacolo6.setScale(0.4)
        }
    }
    
    public class GameObstacleNodeFirstScene: SKNode{
        let obstacle = GameObstacleFirstScene()
        
        //Labels
        var treeString = myLabel("3")
        var twoString = myLabel("2")
        var oneString = myLabel("1")
        var goString = myLabel("Go!")
        var wonString = myLabel("You Won!")
        //ActionOfObstacles
        var action = SKAction()
        
        override init(){
            super.init()
            //Add Obstacles to Node
            self.addPosition(obstacle.ostacolo1, height: gameFrame.size.height/16.0*3.0)
            self.addPosition(obstacle.ostacolo2, height: gameFrame.size.height/13.0*3.0)
            self.addPosition(obstacle.ostacolo3, height: gameFrame.size.height/13.0*3.0)
            self.addPosition(obstacle.ostacolo4, height: gameFrame.size.height/16.0*3.0)
            self.addPosition(obstacle.ostacolo5, height: gameFrame.size.height/16.0*3.0)
            self.addPosition(obstacle.ostacolo6, height: gameFrame.size.height/10.0*3.0)
            //Set Action Of Obstacles
            self.action = SKAction.sequence([SKAction.run({() -> Void in
                //scene.addChild(sheriff)
            }), SKAction.wait(forDuration: 1), SKAction.run({() -> Void in
                self.addChild(self.treeString)
            }), SKAction.wait(forDuration: 1), SKAction.run({() -> Void in
                self.removeChildren(in: [self.treeString])
                self.addChild(self.twoString)
            }), SKAction.wait(forDuration: 1), SKAction.run({() -> Void in
                self.removeChildren(in: [self.twoString])
                self.addChild(self.oneString)
            }), SKAction.wait(forDuration: 1), SKAction.run({() -> Void in
                self.removeChildren(in: [self.oneString])
                self.addChild(self.goString)
            }), SKAction.wait(forDuration: 0.5), SKAction.run({() -> Void in
                self.removeChildren(in: [self.goString])
                self.addScrollAction(self.obstacle.ostacolo1)
            }), SKAction.wait(forDuration: 2.5), SKAction.run({() -> Void in
                self.addScrollAction(self.obstacle.ostacolo2)
            }), SKAction.wait(forDuration: 2.5), SKAction.run({() -> Void in
                self.addScrollAction(self.obstacle.ostacolo3)
            }), SKAction.wait(forDuration: 2.5), SKAction.run({() -> Void in
                self.addScrollAction(self.obstacle.ostacolo4)
            }), SKAction.wait(forDuration: 2.5), SKAction.run({() -> Void in
                self.addScrollAction(self.obstacle.ostacolo5)
            }), SKAction.wait(forDuration: 2.5), SKAction.run({() -> Void in
                self.addScrollAction(self.obstacle.ostacolo6)
            }), SKAction.wait(forDuration: 5), SKAction.run({() -> Void in
                self.addChild(self.wonString)
            }), SKAction.wait(forDuration: 3), SKAction.run({() -> Void in
                mySolution = [String]()
                //                self.removeChildren(in: [self])
                PlaygroundPage.current.finishExecution()
            })
                ])
            self.run(action)
        }
        required public init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func addPosition(_ ostacolo: SKSpriteNode, height: CGFloat){
            ostacolo.position = CGPoint(x: ostacoliWidth, y: height)
        }
        func addScrollAction(_ ostacolo: SKSpriteNode){
            ostacolo.run(SKAction.moveBy(x: -(gameFrame.size.width)*1.66, y: 0, duration:5.0))
            self.addChild(ostacolo)
        }
    }
    
    
    public class GameSheriffNodeFirstScene: SKNode{
        //Sheriff
        private let loseString = myLabel("You Lose")
        let sheriff = SKSpriteNode(imageNamed: "run0001.png")
        //Explosion
        let explosion = SKSpriteNode(imageNamed: "explosion.png")
        //Frames for run
        let runFrames = [
            SKTexture(imageNamed: "run0001.png"),
            SKTexture(imageNamed: "run0003.png"),
            SKTexture(imageNamed: "run0005.png"),
            SKTexture(imageNamed: "run0007.png"),
            SKTexture(imageNamed: "run0011.png"),
            SKTexture(imageNamed: "run0013.png"),
            SKTexture(imageNamed: "run0015.png"),
            SKTexture(imageNamed: "run0017.png")
        ]
        //Frames for jump
        let jumpFrames = [
            SKTexture(imageNamed: "jump0001.png"),
            SKTexture(imageNamed: "jump0003.png"),
            SKTexture(imageNamed: "jump0005.png"),
            SKTexture(imageNamed: "jump0007.png"),
            SKTexture(imageNamed: "jump0009.png"),
            SKTexture(imageNamed: "jump0011.png"),
            SKTexture(imageNamed: "jump0013.png"),
            SKTexture(imageNamed: "jump0015.png"),
            SKTexture(imageNamed: "jump0017.png")
        ]
        //Frames for slide
        let slideFrames = [
            SKTexture(imageNamed: "slide.png")
        ]
        //Run Sequence
        let duration = 1.5 + drand48() * 1.0
        var runMove = SKAction()
        var wait = SKAction()
        var runRest = SKAction()
        var runSequence = SKAction()
        //Jump Sequence
        var jumpMove = SKAction()
        var jumpRest = SKAction()
        var jumpSequence = SKAction()
        //Slide Sequence
        var slideMove = SKAction()
        var slideRest = SKAction()
        var slideSequence = SKAction()
        //Default Setting
        let jumpDuration = 0.7
        let landing = 1.6
        let obstacle = GameObstacleFirstScene()
        //Scenes
        //First Scene Of Sheriff
        var deadFirstActionSheriff = SKAction()
        let deadFirstSheriffNode = SKNode()
        var firstActionSheriff = SKAction()
        let firstSheriffNode = SKNode()
        //Second Scene Of Sheriff
        var deadSecondActionSheriff = SKAction()
        let deadSecondSheriffNode = SKNode()
        var secondActionSheriff = SKAction()
        let secondSheriffNode = SKNode()
        //Thirth Scene Of Sheriff
        var deadThirdActionSheriff = SKAction()
        let deadThirdSheriffNode = SKNode()
        var thirdActionSheriff = SKAction()
        let thirdSheriffNode = SKNode()
        //Fourth Scene Of Sheriff
        var deadFourthActionSheriff = SKAction()
        let deadFourthSheriffNode = SKNode()
        var fourthActionSheriff = SKAction()
        let fourthSheriffNode = SKNode()
        //Fifth Scene Of Sheriff
        var deadFivethActionSheriff = SKAction()
        let deadFivethSheriffNode = SKNode()
        var fivethActionSheriff = SKAction()
        let fivethSheriffNode = SKNode()
        //Sixth Scene Of Sheriff
        var deadSixthActionSheriff = SKAction()
        let deadSixthSheriffNode = SKNode()
        var sixthActionSheriff = SKAction()
        let sixthSheriffNode = SKNode()
        
        override init(){
            super.init()
            self.addChild(sheriff)
            self.explosion.position = CGPoint(x: gameFrame.size.width/2, y: gameFrame.size.height/13.0*3.0)
            self.sheriff.position = CGPoint(x: gameFrame.size.width/2, y: gameFrame.size.height/13.0*3.0)
            self.sheriff.setScale(0.5)
            //Setting of Run Sequence
            self.runMove = SKAction.animate(with:self.runFrames, timePerFrame:0.1)
            self.wait = SKAction.wait(forDuration:self.duration)
            self.runRest = SKAction.setTexture(self.runFrames[0])
            self.runSequence = SKAction.sequence([self.runMove, self.runRest])
            self.sheriff.run(SKAction.repeatForever(self.runSequence))
            //Setting of Jump Sequence
            self.jumpMove = SKAction.animate(with:self.jumpFrames, timePerFrame:0.2)
            self.jumpRest = SKAction.setTexture(self.jumpFrames[0])
            self.jumpSequence = SKAction.sequence([self.jumpMove, self.jumpRest])
            //Setting of Sliede sequence
            self.slideMove = SKAction.animate(with:self.slideFrames, timePerFrame:0.1)
            self.slideRest = SKAction.setTexture(self.slideFrames[0])
            self.slideSequence = SKAction.sequence([self.slideMove, self.slideRest])
            //First Scene Of Sheriff
            self.deadFirstActionSheriff = deadActions(6.2)
            self.deadFirstSheriffNode.run(self.deadFirstActionSheriff)
            self.firstActionSheriff = getActions(6.2, height: self.obstacle.ostacolo1.size.height * 1.25, sequence: self.jumpSequence, angolo: 0)
            self.firstSheriffNode.run(self.firstActionSheriff)
            controllerSolution(index: 0, sheriffNode: self.firstSheriffNode, deadSheriffNode: self.deadFirstSheriffNode)
            //Second Scene Of Sheriff
            self.deadSecondActionSheriff = deadActions(8.7)
            self.deadSecondSheriffNode.run(self.deadSecondActionSheriff)
            self.secondActionSheriff = getActions(8.7, height: self.obstacle.ostacolo2.size.height * 1.25, sequence: self.jumpSequence, angolo: 0)
            self.secondSheriffNode.run(self.secondActionSheriff)
            controllerSolution(index: 1, sheriffNode: self.secondSheriffNode, deadSheriffNode: self.deadSecondSheriffNode)
            //Thirth Scene Of Sheriff
            self.deadThirdActionSheriff = deadActions(11.2)
            self.deadThirdSheriffNode.run(self.deadThirdActionSheriff)
            self.thirdActionSheriff = getActions(11.2, height: self.obstacle.ostacolo3.size.height * 1.25, sequence: self.jumpSequence, angolo: 0.5)
            self.thirdSheriffNode.run(self.thirdActionSheriff)
            controllerSolution(index: 2, sheriffNode: self.thirdSheriffNode, deadSheriffNode: self.deadThirdSheriffNode)
            //Fourth Scene Of Sheriff
            self.deadFourthActionSheriff = deadActions(13.7)
            self.deadFourthSheriffNode.run(self.deadFourthActionSheriff)
            self.fourthActionSheriff = getActions(13.7, height: self.obstacle.ostacolo1.size.height * 1.25, sequence: self.jumpSequence, angolo: 0)
            self.fourthSheriffNode.run(self.fourthActionSheriff)
            controllerSolution(index: 3, sheriffNode: self.fourthSheriffNode, deadSheriffNode: self.deadFourthSheriffNode)
            //Fifth Scene Of Sheriff
            self.deadFivethActionSheriff = deadActions(16.2)
            self.deadFivethSheriffNode.run(self.deadFivethActionSheriff)
            self.fivethActionSheriff = getActions(16.2, height: self.obstacle.ostacolo1.size.height * 1.25, sequence: self.jumpSequence, angolo: 0)
            self.fivethSheriffNode.run(self.fivethActionSheriff)
            controllerSolution(index: 4, sheriffNode: self.fivethSheriffNode, deadSheriffNode: self.deadFivethSheriffNode)
            //Sixth Scene Of Sheriff
            self.deadSixthActionSheriff = deadActions(18.7)
            self.deadSixthSheriffNode.run(self.deadSixthActionSheriff)
            self.sixthActionSheriff = getActions(18.7, height: self.obstacle.ostacolo6.size.height * 1.75, sequence: self.slideSequence, angolo: 0.5)
            self.sixthSheriffNode.run(self.sixthActionSheriff)
            controllerSolution(index: 5, sheriffNode: self.sixthSheriffNode, deadSheriffNode: self.deadSixthSheriffNode)
            
            
        }
        required public init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func deadActions(_ duration: TimeInterval) -> SKAction{
            return SKAction.sequence([SKAction.run({() -> Void in
            }), SKAction.wait(forDuration: duration), SKAction.run({() -> Void in
                self.sheriff.removeAllActions()
            }), SKAction.wait(forDuration: 0.3), SKAction.run({() -> Void in
                self.addChild(self.explosion)
                self.addChild(self.loseString)
            }), SKAction.wait(forDuration: 1), SKAction.run({() -> Void in
                mySolution = [String]()
                PlaygroundPage.current.finishExecution()
            })
                ])
        }
        
        func getActions(_ duration: TimeInterval, height: CGFloat, sequence: SKAction, angolo: Double) -> SKAction{
            var myHeight:CGFloat = height
            if sequence == slideSequence{
                myHeight *= -1
            }
            return SKAction.sequence([SKAction.run({() -> Void in
            }), SKAction.wait(forDuration: duration), SKAction.run({() -> Void in
                self.sheriff.removeAllActions()
                self.sheriff.run(SKAction.repeatForever(sequence))
                self.sheriff.run(SKAction.moveBy(x: 0, y: myHeight, duration:self.jumpDuration))
                if angolo != 0{
                    self.sheriff.run(SKAction.rotate(toAngle:CGFloat(-.pi/angolo), duration: self.jumpDuration+self.landing))
                }
            }), SKAction.wait(forDuration: self.jumpDuration), SKAction.run({() -> Void in
                self.sheriff.run(SKAction.moveBy(x: 0, y: -myHeight, duration:self.landing))
            }), SKAction.wait(forDuration: self.landing), SKAction.run({() -> Void in
                self.sheriff.removeAllActions()
                self.sheriff.run(SKAction.repeatForever(self.runSequence))
            })
                ])
        }
        
        func controllerSolution(index: Int, sheriffNode: SKNode, deadSheriffNode: SKNode){
            if (mySolution.count == 6){
                if firstSolution[index] == mySolution[index]{
                    self.addChild(sheriffNode)
                } else{
                    self.addChild(deadSheriffNode)
                }
            }
        }
        
        
    }
    
    public class myLabel: SKLabelNode{
        init(_ string: String){
            super.init()
            self.text = string
            self.fontColor = fontColor
            self.fontSize = 30
            self.fontName = "AvenirNext-Bold"
            self.position = CGPoint(x: gameFrame.size.width/2, y: gameFrame.size.height/2)
        }
        required public init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    public class mySubLabel: SKLabelNode{
        init(_ string: String){
            super.init()
            self.text = string
            self.fontColor = fontColor
            self.fontSize = 15
            self.fontName = "AvenirNext-Regular"
            self.position = CGPoint(x: gameFrame.size.width/2, y: gameFrame.size.height/2.4)
        }
        required public init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
}

