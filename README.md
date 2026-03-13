# AES Encryption Core: Multi-Architecture RTL Design

Đồ án này thực hiện thuật toán mã hóa **AES (Advanced Encryption Standard)** với 128, 192 và 356-bit bằng ngôn ngữ **Verilog HDL**. Mục tiêu trọng tâm của dự án là thiết kế, mô phỏng và so sánh ba kiến trúc phần cứng khác nhau để đánh giá sự đánh đổi (trade-offs) giữa hiệu năng, diện tích (area) và công suất tiêu thụ.

## 🚀 Các kiến trúc hiện thực (Key Architectures)

Dự án bao gồm 3 cách tiếp cận thiết kế RTL để tối ưu hóa cho các mục tiêu ứng dụng khác nhau:

1.  **Iterative Architecture (Kiến trúc lặp):**
    * **Mô tả:** Sử dụng một khối `encryptRound` duy nhất và lặp lại qua 10 vòng mã hóa.
    * **Đặc điểm:** Tiết kiệm tài nguyên phần cứng tối đa nhờ sử dụng máy trạng thái (FSM) và bộ đếm vòng (`round_cnt`) để điều phối luồng dữ liệu.
    * **Ứng dụng:** Phù hợp cho các hệ thống nhúng có tài nguyên hạn chế.

2.  **Pipeline Architecture (Kiến trúc đường ống):**
    * **Mô tả:** Chèn các thanh ghi (`registers`) giữa mỗi vòng mã hóa.
    * **Ưu điểm:** Cho phép xử lý nhiều khối dữ liệu đồng thời, tăng tối đa băng thông (Throughput) và tần số hoạt động.
    * **Ứng dụng:** Phù hợp cho các ứng dụng truyền thông tốc độ cao.

3.  **Unrolled Architecture (Kiến trúc trải phẳng):**
    * **Mô tả:** Trải phẳng toàn bộ 10 vòng mã hóa thành mạch tổ hợp thuần túy.
    * **Ưu điểm:** Độ trễ (Latency) thấp nhất cho một khối dữ liệu duy nhất.
    * **Ứng dụng:** Các tác vụ yêu cầu xử lý tức thời (real-time).

## 🛠 Các Module chức năng

Tất cả các kiến trúc đều sử dụng chung bộ thư viện module con chuẩn hóa để đảm bảo tính nhất quán:
* **KeyExpansion:** Mở rộng từ khóa 128-bit ban đầu thành 11 khóa vòng (1408 bit tổng cộng).
* **SubBytes:** Thực hiện thay thế byte phi tuyến qua bảng tra S-box.
* **ShiftRows:** Hoán vị các byte trong ma trận trạng thái (state).
* **MixColumns:** Trộn các cột bằng phép nhân ma trận trên trường Galois ($GF(2^8)$).
* **AddRoundKey:** Thực hiện phép toán XOR giữa trạng thái hiện tại với khóa vòng tương ứng.

## 💻 Công cụ sử dụng (Tools)

* **Ngôn ngữ:** Verilog HDL.
* **Môi trường phát triển:** Xilinx Vivado (Tổng hợp mạch, phân tích công suất và mô phỏng).
* **Mục tiêu:** FPGA-based systems.

## 📊 Quy trình kiểm tra (Verification)

* **Testbench:** Mỗi kiến trúc đều có file testbench riêng để kiểm tra tính đúng đắn của dữ liệu đầu ra so với chuẩn AES].
* **Simulation:** Kiểm tra chức năng (Functional Verification) được thực hiện trên Vivado Simulator.

---
**Thông tin tác giả:**
* 1. Lại Nguyễn Hoàng Hưng
* 2. Nguyễn Văn Hùng
* **Trường:** Đại học Bách Khoa - ĐHQG TP.HCM (HCMUT) 
