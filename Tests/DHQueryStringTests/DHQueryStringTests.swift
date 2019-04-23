import XCTest
@testable import DHQueryString

class DHQueryStringTests: XCTestCase {
    private let greeting = "%E3%81%8A%E3%81%AF%E3%82%88%E3%81%86%E3%81%94%E3%81%96%E3%81%84%E3%81%BE%E3%81%99%EF%BC%81%E3%81%93%E3%82%93%E3%81%AB%E3%81%A1%E3%81%AF%EF%BC%81"
    
    func testToDictionary() {
        XCTAssertEqual(DHQueryString.toDictionary(""), [:])
        XCTAssertEqual(DHQueryString.toDictionary("name,aaa"), [:])
        
        let queryString = "name=Hottin&age=24"
        XCTAssertEqual(DHQueryString.toDictionary(queryString), ["name":"Hottin", "age":"24"])
        
        let queryStringPercent = "name=Tatsuya%20Hotta&age=24"
        XCTAssertEqual(DHQueryString.toDictionary(queryStringPercent), ["name":"Tatsuya Hotta", "age":"24"])
        XCTAssertEqual(DHQueryString.toDictionary(queryStringPercent, removePercentEncoding: false),
                       ["name":"Tatsuya%20Hotta", "age":"24"])
        
        let queryStringMultiByte = "greeting=\(greeting)"
        XCTAssertEqual(DHQueryString.toDictionary(queryStringMultiByte), ["greeting":"おはようございます！こんにちは！"])
        XCTAssertEqual(DHQueryString.toDictionary(queryStringMultiByte, removePercentEncoding: false),
                       ["greeting":greeting])
    }
    
    func testToStringFromDictionary() {
        XCTAssertEqual(DHQueryString.toString([:]), "")
        
        let dict = ["name":"Hottin", "age":"24"]
        XCTAssertTrue(DHQueryString.toString(dict).contains("name=Hottin"))
        XCTAssertTrue(DHQueryString.toString(dict).contains("age=24"))
        
        let dictSpace = ["name":"Tatsuya Hotta", "age":"24"]
        XCTAssertTrue(DHQueryString.toString(dictSpace).contains("name=Tatsuya%20Hotta"))
        XCTAssertTrue(DHQueryString.toString(dictSpace).contains("age=24"))
        
        let dictMutlibyte = ["greeting":"おはようございます！こんにちは！", "おはようございます！こんにちは！":"greeting"]
        XCTAssertTrue(DHQueryString.toString(dictMutlibyte).contains("greeting=\(greeting)"))
        XCTAssertTrue(DHQueryString.toString(dictMutlibyte).contains("\(greeting)=greeting"))
        
        XCTAssertTrue(DHQueryString.toString(dictMutlibyte, addingPercentEncoding: false)
            .contains( "greeting=おはようございます！こんにちは！"))
        XCTAssertTrue(DHQueryString.toString(dictMutlibyte, addingPercentEncoding: false)
            .contains("おはようございます！こんにちは！=greeting"))
    }
    
    func testToStringFromDictionaryLiteral() {
        // Test Ordered Dictionary Like
        let dict: KeyValuePairs = ["name":"Hottin", "age":"24"]
        XCTAssertEqual(DHQueryString.toString(dict), "name=Hottin&age=24")
        
        let dictSpace: KeyValuePairs = ["name":"Tatsuya Hotta", "age":"24"]
        XCTAssertEqual(DHQueryString.toString(dictSpace), "name=Tatsuya%20Hotta&age=24")
        
        let dictMutlibyte: KeyValuePairs =
            ["greeting":"おはようございます！こんにちは！", "おはようございます！こんにちは！":"greeting"]
        XCTAssertEqual(DHQueryString.toString(dictMutlibyte), "greeting=\(greeting)&\(greeting)=greeting")
        XCTAssertEqual(DHQueryString.toString(dictMutlibyte, addingPercentEncoding: false),
                       "greeting=おはようございます！こんにちは！&おはようございます！こんにちは！=greeting")
    }
    
    static var allTests = [
        ("testToDictionary", testToDictionary),
        ("testToStringFromDictionary", testToStringFromDictionary),
        ("testToStringFromDictionaryLiteral", testToStringFromDictionaryLiteral),
    ]
}
