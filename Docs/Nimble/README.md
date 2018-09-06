# Nimble

Mục lục:

1. [Giới thiệu](#giới-thiệu)
2. [Cài đặt](#cài-đặt)
3. [Diễn tả kết quả mong đợi](#diễn-tả-kết-quả-mong-đợi)
4. [Những phương thức thường sử dụng](#Những-phương-thức-thường-sử-dụng)
	- [Kiểm tra khác kiểu](#kiểm-tra-khác-kiểu)
	- [Bất đồng bộ](#bất-đồng-bộ)
	- [So sánh giá trị](#so-sánh-giá-trị)
	- [Kiểm tra kiểu](#kiểm-tra-kiểu)
	- [Kiểm tra tham chiếu](#kiểm-tra-tham-chiếu)
	- [Xử lí lỗi](#xử-lí-lỗi)
	- [Custom validation](#custom-validation)

## Giới thiệu

**Nimble** là một framework giúp diễn tả kết quả mong đợi của testcase bằng cách sử dụng ngôn ngữ tự nhiên, dễ hiểu hơn so với framework **XCTest** mà Apple cung cấp.

Ví dụ:

```swift
// XCTest
XCTAssertEqual(1 + 1, 2, "One plus one should be equal to two")
```

```swift
// Nimble
expect(1 + 1).to(equal(2), description: "One plus one should be equal to two")
```



## Cài đặt

Cài đặt Nimble thông qua CocoaPods:

1. Cài đặt CocoaPods:

   ```
   $ sudo gem install cocoapods
   ```

2. Tạo Podfile:

   ```
   $ cd <Project path>
   $ pod init
   ```

3. Mở Podfile và edit:

   ```
   source 'https://github.com/CocoaPods/Specs.git'
   platform :ios, '9.0'
   inhibit_all_warnings!
   use_frameworks!

   target 'NimbleDemo' do
       target 'NimbleDemoTests' do
           inherit! :search_paths
           pod 'Nimble', '7.0.3'
       end
   end
   ```

4. Lưu Podfile và chạy:

   ```
   $ pod install
   ```

   ​

## Diễn tả kết quả mong đợi

Diễn tả kết quả mong đợi bằng cách sử dụng các hàm cơ bản:

* `expect(<kết quả>).to(<mong đợi>)`
* `expect(<kết quả>).toNot<mong đợi>)`
* `expect(<kết quả>).notTo(<mong đợi>)`

```Swift
import Nimble
...
expect(username).to(equal("A Nguyen V."))
expect(username).toNot(equal("A Nguyen V."))
expect(username).notTo(equal("A Nguyen V."))
```
> Trong đó `notTo` và `toNot` giống nhau.

Bên cạnh đó còn có thể custom thông báo khi lỗi xảy ra:

* `expect(<kết quả>).to(<mong đợi>, description: <thông báo khi lỗi>)`

```swift
import Nimble
...
expect(username).to(equal("A Nguyen V."), description: "User name should be equal to `A Nguyen V.`")
```
## Những phương thức thường sử dụng

### Kiểm tra khác kiểu

**Nimble** không cho phép biên dịch khi ta expect `kết quả` với `mong đợi` khác kiểu dữ liệu.

```swift
// Does not compile:
expect(1 + 1).to(equal("Squee!"))
```

### Bất đồng bộ

* `expect(<kết quả>).toEventually(<mong đợi>, description: <thông báo khi lỗi>)`
* `expect(<kết quả>). toEventuallyNot(<mong đợi>, description: <thông báo khi lỗi>)`
* `waitUntil { done in <thực thi expect> done()}`
* `waitUntil(timeOut: <giá trị>) {done in <thực thi expect> done()}`

```swift
var fishes: [String] = []
api.request { fish in
    fishes.append(fish) // value is whales
}
expect(fishes).toEventually(contain("whales"))
```

```swift
var fishes: [String] = []
api.request { fish in // value is whales
    fishes.append(fish)
}
expect(fishes).toEventually(contain("whales"), timeout: 3)
```

```swift
// Call done() to finish expect() function, after timeout if done() is not executed, expect() func is fail
waitUntil(timeout: 3.0) { done in
    api.request { fish in
        expect(fish) == "whales"
        done()
    }
}
```
> Giá trị **timeout** mặc định là 1.0

### So sánh giá trị

Những giá trị được so sánh phải **extension** từ `Equatable`, `Comparable`, hoặc là các lớp con của` NSObject`. 

```swift
// Equal
expect(actual).to(equal(expected))
// Or
expect(actual) == expected

// Less than
expect(actual).to(beLessThan(expected))
// Or
expect(actual) < expected

// Less than or equal
expect(actual).to(beLessThanOrEqualTo(expected))
// Or
expect(actual) <= expected

// Greater than
expect(actual).to(beGreaterThan(expected))
// Or
expect(actual) > expected

// Greater than or equal
expect(actual).to(beGreaterThanOrEqualTo(expected))
// Or
expect(actual) >= expected
```

### Kiểm tra kiểu

* `beAKindOf(aClass)`: Passes khi kết quả cần kiểm tra có kiểu là `aClass`, hoặc khi nó là một thể hiện của `aClass` hay là bất kỳ lớp con nào từ `aClass`.
* `beAKindOf(aProtocol)`: Passes khi kết quả cần kiểm tra là một thể hiện thoả mãn `aProtocol`.

```swift
protocol SomeProtocol {}
class SomeClass {}
class TestClass: SomeClass {}
extension TestClass: SomeProtocol {}

// The following tests passes
expect(1).to(beAKindOf(Int.self))
expect("turtle").to(beAKindOf(String.self))

let testClass = TestClass()
expect(testClass).to(beAKindOf(TestClass.self))
expect(testClass).to(beAKindOf(SomeClass.self))
expect(testClass).to(beAKindOf(SomeProtocol.self))
```

* `beAnInstanceOf(aClass)`: Passes khi là thể hiện chính xác của `aClass`.

```swift
protocol SomeProtocol {}
class SomeClass {}
class TestClass: SomeClass {}
extension TestClass: SomeProtocol {}

// The following tests passes
expect(1).to(beAnInstanceOf(Int.self))
expect("turtle").to(beAnInstanceOf(String.self))

let testClass = TestClass()
expect(testClass).to(beAnInstanceOf(TestClass.self))
expect(testClass).toNot(beAnInstanceOf(SomeClass.self))
expect(testClass).toNot(beAnInstanceOf(SomeProtocol.self))
```

### Kiểm tra tham chiếu

```swift
// Passes if 'actual' has the same pointer address as 'expected':
expect(actual).to(beIdenticalTo(expected))
expect(actual) === expected

// Passes if 'actual' does not have the same pointer address as 'expected':
expect(actual).toNot(beIdenticalTo(expected))
expect(actual) !== expected
```

### Xử lí lỗi

```swift
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

```

### Custom validation

```swift
enum Result {
    case success
    case failure(String)
}

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
```
* Ta có thể [so sánh giá trị](#so-sánh-giá-trị) của enum nếu extension Result từ `Equatable`.

```swift
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

let actual: Result = .success
let actual2: Result = .faillure("a")

// Equal
expect(actual) == Result.success
expect(actual).to(equal(Result.success))

// Equal
expect(actual2) == Result.failure("a")
expect(actual2).to(equal(Result.failure("a")))
```
> Tương tự với `Comparable`.