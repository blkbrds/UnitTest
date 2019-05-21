# OHHTTPStubs

[OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs) là một library được sử dụng để `stub` network, tạo ra một chuỗi json giả, giúp cho việc viết unit testing và kiểm tra việc parse api đươc dễ dàng.

Tham khảo document ở [đây](http://cocoadocs.org/docsets/OHHTTPStubs/6.0.0/)

## Install via cocoapods

```
pod 'OHHTTPStubs/Swift', '8.0.0'
```
> Nhớ chú ý cài đặt version tương ứng

## Cấu trúc

```swift
stub(<Kiểm tra điều kiện>) { request in
    return <response trả về>
}
```
Ví dụ:

```swift
stub(condition: isPath("http://www.ios.com")) { _ in
    let stubPath = OHPathForFile("User.json", type(of: self))
    return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
}

```

## Detail

### 1. Stub condition:

#### 1.1 isHost(_ host: String)

Kiểm tra điều kiện host có phù hợp với host của url hay không.
> Với url: http://wwww.google.com.vn/vanlam?query=124 thì host là **wwww.google.com.vn**

#### 1.2 isPath(_ path: String)

Kiểm tra điều kiện path có phù hợp với path của url hay không.

> Với url: http://wwww.google.com.vn/vanlam?query=124 thì path là **/vanlam**

#### 1.3 isScheme(_ scheme: String) 

Kiểm tra điều kiện scheme có phù hợp với scheme của url hay không. Xin đừng sử dụng *isScheme* vì nó đang bị bug, không phân biệt được **http** và **https**

> Với url: http://wwww.google.com.vn/vanlam?query=124 thì scheme là **http**

#### 1.4 isAbsoluteURLString(_ url: String)

Kiểm tra luôn toàn bộ url có phù hợp hay không.

#### 1.5 isMethod

Bao gồm: isMethodGET(), isMethodPOST(), isMethodPUT(), isMethodPATCH(), isMethodDELETE(), isMethodHEAD(), kiểm tra method của hàm request tương ứng

### 2. Response trả về

Sau khi thoả mãn điều kiện ở [1](#Stub-condition), ta tiến hành tạo ra response, các func hỗ trợ gồm có:

#### 2.1: filePath

```swift
fixture(filePath: String, status: Int32 = 200, headers: [AnyHashable: Any]?)
```
hoặc 

```swift
OHHTTPStubsResponse(fileAtPath: String, statusCode: Int32, headers: [AnyHashable: Any]?)
```
> filePath: filePath của fake response, nên đặt `filename.json` cho dễ biết

#### 2.2  data

```swift
OHHTTPStubsResponse(data: Data, statusCode: Int32, headers: [AnyHashable : Any]?)
```
> data: data của fake response

#### 2.3 fileURL

```swift
OHHTTPStubsResponse(fileURL: URL, statusCode: Int32, headers: [AnyHashable : Any]?)
```
> fileURL: fileURL của fake response

#### 2.4 error

```swift
OHHTTPStubsResponse(error: Error)
```
> error: Trả về lỗi mong muốn

#### 2.5 jsonObject

```swift
OHHTTPStubsResponse(jsonObject: Any, statusCode: Int32, headers: [AnyHashable : Any]?)
```
> jsonObject: fake response với kiểu Any