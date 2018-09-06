# Bí kíp đạt thượng thừa Charles

Contributors: **Tâm Nguyễn M.**, **Hải Phùng N.T**

Tương truyền... Phép màu sẽ đến với ai biết xài Charles. 🙏🏻🙏🏻🙏🏻


**Lưu ý:**

> Bí kíp này không cần tự cung mới luyện được.
> 
> Người anh em hãy luyện bí kíp này cùng Typora để đạt thượng thừa nhanh hơn nhé.



## Mục lục

[Install Charles](#install-charles)

[Configure Charles](#configure-charles)

- [Register Charles](#register-charles)
- [Configuring Browser and System](#configuring-browser-and-system)
  - [Đối với macOS Proxy](#đối-với-macos-proxy)
  - [Đối với iOS Device Setting](#đối-với-ios-device-setting)
  - [Đối với iOS Simulator](#đối-với-ios-simulator)

[Work with Charles Proxy](#work-with-charles-proxy)

- [Application Interface](#application-interface)
- [Debug with Charles](#debug-with-charles)
  - [Focus](#focus)
  - [Recording settings](#recording-settings)
  - [Throttle settings](#throttle-settings)
  - [Breakpoint](#breakpoint)
  - [Handle breakpoint](#handle-breakpoint)
- [Configuring SSL Proxying Certificates](#configuring-ssl-proxying-certificates)
  - [Đối với macOS](#đối-với-macos)
  - [Đối với iOS Device](#đối-với-ios-device)
  - [Đối với iOS Simulator](#đối-với-ios-simulator)
- [Enable SSL Proxying Setting](#enable-ssl-proxying-setting)

[TOC]



## Install Charles

1. Truy cập vào đường link sau: https://www.charlesproxy.com và download file installer về máy

![Install_1](./Images/Install_1.png)

2. Khởi động installer đã down về, hoàn thành theo chỉ dẫn:

![Install_2](./Images/Install_2.png)

![Install_3](./Images/Install_3.png)

![Install_4](./Images/Install_4.png)

3. Khởi động Charles:

![Install_5](./Images/Install_5.png)



## Configure Charles

### Register Charles

**Help > Register Charles... > Điền Register Name và License Key**

**Lưu ý:** 

> Người anh em hãy liên hệ ông **Đài Hồ V.** để lấy key và name nhoé.

![Register_1](./Images/Register_1.png)

![Register_2](./Images/Register_2.png)

![Register_3](./Images/Register_3.png)



### Configuring Browser and System

#### Đối với macOS Proxy

1. Lần đầu sử dụng Charles bạn sẽ được tự động hỏi về việc cấp quyền macOS Proxy như sau. Chọn **Grant Privileges** và nhập user name và password:
![Proxy_1](./Images/Proxy_1.png)

![Proxy_2](./Images/Proxy_2.png)

2. Nếu bạn chọn **Not Yet** ở phần **Automatic macOS Proxy Configuration**, lần tới bạn có thế cài đặt thông qua: 
![Proxy_3](./Images/Proxy_3.png)



#### Đối với iOS Device Setting

Để sử dụng Charles thay thế cho HTTP proxy trên iPhone, chúng ta cần config bằng tay.

1. Vào **Settings > Wifi**:

![IMG_1895](./Images/IMG_1895.PNG)

2. Chọn network đang kết nối tới:

![IMG_1896](./Images/IMG_1896.PNG)

3. Chọn **Config Proxy**:

![IMG_1897](./Images/IMG_1897.PNG)

4. Chọn **Manual** và điền vào form, trong đó:
- Server: Địa chỉ IP của máy tính đang chạy Charles
- Port: Cổng mà Charles chạy (thường là 8888)
- Authentication: Off

![IMG_1898](./Images/IMG_1898.PNG)

5. Vào **Proxy > Access Control Settings…** để cho phép các device được phép kết nối với Charles bằng cách thêm mới.
![Access_1](./Images/Access_1.png)

![Access_2](./Images/Access_2.png)

**Cẩn trọng:**
>  Anh em trong giang hồ nhớ tắt **Configure Proxy** trong **Settings** sau khi sử dụng Charles nhoé.
>
>  Không tắt mà còn hỏi thì đừng có trách vì sao nước biển lại mặn.



#### Đối với iOS Simulator

- Simulator sẽ sử dụng system proxy setting như ở phía trên đã đề cập.
- Nếu simulator gặp trục trặc trong việc này, **hãy khởi động lại simulator**.

Tìm hiểu các setting khác ở: https://www.charlesproxy.com/documentation/configuration/



### Configuring SSL Proxying Certificates

#### Đối với macOS

1. **Help > SSL Proxying > Install Charles Root Certificates**

![SSL_1](./Images/SSL_1.png)

2. Thêm **Certificates**:

![SSL_2](./Images/SSL_2.png)

3. Chọn **Charles Proxy CA**:

![SSL_3](./Images/SSL_3.png)

4. Chọn **Always Trust**:

![SSL_4](./Images/SSL_4.png)

5. Kết quả sẽ được như sau, khởi động lại Safari việc thay đổi được áp dụng:

![SSL_5](./Images/SSL_5.png)



#### Đối với iOS Device

- Cài đặt iOS device để sử dụng Charles thay thế cho HTTP proxy trên iPhone trong **Settings > Wifi settings**
- Mở Safari và truy cập tới https://chls.pro/ssl. Safari sẽ install SSL certificate.
- Đối với iOS 10.3 trở về sau, chúng ta sẽ thực hiện:
  - **Settings > General > About > Certificate Trust Settings.** 
  - Dưới mục **Enable full trust for root certificates**, bật cetificate cho Charles Proxy.



#### Đối với iOS Simulator
- Tắt tất cả simulator
- Bật Charles và thực hiện vào **Help** > SSL Proxying > Install Charles Root Certificate in iOS Simulators
![Simulator_1](./Images/Simulator_1.png)

- Cách trên **đôi khi không thành công**. Ta có thể thực hiện như sau:
  - **Help > SSL Proxying > Save Charles Root Certificate…** để lưu file *.pem
  ![Simulator_2](./Images/Simulator_2.png)

  - Kéo thả file *.pem vừa tạo vào simulator

  ![Simulator_3](./Images/Simulator_3.png)

  - Thực hiện cài đặt certificate cho simulator

  ![Simulator_4](./Images/Simulator_4.png)

  ![Simulator_5](./Images/Simulator_5.png)

  ![Simulator_6](./Images/Simulator_6.png)

  ![Simulator_7](./Images/Simulator_7.png)

  ![Simulator_8](./Images/Simulator_8.png)


**Lưu ý:** Các vị huynh đài kiểm tra Simulator lần nữa cho chắc nhé. 

1. **Setting > General > About > Certificate Trust Settings.**
2. Turn on certificate của Charles.

![SSL_2_1](./Images/Config_simu_0.png)



![SSL_2_1](./Images/Config_simu_1.png)



![SSL_2_1](./Images/Config_simu_2.png)



![SSL_2_1](./Images/Config_simu_3.png)



### Enable SSL Proxying Setting

1. **Proxy > SSL Proxying Settings...**

![SSL_2_1](./Images/SSL_2_1.png)

2. Ở tab **SSL Proxying**, chọn **Enable SSL Proxying**.

![SSL_2_2](./Images/SSL_2_2.png)

3. Thêm **Location**.

![SSL_2_3](./Images/SSL_2_3.png)

**Lưu ý: **
> Người anh em nên vận công restart lại máy cho chắc.



## Work with Charles Proxy

### Application Interface

![Interface](./Images/Interface.png)


Các nút thông dụng: 

1. **Clear the current session**: 
   - Session chứa tất cả các thông tin được ghi lại. 
   - Khi Session đầy/busy, có thể clean session đấy.

2. **Start/stop recording**:
   - Record là chức năng căn bản của Charles. 
   - Request và response được lưu lại vào Session hiện tại chỉ khi chức năng Record bật.
     - Request hiển thị trên màn hình Session khi nó được lưu lại. Có thể xem request ở 2 chế độ: Structure và Sequence.

3. **Start/stop throttling**: Điều chỉnh băng thông

4. **Enable/Disable breakpoints**

5. Tạo **Compose** mới

6. **Repeat**: Lặp lại request được chọn

7. **Tool**: Active/deactive các tool như
   - Breakpoint
   - No caching
   - ...

8. **Settings**:
   - Recording settings…
   - Access control settings...
   - ...​



### Debug with Charles

**Lưu ý:**
> Người anh em nhớ bật macOS Proxy trước khi debug, bằng cách vào **Proxy > macOS Proxy** như đã đề cập phía trên nhé.


#### Focus

Vì có rất nhiều request và response từ vô số host trả về. Bước focus này giúp tách riêng những host chúng ta cần quan tâm.

1. Vào **View > Focused Host > Add focused hosts…**

![Host_1](./Images/Host_1.png)

2. Adding host: 
Ex: *.frcircle.com

![Host_2](./Images/Host_2.png)

3. Kết quả:

![Host_3](./Images/Host_3.png)



#### Recording settings

Bước này dùng để lọc ra những thứ mà chúng ta sẽ record lại trong session.

1. Vào **Settings** của session cần lọc, hoặc vào **Proxy > Recording Settings...**:

![Record_1](./Images/Record_1.png)

![Record_2](./Images/Record_2.png)

2. Chọn tab **Include**:

![Record_3](./Images/Record_3.png)

3. Thêm Locations:

![Record_4](./Images/Record_4.png)

4. Kết quả:

![Record_5](./Images/Record_5.png)



#### Throttle settings

Điều chỉnh băng thông với throttle settings:

1. Vào **Proxy > Throttle Settings...**

![Throttlle_1](./Images/Throttlle_1.png)

2. Config throttle setting

![Throttlle_2](./Images/Throttlle_2.png)




#### Breakpoint

Tạo break point để debug:

1. Vào **Proxy > Breakpoint Settings...**

![Breakpoint_1](./Images/Breakpoint_1.png)

2. Thêm breakpoint:
   - Adding path: v1/item/search

   - Add query: *im_name=292508-69&page=1&result_limit=100&sort_type=recent*

   - Check breakpoints: *request/response*

![Breakpoint_2](./Images/Breakpoint_2.png)

3. Kết quả:

![Breakpoint_3](./Images/Breakpoint_3.png)


**Tương truyền:**
>- Fill host ở Breakpoint settings trong khi trước đó đã fill host ở Record settings, thì tất cả request của anh em trong giang hồ đều gặp thất bại.
>- Những host được đặt trong Focus là những host ta bảo Charles để mắt tới.
>- Nhưng những host được đặt trong Record settings là những host ta bảo Charles theo dõi rồi ghi sớ dâng cho ta.



#### Handle breakpoint

![Handle](./Images/Handle.png)

1. Tab **Overview**

2. Tab **Request**

3. Tab **Edit Response**
   - Header: Editing header
   - JSON text: Editing body

4. **Execute** để tiếp tục


