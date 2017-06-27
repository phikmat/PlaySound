import PlaygroundSupport
import SpriteKit

public class GameSecondScene: SKScene{
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
        
        
        if (mySolution.count == 4){
            self.addChild(gameObstacleNodeScene)
            self.addChild(gameSheriffNodeScene)
            if music == false{
                let bgMusic = SKAction.repeatForever(SKAction.playSoundFileNamed("countryMusic.mp3", waitForCompletion: true))
                self.run(bgMusic)
            } else {
                let bgMusic = SKAction.repeatForever(SKAction.playSoundFileNamed("ProjectPlayground-Audio2.mp3", waitForCompletion: true))
                self.run(bgMusic)
            }
        } else {
            self.addChild(restartGameNode)
            if music == true{
                self.run(SKAction.playSoundFileNamed("ProjectPlayground-Audio2.mp3", waitForCompletion: false))
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
        let eagle = SKSpriteNode(imageNamed: "myeagle.png")
        //Secondo Ostacolo
        let cactus = SKSpriteNode(imageNamed: "cactus.png")
        //Terzo Ostacolo
        let HayTriangle = SKSpriteNode(imageNamed: "myHayTriangleObj.png")
        //Quarto Ostacolo
        let HaySquare = SKSpriteNode(imageNamed: "myHaySquareObj.png")
        
        init(){
            self.eagle.setScale(0.4)
            self.cactus.setScale(0.3)
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
            self.addPosition(obstacle.eagle, height: frame.size.height/10.0*3.0)
            self.addPosition(obstacle.cactus, height: frame.size.height/13.0*3.0)
            self.addPosition(obstacle.HayTriangle, height: frame.size.height/13.0*3.0)
            self.addPosition(obstacle.HaySquare, height: frame.size.height/16.0*3.0)
            //Set Action Of Obstacles
            self.action = SKAction.sequence([SKAction.run({() -> Void in
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
                self.addScrollAction(self.obstacle.eagle)
            }), SKAction.wait(forDuration: 2.5), SKAction.run({() -> Void in
                self.addScrollAction(self.obstacle.cactus)
            }), SKAction.wait(forDuration: 2.5), SKAction.run({() -> Void in
                self.addScrollAction(self.obstacle.HayTriangle)
            }), SKAction.wait(forDuration: 2.5), SKAction.run({() -> Void in
                self.addScrollAction(self.obstacle.HaySquare)
            }), SKAction.wait(forDuration: 5), SKAction.run({() -> Void in
                self.addChild(self.wonString)
            }), SKAction.wait(forDuration: 3), SKAction.run({() -> Void in
                mySolution = [String]()
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
            //Scenes Of Sheriff
            self.getSlide(6.2, index: 0)
            self.getJump(13.7, index: 3)
            self.getDoubleJump(8.7, index: 1)
            self.getSomerSault(11.2, index: 2)
            
            
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
            if (mySolution.count == 4){
                if secondSolution[index] == mySolution[index]{
                    self.addChild(sheriffNode)
                } else{
                    self.addChild(deadSheriffNode)
                }
            }
        }
        
        //Jump Scene Of Sheriff
        func getJump(_ minutes: TimeInterval, index: Int){
            let deadFirstActionSheriff = deadActions(minutes)
            let deadFirstSheriffNode = SKNode()
            deadFirstSheriffNode.run(deadFirstActionSheriff)
            let firstActionSheriff = getActions(minutes, height: obstacle.HaySquare.size.height * 1.25, sequence: self.jumpSequence, angolo: 0)
            let firstSheriffNode = SKNode()
            firstSheriffNode.run(firstActionSheriff)
            controllerSolution(index: index, sheriffNode: firstSheriffNode, deadSheriffNode: deadFirstSheriffNode)
        }
        //DoubleJump Scene Of Sheriff
        func getDoubleJump(_ minutes: TimeInterval, index: Int){
            let deadSecondActionSheriff = deadActions(minutes)
            let deadSecondSheriffNode = SKNode()
            deadSecondSheriffNode.run(deadSecondActionSheriff)
            let secondActionSheriff = getActions(minutes, height: obstacle.cactus.size.height * 1.25, sequence: self.jumpSequence, angolo: 0)
            let secondSheriffNode = SKNode()
            secondSheriffNode.run(secondActionSheriff)
            controllerSolution(index: index, sheriffNode: secondSheriffNode, deadSheriffNode: deadSecondSheriffNode)
        }
        //SomerSault Scene Of Sheriff
        func getSomerSault(_ minutes: TimeInterval, index: Int){
            let deadThirdActionSheriff = deadActions(minutes)
            let deadThirdSheriffNode = SKNode()
            deadThirdSheriffNode.run(deadThirdActionSheriff)
            let thirdActionSheriff = getActions(minutes, height: obstacle.HayTriangle.size.height * 1.25, sequence: self.jumpSequence, angolo: 0.5)
            let thirdSheriffNode = SKNode()
            thirdSheriffNode.run(thirdActionSheriff)
            controllerSolution(index: index, sheriffNode: thirdSheriffNode, deadSheriffNode: deadThirdSheriffNode)
        }
        //Sixth Scene Of Sheriff (slide)
        func getSlide(_ minutes: TimeInterval, index: Int){
            let deadSixthActionSheriff = deadActions(minutes)
            let deadSixthSheriffNode = SKNode()
            deadSixthSheriffNode.run(deadSixthActionSheriff)
            let sixthActionSheriff = getActions(minutes, height: obstacle.eagle.size.height * 2, sequence: self.slideSequence, angolo: 0)
            let sixthSheriffNode = SKNode()
            sixthSheriffNode.run(sixthActionSheriff)
            controllerSolution(index: index, sheriffNode: sixthSheriffNode, deadSheriffNode: deadSixthSheriffNode)
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
