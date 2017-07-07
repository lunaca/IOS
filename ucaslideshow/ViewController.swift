import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var name : String
    @IBOutlet private var label : UILabel!
    @IBOutlet private var imageView : UIImageView!
    private var rand_no : Int?
    private var rand_no1 : Int
    private var images : [UIImage]
    private var player : AVAudioPlayer?
    
    
    required init?(coder aDecoder: NSCoder)
    {
        let res = false;
        //Initialize base class properties
        
        name = "Joe"
        
        srand(UInt32(time(nil)))
        rand_no = Int(rand()%2)
        rand_no1 = 0;
        
        images = [UIImage]()
        
        
        
        super.init(coder: aDecoder)! //This can return a nil and stop the method!
        var saved = [1]
        var isDuplicate : Bool = true
        rand_no1 = 1
        var i = 0
        repeat
        {
            
            
            
            var j = 0
            repeat
            {
                isDuplicate = true
                
                while(isDuplicate == true){
                    if(rand_no1 == saved[j]){
                        rand_no1 = Int(rand()%25 + 1)
                        j = 0
                        isDuplicate = true
                        break
                    }
                    else {
                        isDuplicate = false
                        j++
                    }
                }
                
            }while j < saved.count
            
            
            saved.append(rand_no1)
            
            i += 1
            print(i)
        }while i <= 23
        print("Broke for")
        print(saved)
        for i in 0...24{
            var fn = "pic" + "\(saved[i])" + ".jpg"
            var img = UIImage (named: fn)
            rand_no1 = Int(rand()%10 + 1)
            images.append(img!)
            
        }
        
        
        
        if (rand_no == 0)
        {
            var path = NSBundle.mainBundle().pathForResource("UCA", ofType: "mp3")
            var urlvalue = NSURL(fileURLWithPath: path!)
            
            try! player = AVAudioPlayer(contentsOfURL: urlvalue)
            
        }
        else
        {
            var path = NSBundle.mainBundle().pathForResource("UCAFightSong", ofType: "mp3")
            var urlvalue = NSURL(fileURLWithPath: path!)
            
            try! player = AVAudioPlayer(contentsOfURL: urlvalue)
        }
        
        
        var path = NSBundle.mainBundle().pathForResource("UCA", ofType: "mp3")
        var urlvalue = NSURL(fileURLWithPath: path!)
        
        try! player = AVAudioPlayer(contentsOfURL: urlvalue)
        
        
        
        player?.numberOfLoops = -1
        player?.prepareToPlay()
        player?.play()
        
        
        //Initialize your class's properties
        
        //If one data field is not set, you can return nil (Example of returning nil)
        if (res == false)
        {
            
            //return nil
        }
        
    }
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        imageView.animationImages = images
        imageView.animationDuration = Double(images.count)
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
        
        
    }
    
    func methodThrowsException() throws
    {
        try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: "http://www.uca.edu"))
    }
    
    
    func anotherMethod() throws
    {
        try methodThrowsException()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


