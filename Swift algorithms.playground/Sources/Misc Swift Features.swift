import Foundation

public class ResultTests {

    var fixedLengthArray = Array<Int?>(repeating: nil, count: 17)

    public static func randomEvennumber() -> Result<Int, Error> {
        let randomNumber = Int(arc4random_uniform(100))
        if randomNumber % 2 == 0 {
            return .success(randomNumber)
        }
        let error = NSError(domain: "failure", code: 404, userInfo:nil)
        return .failure(error)
    }
    
}
