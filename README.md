# Lương Y App

Ứng dụng chăm sóc sức khoẻ & đặt lịch khám bệnh, xây dựng bằng **Flutter**, tham khảo trải nghiệm từ app **Danh Y** của Bệnh viện Hoàn Mỹ Sài Gòn.

## Mục lục

- [Giới thiệu](#giới-thiệu)
- [Tính năng chính](#tính-năng-chính)
- [Kiến trúc màn hình](#kiến-trúc-màn-hình)
- [Chi tiết chức năng](#chi-tiết-chức-năng)
- [Tech stack](#tech-stack)
- [Cấu trúc thư mục đề xuất](#cấu-trúc-thư-mục-đề-xuất)
- [Getting Started](#getting-started)
- [Roadmap](#roadmap)

## Giới thiệu

Lương Y App giúp người dùng:

- Đặt lịch khám bệnh nhanh chóng tại các chi nhánh trong hệ thống.
- Quản lý hồ sơ sức khoẻ, kết quả xét nghiệm/cận lâm sàng tập trung.
- Tra cứu mạng lưới cơ sở y tế, giá dịch vụ, tin tức y tế.
- Theo dõi lịch hẹn theo trạng thái, nhận thông báo nhắc lịch.

## Tính năng chính

- [x] Onboarding hiển thị 1 lần duy nhất
- [x] Đăng nhập / Đăng ký tài khoản
- [x] Bottom navigation 5 tab: Hồ sơ, Thông báo, Trang chủ, Lịch hẹn, Tiện ích
- [x] Đặt lịch khám (chọn chi nhánh → chuyên khoa → bác sĩ → khung giờ)
- [x] Quản lý hồ sơ khám chữa bệnh, kết quả XN & CLS
- [x] Quản lý lịch hẹn theo trạng thái: Chờ duyệt / Chờ tiếp nhận / Hoàn tất
- [x] Tra cứu mạng lưới chi nhánh theo tỉnh/thành
- [x] Tin tức & Truyền thông
- [x] Tra cứu giá dịch vụ
- [x] Đa ngôn ngữ (Tiếng Việt mặc định)
- [x] Chia sẻ hồ sơ cho người thân

## Kiến trúc màn hình

```
Splash
 └─ Onboarding (chỉ hiện lần đầu)
     └─ Đăng nhập / Đăng ký / Bỏ qua
         └─ Main Shell (Bottom Navigation)
             ├─ Hồ sơ
             ├─ Thông báo
             ├─ Trang chủ (tab trung tâm, icon nổi trên bottom bar)
             ├─ Lịch hẹn
             └─ Tiện ích
```

## Chi tiết chức năng

### 1. Onboarding
Hiển thị đúng 1 lần ở lần mở app đầu tiên (lưu cờ bằng `SharedPreferences`). Gồm 3 slide giới thiệu tính năng, có nút Bỏ qua / Bắt đầu ngay.

### 2. Trang chủ
- Avatar + lời chào theo thời gian thực (buổi sáng/chiều/tối) + họ tên người dùng.
- Lưới 8 tiện ích: Đặt lịch khám, Lịch hẹn, Kết quả khám bệnh, Hồ sơ, Kết quả khám sức khoẻ, Tra cứu giá dịch vụ, Hướng dẫn đặt khám, Liên hệ.
- Banner slide 3 ảnh, có nút CTA "Đặt lịch khám".
- Mục "Mạng lưới": tối đa 3 chi nhánh + nút "Xem thêm" (ảnh, tên, địa chỉ, hotline).
- Mục "Tin tức & Truyền thông": tối đa 5 bài + nút "Xem thêm" (ảnh, danh mục, tiêu đề, ngày cập nhật).
- "Kết nối với chúng tôi": Facebook, Messenger, Zalo, TikTok.

### 3. Hồ sơ
Header avatar + họ tên. Danh sách: Thông tin tài khoản, Chỉ số sức khoẻ, Hồ sơ khám chữa bệnh, Khám sức khoẻ định kỳ, Kết quả XN & CLS, Hồ sơ giấy tờ ra viện, Quản lý chia sẻ hồ sơ, Tài liệu tải lên, Hàng đợi khám bệnh. Cuối trang hiển thị "Lịch hẹn đã đặt gần đây".

### 4. Thông báo
Danh sách thông báo (nhắc lịch, kết quả có sẵn, tin tức, khuyến mãi). Có empty state "Chưa có dữ liệu" khi trống.

### 5. Lịch hẹn
Nút "+" tạo lịch hẹn nhanh. 3 tab trạng thái: Chờ duyệt, Chờ tiếp nhận, Hoàn tất — mỗi tab có badge số lượng và empty state riêng.

### 6. Tiện ích
Header avatar + tên + SĐT. Danh sách: Ngôn ngữ/Language, Đăng nhập và bảo mật, Các vấn đề thường gặp, Góp ý dịch vụ, Thông tin ứng dụng, Đăng xuất.

### 7. Mạng lưới chi nhánh (Xem thêm)
Tìm kiếm theo tỉnh/thành, filter theo thương hiệu (chip). Danh sách chi nhánh: logo, tên, địa chỉ, giờ hoạt động, hotline, nút "Đặt lịch khám".

### 8. Tin tức & Truyền thông (Xem thêm)
Danh sách đầy đủ bài viết, filter theo danh mục, phân trang/infinite scroll. Màn chi tiết bài viết.

> Tài liệu phân tích nghiệp vụ chi tiết (BA): xem file [`BA_luong_y_app.html`](./BA_luong_y_app.html).

## Tech stack

- **Flutter** (Android & iOS)
- State management: Bloc / Riverpod / GetX *(quyết định theo team)*
- `shared_preferences` — lưu cờ onboarding, cache local
- `carousel_slider` — banner trang chủ
- `cached_network_image` — cache ảnh
- `url_launcher` — gọi hotline, mở mạng xã hội
- `intl` — đa ngôn ngữ

## Cấu trúc thư mục đề xuất

```
lib/
 ├─ main.dart
 ├─ app/                     # App config, routes, theme
 ├─ core/                    # constants, utils, network, di
 ├─ data/
 │   ├─ models/
 │   ├─ repositories/
 │   └─ services/
 ├─ features/
 │   ├─ onboarding/
 │   ├─ auth/
 │   ├─ home/
 │   ├─ profile/
 │   ├─ notification/
 │   ├─ appointment/
 │   ├─ utility/
 │   ├─ network_branch/
 │   └─ news/
 └─ shared/
     ├─ widgets/
     └─ theme/
```

## Getting Started

```bash
flutter pub get
flutter run
```

## Roadmap

| Giai đoạn | Nội dung |
|---|---|
| Phase 1 — MVP | Onboarding, Auth, Trang chủ, Hồ sơ cơ bản, Lịch hẹn, Tiện ích, Mạng lưới |
| Phase 2 | Đặt lịch khám end-to-end, Push notification, Tin tức |
| Phase 3 | Kết quả XN & CLS (PDF viewer), Chia sẻ hồ sơ, Hàng đợi khám realtime |
| Phase 4 | Đa ngôn ngữ, Tối ưu hiệu năng, Góp ý dịch vụ, Tích hợp mạng xã hội |

---

*Tài liệu nội bộ dự án luong_y_app.*
