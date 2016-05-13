import UIKit
import Kanna

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.saucerknurd.com/glassnite/quiz/")!)
//        request.HTTPMethod = "POST"
//        let postString = "email=thejonhall@gmail.com&UFO=00191&homestore=39"
//        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
//            guard error == nil && data != nil else {
//                print("error=\(error)")
//                return
//            }
//            
//            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response)")
//            }
//            
//            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("responseString = \(responseString)")
//            
//            self.parseQuizAnswersFromSourceString(responseString!)
//            
//        }
//        task.resume()
        
//        Read from file
        
        let model : BeerRetrieverModel = BeerRetrieverModel()
        
        do {
            let htmlPath = NSString(string:"/Users/jon.hall/Documents/captainKeith.txt").stringByExpandingTildeInPath
            let fileContent = try NSString(contentsOfFile: htmlPath, encoding: NSUTF8StringEncoding)
            let answeredQuestions = model.parseQuizAnswersFromSourceString(fileContent as String)
            for answeredQuestion in answeredQuestions {
                print (answeredQuestion.formattedAnswer)
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

