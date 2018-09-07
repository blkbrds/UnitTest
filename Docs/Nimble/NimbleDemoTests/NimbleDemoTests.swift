//
//  NimbleDemoTests.swift
//  NimbleDemoTests
//
//  Created by Lam Le V. on 12/18/17.
//  Copyright © 2017 Lam Le V. All rights reserved.
//

import Nimble
import XCTest
@testable import NimbleDemo

//Built-in Matcher Functions
protocol SomeProtocol {}
class SomeClassConformingToProtocol: SomeProtocol {}
struct SomeStructConformingToProtocol: SomeProtocol {}

// Equivalence
enum Result {
    case success
    case failure(String)
}

extension Result: Equatable {

    public static func == (lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true
        case let (.failure(lhsValue), .failure(rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}

final class NimbleDemoTests: XCTestCase {

    func testGeneral() {

        // Compare
        expect(1 + 1).to(equal(2))
        expect(1 + 1) == 2

        expect(10).to(beGreaterThan(2))
        expect(10) > 2

        expect(2).to(beLessThan(10))
        expect(2) < 10

        expect(10).to(beLessThanOrEqualTo(10))
        expect(10) >= 2
        expect(10) >= 10

        expect(10).to(beGreaterThanOrEqualTo(10))
        expect(10) <= 10

        // beAkindOf
        class A {}
        class B: A {}

        let classA = A()
        let classB = B()

        expect(classA).to(beAKindOf(A.self))
        expect(classB).to(beAKindOf(A.self))
        expect(classA).to(beAKindOf(B.self))
        expect(classB).to(beAKindOf(B.self))

        expect(classA).to(beAnInstanceOf(A.self))
        expect(classB).to(beAnInstanceOf(A.self))
        expect(classA).to(beAnInstanceOf(B.self))
        expect(classB).to(beAnInstanceOf(B.self))

        // Nil
        let nilActual: String? = nil
        expect(nilActual).to(beNil())

        // Error handling
        enum SomethingError: Error {
            case testingError
            case testingError2
        }

        func somethingThatThrows() throws {
            throw SomethingError.testingError
        }
        expect { try somethingThatThrows() }.to(throwError())

        // Passes if 'somethingThatThrows()' throws a particular error enum case:
        expect { try somethingThatThrows() }.to(throwError(SomethingError.testingError))
        expect { try somethingThatThrows() }.to(throwError(SomethingError.testingError2))

        // Passes if 'somethingThatThrows()' throws an error of a particular type:
        expect { try somethingThatThrows() }.to(throwError(errorType: SomethingError.self))

        // Passes if 'somethingThatThrows()' throws an error within a particular domain:
        expect { try somethingThatThrows() }.to(throwError { (error: Error) in
            expect(error._domain).to(equal(NSCocoaErrorDomain))
        })

        let errorActual: SomethingError = .testingError
        expect(errorActual).to(matchError(SomethingError.self))
        expect(errorActual).to(matchError(SomethingError.testingError))

        let errorDomain = NSError(domain: "err", code: 123, userInfo: nil)
        expect(errorDomain).to(matchError(NSError(domain: "err", code: 123, userInfo: nil)))

        // Safety
        // Does not compile:
        //            expect(1 + 1).to(equal("Squee!"))

        // Passes if squawk does not equal "Hi!":
        //            expect(1) != "Hi!"

        // Passes if 10 is greater than 2:
        expect(10) > 2

        // Asynchronous Expectations
        var ocean: [String] = []
        DispatchQueue.main.async {
            ocean.append("dolphins")
            ocean.append("whales")
        }
        expect(ocean).toEventually(contain("dolphins", "whales"))
        expect(ocean).toEventually(contain("dolphins", "whales"), timeout: 3)



        waitUntil { done in
            expect(true).to(beTrue())
            done()
        }

        waitUntil(timeout: 1.0) { done in
            expect(true).to(beTrue())
            done()
        }
    }

    // Built-in Matcher Functions
    func testTypeChecking() {


        // The following tests pass
        expect(1).to(beAnInstanceOf(Int.self))
        expect("turtle").to(beAnInstanceOf(String.self))

        let classObject = SomeClassConformingToProtocol()
        expect(classObject).to(beAnInstanceOf(SomeProtocol.self))
        expect(classObject).to(beAnInstanceOf(SomeClassConformingToProtocol.self))
        expect(classObject).toNot(beAnInstanceOf(SomeStructConformingToProtocol.self))

        let structObject = SomeStructConformingToProtocol()
        expect(structObject).to(beAnInstanceOf(SomeProtocol.self))
        expect(structObject).to(beAnInstanceOf(SomeStructConformingToProtocol.self))
        expect(structObject).toNot(beAnInstanceOf(SomeClassConformingToProtocol.self))


        class A {}
        class B: A {}
        // beAkindOf
        let b = B()
        expect(b).to(beAnInstanceOf(B.self))
        expect(1).to(beAKindOf(Int.self))
        expect("turtle").to(beAKindOf(String.self))

        let classObject1 = SomeClassConformingToProtocol()
        expect(classObject1).to(beAKindOf(SomeProtocol.self))
        expect(classObject1).to(beAKindOf(SomeClassConformingToProtocol.self))
        expect(classObject1).to(beAKindOf(SomeStructConformingToProtocol.self))

        let structObject1 = SomeStructConformingToProtocol()
        expect(structObject1).to(beAKindOf(SomeProtocol.self))
        expect(structObject1).to(beAKindOf(SomeStructConformingToProtocol.self))
        expect(structObject1).to(beAKindOf(SomeClassConformingToProtocol.self))


        // Unlike the 'beKindOf' matcher, the 'beAnInstanceOf' matcher only
        // passes if the object is the EXACT type requested. The following
        // tests pass -- note its behavior when working in an inheritance hierarchy.
        // Không giống như matcher 'beKindOf', chỉ có matcher 'beAnInstanceOf'
        // truyền nếu đối tượng là kiểu CHÍNH XÁC được yêu cầu. Sau đây
        // tests pass - lưu ý hành vi của nó khi làm việc trong một hệ thống phân cấp thừa kế.
        expect(1).to(beAnInstanceOf(Int.self))
        expect("turtle").to(beAnInstanceOf(String.self))

        let classObject2 = SomeClassConformingToProtocol()
        expect(classObject2).to(beAnInstanceOf(SomeProtocol.self))
        expect(classObject2).to(beAnInstanceOf(SomeClassConformingToProtocol.self))
        expect(classObject2).to(beAnInstanceOf(SomeStructConformingToProtocol.self))

        let structObject2 = SomeStructConformingToProtocol()
        expect(structObject2).to(beAnInstanceOf(SomeProtocol.self))
        expect(structObject2).to(beAnInstanceOf(SomeStructConformingToProtocol.self))
        expect(structObject2).to(beAnInstanceOf(SomeClassConformingToProtocol.self))
    }

    func testEquivalence() {

        // Equal
        expect(1) == 1
        expect(1).to(equal(1))

        // beCloseTo
        expect(10.01).to(beCloseTo(10, within: 0.01))
        expect(10.01).to(beCloseTo(10, within: 0.009))
        expect(10.01).to(beCloseTo(10, within: 0.011))

        // ±
        expect(10.01) == 10 ± 0.01
        expect(10.01) == 10 ± 0.009
        expect(10.01) == 10 ± 0.011

        // ≈
        expect(10.01) ≈ (10, 0.01)
        expect(10.01) ≈ (10, 0.009)
        expect(10.01) ≈ (10, 0.011)

        // Not Equals
        expect(1).notTo(equal(2))
        expect(1) != 2
    }

    func testPreference() {

        // Identify
        let actual1 = SomeClassConformingToProtocol()
        let expected = actual1
        expect(actual1).to(beIdenticalTo(expected))
        expect(actual1) === expected
        expect(actual1) !== expected
    }

    func testComparison() {

        // Compare
        expect(1 + 1).to(equal(2))
        expect(1 + 1) == 2

        expect(10).to(beGreaterThan(2))
        expect(10) > 2

        expect(2).to(beLessThan(10))
        expect(2) < 10

        expect(10).to(beLessThanOrEqualTo(10))
        expect(10) >= 2
        expect(10) >= 10

        expect(10).to(beGreaterThanOrEqualTo(10))
        expect(10) <= 10

        expect(1.4).to(beCloseTo(1.3, within: 0.1)) //5 1.4-1.3>=0.1

        expect([0.0, 0.2]).to(beCloseTo([0.001, 0.2001], within: 0.001))
    }

    func testTruthiness() {

        let actual: Bool? = nil

        expect(actual) == nil

        // beTruthy
        // Passes if 'actual' is not nil, true, or an object with a boolean value of true:
        expect(actual).to(beTruthy())

        // beTrue
        // Passes if 'actual' is only true (not nil or an object conforming to Boolean true):
        expect(actual).to(beTrue())

        // beFalsy
        // Passes if 'actual' is nil, false, or an object with a boolean value of false:
        // pass neu doi tuong la nil, false, hoac mot doi truong voi gia tri bool la false
        expect(actual).to(beFalsy())

        // beFalse
        // Passes if 'actual' is only false (not nil or an object conforming to Boolean false):
        expect(actual).to(beFalse())

        // beNil
        // Passes if 'actual' is nil:
        expect(actual).to(beNil())
    }

    func testSwiftErrorHandling() {

        enum SomethingError: Error {
            case less
            case greater
        }

        func checkZeroNumber(_ number: Int) throws -> Int {
            if number < 0 {
                throw SomethingError.less
            }
            if number > 0 {
                throw SomethingError.greater
            }
            return number
        }

        // Passes if 'checkZeroNumber(:_)' throws an 'Error'
        expect { try checkZeroNumber(-1)}.to(throwError())
        expect { try checkZeroNumber(1)}.to(throwError())

        // Passes if 'checkZeroNumber(:_)' is an expected value
        expect { try checkZeroNumber(0)}.to(equal(0))

        // Passes if 'checkZeroNumber(:_)' throws an 'less' error
        expect { try checkZeroNumber(-1)}.to(throwError(SomethingError.less))

        // Passes if 'checkZeroNumber(:_)' throws an 'greater' error
        expect { try checkZeroNumber(1)}.to(throwError(SomethingError.greater))

        // Passes if 'checkZeroNumber(:_)' throws an error type
        expect { try checkZeroNumber(-1)}.to(throwError(errorType: SomethingError.self))

        // Expected error by closure
        expect { try checkZeroNumber(-1)}.to(throwError { error in
            expect(error) == SomethingError.less
        })

        // Matcher error
        let actual: Error = SomethingError.less
        expect(actual).to(matchError(SomethingError.self))
        expect(actual).to(matchError(SomethingError.less))

        let errorDomain = NSError(domain: "err", code: 123, userInfo: nil)
        expect(errorDomain).to(matchError(NSError(domain: "err", code: 123, userInfo: nil)))
    }

    func testCollectionMemberShip() {
        expect(["whale", "dolphin", "starfish"]).to(contain("dolphin", "starfish"))
        expect([]).to(beEmpty())
        expect([1, 2, 3]).to(beginWith(1))
        expect([1, 2, 3]).to(beginWith(2))
        expect([1, 2, 3]).to(endWith(3))
        expect([1, 2, 3]).to(endWith(2))

        struct Turtle {
            let color: String
        }
        let turtles: [Turtle] = [
            Turtle(color: "blue"),
            Turtle(color: "green")
        ]
        expect(turtles).to(containElementSatisfying({ turtle in
            return turtle.color == "green"
        }))
        expect(turtles).to(containElementSatisfying({ turtle in
            return turtle.color == "red"
        }, "that is a turtle with color 'blue'"))
    }

    func testStrings() {
        let text = "abcdef"
        expect(text).to(contain("ab"))
        expect(text).to(beginWith("ab"))
        expect(text).to(endWith("ef"))

        expect(text).to(contain("be"))
        expect(text).to(beginWith("bc"))
        expect(text).to(endWith("de"))
    }

    func testCollectionElements() {
        // allPass
        expect([1, 2, 3, 4]).to(allPass {
            guard let value = $0 else { return false }
            return value < 5
        })
        // Composing the expectation with another matcher:
        expect([1, 2, 3, 4]).to(allPass(beLessThan(5)))
    }

    func testCollectionCount() {

        // haveCount
        let actual: [Int] = [1, 2, 3]
        expect(actual).to(haveCount(3))
        expect(actual).notTo(haveCount(2))
    }

    func testNotifications() {
        // Test post notification
        let testNotification = Notification(name: Notification.Name(rawValue: "name"), object: nil, userInfo: nil)

        func postNotificationFunction() {
            NotificationCenter.default.post(testNotification)
        }

        expect {
            postNotificationFunction()
            }.to(postNotifications(equal([testNotification])))

        let notificationCenter = NotificationCenter()
        expect {
            postNotificationFunction()
            }.to(postNotifications(equal([testNotification]), fromNotificationCenter: notificationCenter))

        // Not yet testing for add observe
    }

    func testMatchingAValueToAnyAGroupOfMatchers() {

        // Satisfy
        // passes if actual is either less than 10 or greater than 20
        expect(9).to(satisfyAnyOf(beLessThan(10), beGreaterThan(20)))

        // can include any number of matchers -- the following will pass
        // **be careful** -- too many matchers can be the sign of an unfocused test
        expect(6).to(satisfyAnyOf(equal(5), equal(6), equal(7)))

        // in Swift you also have the option to use the || operator to achieve a similar function
        expect(82).to(beLessThan(50) || beGreaterThan(80))
    }

    func testCustomValidation() {


        // passes if .succeeded is returned from the closure
        let actual: Result = .success
        expect({
            guard case Result.success = actual else {
                return .failed(reason: "Wrong enum case")
            }
            return .succeeded
        }).to(succeed())

        // passes if .succeeded is returned from the closure
        let actual2: Result = .failure("a")
        expect({
            guard case Result.failure("a") = actual2 else {
                return .failed(reason: "Wrong enum case")
            }
            return .succeeded
        }).to(succeed())

        // passes if .failed is returned from the closure
        let actual3: Result = .failure("a")
        expect({
            guard case Result.failure("b") = actual3 else {
                return .failed(reason: "Wrong enum case")
            }
            return .succeeded
        }).notTo(succeed())

        expect(actual) == Result.success
        expect(actual).to(equal(Result.success))

        expect(actual2) == Result.failure("a")
        expect(actual2).to(equal(Result.failure("a")))
    }
}
