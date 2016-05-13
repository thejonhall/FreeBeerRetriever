import UIKit
import Kanna

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let model : BeerRetrieverModel = BeerRetrieverModel()
        
        let sourceCodeFromFile = self.retrieveSourceCodeFromFile()
        let answeredQuestions = model.parseQuizAnswersFromSourceString(sourceCodeFromFile!)
        
//        let sourceCodeFromBeerquiz = model.retrieveSourceCodeFromBeerquizSite()
//        let answeredQuestions = model.parseQuizAnswersFromSourceString(sourceCodeFromBeerquiz)
        
        for answeredQuestion in answeredQuestions {
            print (answeredQuestion.formattedAnswer)
        }
    }
    
    func retrieveSourceCodeFromFile() -> NSString? {
        do {
            let htmlPath = NSString(string:"/Users/jon.hall/Documents/captainKeith.txt").stringByExpandingTildeInPath
            let fileContent = try NSString(contentsOfFile: htmlPath, encoding: NSUTF8StringEncoding)
            return fileContent
        } catch {
            print(error)
        }
        return nil
    }
}

