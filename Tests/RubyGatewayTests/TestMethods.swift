//
//  TestMethods.swift
//  RubyGatewayTests
//
//  Distributed under the MIT license, see LICENSE
//

import Foundation
import XCTest
import RubyGateway

/// Swift methods
class TestMethods: XCTestCase {

    // basic round-trip
    func testFixedArgsRoundTrip() {
        doErrorFree {

            let funcName = "myGlobal"
            let argCount = 1
            let argValue = "Fish"
            let retValue = 8.9
            var visited = false

            try Ruby.defineGlobalFunction(name: funcName, args: argCount) { obj, method in
                XCTAssertFalse(visited)
                visited = true
                XCTAssertEqual(argCount, method.args.count)
                XCTAssertEqual(argValue, String(method.args[0]))
                return RbObject(retValue)
            }

            let actualRetValue = try Ruby.eval(ruby: "\(funcName)(\"\(argValue)\")")

            XCTAssertTrue(visited)
            XCTAssertEqual(retValue, Double(actualRetValue))
        }
    }

    static var allTests = [
        ("testFixedArgsRoundTrip", testFixedArgsRoundTrip)
    ]
}
