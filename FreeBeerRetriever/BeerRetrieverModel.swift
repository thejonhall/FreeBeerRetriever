import Foundation
import Kanna

struct AnsweredQuestion {
    var questionNumber: Int
    var answerLetter: String
    var formattedAnswer: String
}


class BeerRetrieverModel {
    func parseQuizAnswersFromSourceString(sourceString: String) -> [AnsweredQuestion] {
        //            print ("fileContent : \(fileContent)")
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
    
    func condenseWhitespace(inputString : String) -> String {
        let components = inputString.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return components.filter { !$0.isEmpty }.joinWithSeparator(" ")
    }
}
