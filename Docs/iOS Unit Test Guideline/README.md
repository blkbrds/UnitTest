# iOS Unit Test Guideline



Một số rule sử dụng trong FR-Retail:

1. [`describe`, `context`, `it`](#describe-context-it)
2. [`beforeSuite`, `afterSuite`, `beforeEach`, `afterEach`](#beforesuite-aftersuite-beforeeach-aftereach)
3. [Một số lưu ý](#một-số-lưu-ý)
- [Errors](#errors)
- [Closure](#closure)
- [Các phép so sánh](#các-phép-so-sánh)



### `describe`, `context`, `it`

- **describe(“*Mô tả những gì cần test*”) {}**

Ví dụ 1:

```swift
func viewModelForItem(at indexPath: IndexPath) throws -> SomeViewModel {...}
```

```swift
describe("Test view model for item") {}
```

Ví dụ 2:

```swift
func someAPI(completion: @escaping (APIResult) -> Void)) {...}
```

```swift
describe("Test result of API <Name>") {...}
```


- **context(“*Trường hợp đang test có đặc điểm gì*“) {}**

Thường bắt đầu bằng từ khoá  `When...`, `If...`

- **it(“*Đối tượng kiểm tra* should have/should be *Kết quả hướng tới*“) {}**
 
Nên viết cùng từ khoá `should be`, `should throw` hoặc `should return`


Ví dụ 3:

```swift
func viewModelForItem(at indexPath: IndexPath) throws -> SomeViewModel {...}
```

```swift
describe("Test view model for item") {
    
    it("Should be an instance of SomeViewModel") {
        let indexPath = IndexPath(row: 0, section: 0)
        expect(viewModel.viewModelForItem(at: indexPath))
               .to(beAnInstanceOf(SomeViewModel.self))
    }
    
    it("Should throw error index out of bounds") {
        let indexPath = IndexPath(row: 1000, section: 0)
        expect { try viewModel.viewModelForItem(at: indexPath) }
  		       .to(throwError(Errors.indexOutOfBound))
    }
}
```

Ví dụ 4:

```swift
func someAPI(completion: @escaping (APIResult) -> Void)) {...}
```

```swift
describe("Test result of API <Name>") {

    it("Response should return success") {...}
    
    it("Response should return error") {...}
}
```

Ví dụ 5:

```swift
context("When user have first name and last name") {

    it("Full name should be equal to `Nguyen A`") {...}
    
    it("Username should be equal to `A`") {...}
}
```

> Kết quả được log từ ngoài vào trong như thế này nhé các ông, mục đích cuối cùng là chúng ta phải đọc hiểu được dòng log này:
> `Test Case '-[ProjectTests.SomeViewModelTests UserViewModelWhen_user_have_first_name_and_last_name__ Username_should_be_equal_to__A__'`



### `beforeSuite`, `afterSuite`, `beforeEach`, `afterEach`

* `beforeSuite`
  * Chỉ sử dụng nếu thực sự cần thiết
  * Chỉ sử dụng duy nhất một `beforeSuite` đối với 1 `spec()`
* `afterSuite`
  * Chỉ sử dụng nếu thực sự cần thiết
* `beforeEach`
  * Nên đặt trong `describe(_:closure:)` hoặc `context(_:closure:)`
* `afterEach`
  * Chỉ sử dụng nếu thực sự cần thiết

Ví dụ 6:

```swift
context("When person has a house") {
    
    beforeEach {
	     viewModel = Person(houses: ["House 1"])
    }
    
    describe("Test common functions") { // numberOfItems, viewModelForItems,...
        it("Number of houses should be 1") {
            expect(viewModel.numberOfHouses) == 1
        }
    }
    
    context("When person get new house") {
    
   	     beforeEach {
   	         viewModel.getNewHouse("House 2") // Call houses.append("House 2")
   	     }
    
        it("Number of houses should be 2") {
            expect(viewModel.numberOfHouses) == 2
        }
    }
}
```


### Một số lưu ý

#### Error
Một số ví dụ thường sử dụng:

```swift
it("Error should be devide by zero") {
    expect { try divide(10, 0) }
  		    .to(throwError(Errors.devideByZero))
}
```

```swift
it("Error should be index out of bounds") {
    let indexPath = IndexPath(row: 10, section: 0)
    expect { try viewModel.viewModelForItem(at: indexPath) }
  		    .to(throwError(Errors.indexOutOfBound))
}
```

```swift
it("Error should be init failure") {
	expect { try viewModel.itemSearchViewModel() }
	       .to(throwError(Errors.initFailure))
}
```


#### Closure

* ***Trailing closure*** được sử dụng khi gọi hàm có 1 closure
* Khi hàm có nhiều hơn 1 closure thì sử dụng ***normal closure expression***

Ex: 

```swift
func someFunction1(a: Int, b: Int, completion: () -> Void)
```

```swift
someFunction1(a: 10, b: 11) { // Trailing closure
  	// closure body goes here
}
```

```swift
describe("...") {
    context("...") {
      	it("...") {
      	}
    }
}
```

Ex2:

```swift
func someFunction2(a: Int, b: Int, handled: () -> Void, completion: () -> Void)
```

```swift
someFunction2(a: 10, b: 11, handled: { // Normal closure expression
	// handled body goes here
}, completion: {
	// completion body goes here
})
```

Ex3: ***Không nên***

```swift
someFunction1(a: 10, b: 10, completion: { ...... })
someFunction1(a: 10, b: 10, { ..... })
```



#### Các phép so sánh

Các cụm từ nên sử dụng để miêu tả các phép so sánh:

```swift
it("a should be equal to b") {} // a == b
it("a should be not equal to b") {} // a != b
it("a should be greater than b") {} // a > b
it("a should be less than b") {} // a < b
it("a should be greater than or equal to b") {} // a >= b
it("a should be less than or equal to b") {} // a <= b
```

