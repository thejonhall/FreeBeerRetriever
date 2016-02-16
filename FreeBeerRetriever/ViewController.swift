import UIKit
import Kanna

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let htmlPath = NSString(string:"/Users/jon.hall/Desktop/captainKeith.txt").stringByExpandingTildeInPath
        
        do {
           let fileContent = try NSString(contentsOfFile: htmlPath, encoding: NSUTF8StringEncoding)
//            print ("fileContent : \(fileContent)")
            
            if let doc = Kanna.HTML(html: fileContent as String, encoding: NSUTF8StringEncoding) {
                print(doc.title)

                //                for question in doc.xpath("//span[@id=\"questions\"]") {
                //                    let questionText = question.text! as String
                //                    print(questionText)
                    
                    
                    
                    for possibleAnswer in doc.xpath("//input[@value='1']") {
                        let questionText = possibleAnswer.xpath("../..").text
                        let numberSeparatorIndex = questionText!.rangeOfString(".")?.startIndex
                        let questionNumber = questionText!.substringToIndex(numberSeparatorIndex!)
                        
                        let rawAnswerText = possibleAnswer.xpath("..").text
                        print("Answer to question number: \(questionNumber) : \(rawAnswerText)")
                    }
            }
            
            
            
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

