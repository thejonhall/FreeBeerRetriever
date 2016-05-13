import Foundation
import Kanna

struct AnsweredQuestion {
    var questionNumber: Int
    var answerLetter: String
    var formattedAnswer: String
}


class BeerRetrieverModel {
    func parseQuizAnswersFromSourceString(sourceString: NSString) -> [AnsweredQuestion] {
        var answers = [AnsweredQuestion]()
        
        if let doc = Kanna.HTML(html: sourceString as String, encoding: NSUTF8StringEncoding) {
            for possibleAnswer in doc.xpath("//input[@value='1']") {
                let questionText = possibleAnswer.xpath("../..").text
                let numberSeparatorIndex = questionText!.rangeOfString(".")?.startIndex
                let questionNumber = questionText!.substringToIndex(numberSeparatorIndex!)
                
                let rawAnswerText: String = possibleAnswer.xpath("..").text!
                var cleanedUpAnswerText = rawAnswerText.stringByReplacingOccurrencesOfString("\t", withString: "")
                cleanedUpAnswerText = cleanedUpAnswerText.stringByReplacingOccurrencesOfString("\n", withString: "")
                cleanedUpAnswerText = condenseWhitespace(cleanedUpAnswerText)
                
                let questionNumberInt = Int(questionNumber);
                let answeredQuestion = AnsweredQuestion.init(questionNumber: questionNumberInt!, answerLetter: cleanedUpAnswerText, formattedAnswer: "Question \(questionNumber) Answer : \(cleanedUpAnswerText)")
                answers.append(answeredQuestion)
            }
        }
        
        return answers
    }
    
    func retrieveSourceCodeFromBeerquizSite() -> NSString {
        var responseString: String = ""
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
            
            responseString = String(data: data!, encoding: NSUTF8StringEncoding)!
            print("responseString = \(responseString)")
            
        }
        task.resume()
        
        return responseString
    }
    
    
    func condenseWhitespace(inputString : String) -> String {
        let components = inputString.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return components.filter { !$0.isEmpty }.joinWithSeparator(" ")
    }
}
