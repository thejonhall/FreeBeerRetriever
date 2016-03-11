import UIKit
import Kanna

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.saucerknurd.com/glassnite/quiz/")!)
        request.HTTPMethod = "POST"
        let postString = "email=thejonhall@gmail.com&UFO=00191&homestore=39"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
            self.parseQuizAnswersFromSourceString(responseString!)
            
        }
        task.resume()
        
//        Read from file
        
//        do {
//            let htmlPath = NSString(string:"/Users/jon.hall/Desktop/captainKeith.txt").stringByExpandingTildeInPath
//            let fileContent = try NSString(contentsOfFile: htmlPath, encoding: NSUTF8StringEncoding)
//            parseQuizAnswersFromSourceString(fileContent as String)
//        } catch {
//            print(error)
//        }
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func condenseWhitespace(inputString : String) -> String {
        let components = inputString.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return components.filter { !$0.isEmpty }.joinWithSeparator(" ")
    }
    
    func parseQuizAnswersFromSourceString(sourceString : NSString) {
        //            print ("fileContent : \(fileContent)")
        
        if let doc = Kanna.HTML(html: sourceString as String, encoding: NSUTF8StringEncoding) {
            for possibleAnswer in doc.xpath("//input[@value='1']") {
                let questionText = possibleAnswer.xpath("../..").text
                let numberSeparatorIndex = questionText!.rangeOfString(".")?.startIndex
                let questionNumber = questionText!.substringToIndex(numberSeparatorIndex!)
                
                let rawAnswerText: String = possibleAnswer.xpath("..").text!
                var cleanedUpAnswerText = rawAnswerText.stringByReplacingOccurrencesOfString("\t", withString: "")
                cleanedUpAnswerText = cleanedUpAnswerText.stringByReplacingOccurrencesOfString("\n", withString: "")
                cleanedUpAnswerText = condenseWhitespace(cleanedUpAnswerText)
                print("Question \(questionNumber) Answer : \(cleanedUpAnswerText)")
            }
        }
        
    }
}

