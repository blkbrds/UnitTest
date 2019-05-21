# OHHTTPStubs

[OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs) là một library được sử dụng để `stub` network, tạo ra một chuỗi json giả, giúp cho việc viết unit testing và kiểm tra việc parse api đươc dễ dàng.

Tham khảo document ở [đây](http://cocoadocs.org/docsets/OHHTTPStubs/6.0.0/)

## Install via cocoapods

```
pod 'OHHTTPStubs/Swift', '8.0.0'
```
> Nhớ chú ý cài đặt version tương ứng

## Cấu trúc

```
stub(<Kiểm tra điều kiện>) { request in
  	return <response trả về>
}
```
Ví dụ:

```
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

