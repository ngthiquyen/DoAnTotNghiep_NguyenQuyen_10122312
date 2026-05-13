# DoAnTotNghiep_NguyenQuyen_10122312
# Ứng dụng AI sinh keyword kiểm thử tự động ứng dụng Web với Robot Framework

## 1. Giới thiệu

Framework này được xây dựng nhằm hỗ trợ kiểm thử tự động ứng dụng Web theo hướng Keyword-Driven Testing, sử dụng Robot Framework kết hợp với AI để hỗ trợ sinh keyword và sinh luồng kiểm thử E2E.

Framework cho phép người dùng:
- Tổ chức keyword theo các lớp UI, Business và Verify.
- Sinh keyword kiểm thử tự động từ mô tả chức năng.
- Sinh luồng kiểm thử E2E từ mô tả nghiệp vụ.
- Chỉnh sửa, hoàn thiện và thực thi test case bằng Robot Framework.
- Xem báo cáo kết quả kiểm thử sau khi chạy test.

## 2. Công nghệ/công cụ sử dụng

- Python
- Robot Framework
- SeleniumLibrary
- AI/Ollama
- Allure Report 
- GitHub

## 3. Cấu trúc thư mục

```text
project/
│
│
├── generate_keywords_use_AI/
│   ├── input/                 --> Nơi đặt file mô tả chức năng để AI sinh keyword
│   ├── output/                --> Nơi lưu kết quả keyword do AI sinh ra
│   ├── prompt/                --> Chứa prompt dùng cho chức năng sinh keyword
│   └── generate_e2e.py        --> Script sinh luồng kiểm thử E2E bằng AI
│   └── generate_keywords.py   --> Script sinh keyword bằng AI
│
├── keywords/
│   ├── ui/                    --> Chứa các keyword thao tác giao diện mức thấp
│   │   └── common_keywords.robot
│   ├── business/              --> Chứa các keyword nghiệp vụ
│   │   ├── login_business.robot
│   │   ├── register_business.robot
│   │   ├── search_business.robot
│   │   ├── profile_business.robot
│   │   └── order_business.robot
│   └── verify/                --> Chứa các keyword kiểm tra, xác minh dùng chung
│       └── verify.robot
│
├── pages/                     --> Chứa locator của các phần tử giao diện Web
│   └── home_page.py
│   └── login_page.py
│   └── register_page.py
│   └── search_page.py
│   └── profile_page.py
│   └── order_page.py
│
├── tests/                     --> Chứa các file test case Robot Framework
│   ├── login_test.robot
│   ├── search_test.robot
│   └── e2e/
│       └── login_{timestamp}.robot
│
├── reports/                    --> Chứa báo cáo kết quả sau khi chạy kiểm thử
│   ├── allure/
│   ├── logs/
│   ├── robot/
│
├── screenshots/               --> Chứa ảnh chụp màn hình khi test lỗi
│
├── utils/                     --> Chứa các tiện ích hỗ trợ (ghi log, chụp ảnh, allure)
│   ├── allure_helper.py
│   ├── logger.py
│   ├── rune2e.py
│   ├── screenshot.py
│
└── README.md
├── requirements.txt             --> Các thư viện cần cài đặt
│
├── run.py                      --> Menu chọn và thực thi chức năng kiểm thử
```

## 4.Yêu cầu cài đặt
Trước khi sử dụng framework, cần cài đặt các công cụ sau:
    Python
    Robot Framework
    SeleniumLibrary
    DataDriver
    Trình duyệt Web, ví dụ Chrome
    ChromeDriver tương ứng với phiên bản trình duyệt
    Ollama nếu sử dụng AI chạy cục bộ

Cài đặt các thư viện cần thiết bằng lệnh: pip install -r requirements.txt

## 5. Hướng dẫn sinh keyword bằng AI
Bước 1: Chuẩn bị file mô tả chức năng
Người dùng tạo file mô tả chức năng và đặt vào thư mục: generate_keywords_use_AI/input/

Ví dụ file: login.txt
Nội dung:
Chức năng đăng nhập:
- Người dùng mở trang đăng nhập
- Nhập email và mật khẩu
- Nhấn nút đăng nhập
- Nếu thông tin hợp lệ thì đăng nhập thành công
- Nếu thiếu thông tin thì hiển thị thông báo lỗi

Bước 2: Chạy script sinh keyword
Chạy lệnh: python generate_keywords_use_AI/generate_keywords.py

Bước 3: Xem kết quả
Kết quả keyword do AI sinh ra được lưu tại: generate_keywords_use_AI/output/

Sau khi AI sinh keyword, hệ thống kiểm tra keyword trùng lặp, nếu chưa có sẽ inject keyword vào các tầng tương ứng:
    keywords/ui/
    keywords/business/
    keywords/verify/

Bước 4: Xem kết quả flow do AI sinh ra được lưu tại: generate_keywords_use_AI/output/
Hệ thống thực hiện generate file .robot được lưu tại: tests/

## 6. Hướng dẫn sinh luồng kiểm thử E2E bằng AI
Bước 1: Chuẩn bị file mô tả kịch bản nghiệp vụ
Người dùng tạo file mô tả luồng nghiệp vụ và đặt vào thư mục: generate_keywords_use_AI/input/

Ví dụ file:
e2e_scenario.txt
Nội dung:
Người dùng đăng nhập vào hệ thống, tìm kiếm sản phẩm, chọn sản phẩm, thêm sản phẩm vào giỏ hàng, cập nhật giỏ hàng, nhập thông tin giao hàng và đặt hàng.

Bước 2: Chạy script sinh flow E2E
Chạy lệnh: python generate_keywords_use_AI/generate_e2e_flow.py

Bước 3: Xem kết quả
Kết quả flow E2E do AI sinh ra được lưu tại: generate_keywords_use_AI/output/
Hệ thống generate file .robot tại: tests/e2e/

Sau đó tester kiểm tra lại flow, bổ sung dữ liệu kiểm thử, logic cần thiết vào file test trong thư mục: tests/

## 7. Hướng dẫn chạy test
Chạy lệnh: python run.py
Nhập số chọn feature kiểm thử
Sau khi chạy lệnh, hệ thống hiển thị menu chức năng. Người dùng nhập số tương ứng để chọn feature kiểm thử cần thực thi.
Ví dụ:
1. Login
2. Register
3. Search
4. Order
5. E2E Test

Các loại báo cáo gồm:
    report/allure/
    report/logs/
    report/robot/
Người dùng có thể mở báo cáo Robot Framework hoặc Allure Report để xem chi tiết kết quả kiểm thử.

## 9. Lưu ý khi sử dụng
- AI chỉ đóng vai trò hỗ trợ sinh keyword và flow kiểm thử ban đầu.
- Tester cần kiểm tra lại kết quả AI sinh ra trước khi sử dụng.
- Không sử dụng trực tiếp kết quả AI nếu chưa kiểm tra logic nghiệp vụ.
- Keyword UI dùng để thao tác trực tiếp với giao diện Web.
- Keyword Business mô tả hành động nghiệp vụ và có thể gọi lại keyword UI.
- Keyword Verify được tách riêng để tái sử dụng cho nhiều chức năng.
- Locator cần được cập nhật đúng theo giao diện Web thực tế.
- Khi giao diện Web thay đổi, cần kiểm tra và cập nhật lại các file trong thư mục pages/.