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
                    for possibleAnswer in doc.xpath("//input[@value='1']") {
                        let questionText = possibleAnswer.xpath("../..").text
                        let numberSeparatorIndex = questionText!.rangeOfString(".")?.startIndex
                        let questionNumber = questionText!.substringToIndex(numberSeparatorIndex!)
                        
                        let rawAnswerText: String = possibleAnswer.xpath("..").text!
                        var cleanedUpAnswerText = rawAnswerText.stringByReplacingOccurrencesOfString("\t", withString: "")
                        cleanedUpAnswerText = cleanedUpAnswerText.stringByReplacingOccurrencesOfString("\n", withString: "")
                        cleanedUpAnswerText = cleanedUpAnswerText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                        print("Question \(questionNumber) Answer : \(cleanedUpAnswerText)")
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

