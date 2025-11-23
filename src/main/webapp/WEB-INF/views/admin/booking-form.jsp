<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${booking.id == 0 ? 'Đặt phòng mới' : 'Sửa đặt phòng'} - Quản lý Khách sạn</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f6fa;
        }
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar h1 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }
        .nav-links {
            display: flex;
            gap: 1rem;
            list-style: none;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .nav-links a:hover {
            background: rgba(255,255,255,0.2);
        }
        .container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        .form-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-card h2 {
            color: #2c3e50;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #667eea;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: 500;
        }
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            font-family: inherit;
        }
        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #eee;
        }
        .btn {
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .btn-secondary {
            background: #95a5a6;
            color: white;
        }
        .btn-secondary:hover {
            background: #7f8c8d;
        }
        .alert {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1.5rem;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .required {
            color: #e74c3c;
        }
        .price-preview {
            background: #f8f9fa;
            padding: 1rem;
            border-radius: 5px;
            margin-top: 1rem;
            font-size: 1.1rem;
            font-weight: 600;
            text-align: center;
            color: #667eea;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <h1>🏨 Hệ thống Quản lý Khách sạn</h1>
        <ul class="nav-links">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/rooms?action=list">Phòng</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/customers?action=list">Khách hàng</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bookings?action=list">Đặt phòng</a></li>
            <li style="margin-left: auto;"><a href="${pageContext.request.contextPath}/auth?action=logout" style="background: rgba(255,255,255,0.2);">Đăng xuất</a></li>
        </ul>
    </nav>

    <div class="container">
        <div class="form-card">
            <h2>${booking.id == 0 ? '➥ Đặt phòng mới' : '✏️ Sửa đặt phòng'}</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/admin/bookings">
                <input type="hidden" name="action" value="${booking.id == 0 ? 'insert' : 'update'}">
                <c:if test="${booking.id != 0}">
                    <input type="hidden" name="id" value="${booking.id}">
                </c:if>

                <div class="form-row">
                    <div class="form-group">
                        <label for="customerId">Khách hàng <span class="required">*</span></label>
                        <select id="customerId" name="customerId" required>
                            <option value="">Chọn khách hàng</option>
                            <c:forEach var="customer" items="${customers}">
                                <option value="${customer.id}" ${booking.customerId == customer.id ? 'selected' : ''}>
                                    ${customer.fullName} (${customer.email})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="roomId">Phòng <span class="required">*</span></label>
                        <select id="roomId" name="roomId" required>
                            <option value="">Chọn phòng</option>
                            <c:forEach var="room" items="${rooms}">
                                <option value="${room.id}" 
                                        data-price="${room.pricePerNight}"
                                        ${booking.roomId == room.id ? 'selected' : ''}>
                                    Phòng ${room.roomNumber} - ${room.roomType} (<fmt:formatNumber value="${room.pricePerNight}" pattern="#,##0"/>đ/đêm)
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="checkInDate">Ngày nhận phòng <span class="required">*</span></label>
                        <input type="date" id="checkInDate" name="checkInDate" 
                               value="<fmt:formatDate value='${booking.checkInDate}' pattern='yyyy-MM-dd'/>" 
                               required min="${today}">
                    </div>

                    <div class="form-group">
                        <label for="checkOutDate">Ngày trả phòng <span class="required">*</span></label>
                        <input type="date" id="checkOutDate" name="checkOutDate" 
                               value="<fmt:formatDate value='${booking.checkOutDate}' pattern='yyyy-MM-dd'/>" 
                               required min="${today}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="numberOfGuests">Số khách <span class="required">*</span></label>
                        <input type="number" id="numberOfGuests" name="numberOfGuests" 
                               value="${booking.numberOfGuests}" required min="1" max="10"
                               placeholder="Ví dụ: 2">
                    </div>

                    <div class="form-group">
                        <label for="totalPrice">Tổng Giá (VNĐ) <span class="required">*</span></label>
                        <input type="number" id="totalPrice" name="totalPrice" 
                               value="${booking.totalPrice}" required min="0" step="1000"
                               placeholder="Tự động tính">
                    </div>
                </div>

                <div class="form-group">
                    <label for="status">Trạng thái <span class="required">*</span></label>
                    <select id="status" name="status" required>
                        <option value="Pending" ${booking.status == 'Pending' ? 'selected' : ''}>Chờ xác nhận</option>
                        <option value="Confirmed" ${booking.status == 'Confirmed' ? 'selected' : ''}>Đã xác nhận</option>
                        <option value="CheckedIn" ${booking.status == 'CheckedIn' ? 'selected' : ''}>Đã nhận phòng</option>
                        <option value="CheckedOut" ${booking.status == 'CheckedOut' ? 'selected' : ''}>Đã trả phòng</option>
                        <option value="Cancelled" ${booking.status == 'Cancelled' ? 'selected' : ''}>Đã hủy</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="specialRequests">Yêu cầu đặc biệt</label>
                    <textarea id="specialRequests" name="specialRequests" 
                              placeholder="Nhập yêu cầu đặc biệt hoặc ghi chú...">${booking.specialRequests}</textarea>
                </div>

                <div id="pricePreview" class="price-preview" style="display: none;">
                    Dự kiến tổng: <span id="estimatedPrice">0.00</span>đ
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/admin/bookings?action=list" class="btn btn-secondary">Hủy</a>
                    <button type="submit" class="btn btn-primary">
                        ${booking.id == 0 ? 'Tạo đặt phòng' : 'Cập nhật'}
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Auto-calculate total price
        const roomSelect = document.getElementById('roomId');
        const checkInInput = document.getElementById('checkInDate');
        const checkOutInput = document.getElementById('checkOutDate');
        const totalPriceInput = document.getElementById('totalPrice');
        const pricePreview = document.getElementById('pricePreview');
        const estimatedPrice = document.getElementById('estimatedPrice');

        function calculateTotal() {
            const selectedRoom = roomSelect.options[roomSelect.selectedIndex];
            const pricePerNight = parseFloat(selectedRoom.dataset.price || 0);
            const checkIn = new Date(checkInInput.value);
            const checkOut = new Date(checkOutInput.value);

            if (checkIn && checkOut && checkIn < checkOut && pricePerNight > 0) {
                const nights = Math.ceil((checkOut - checkIn) / (1000 * 60 * 60 * 24));
                const total = nights * pricePerNight;
                totalPriceInput.value = Math.round(total);
                estimatedPrice.textContent = total.toFixed(2);
                pricePreview.style.display = 'block';
            } else {
                pricePreview.style.display = 'none';
            }
        }

        roomSelect.addEventListener('change', calculateTotal);
        checkInInput.addEventListener('change', calculateTotal);
        checkOutInput.addEventListener('change', calculateTotal);

        // Set minimum checkout date
        checkInInput.addEventListener('change', function() {
            checkOutInput.min = this.value;
            if (checkOutInput.value && checkOutInput.value <= this.value) {
                checkOutInput.value = '';
            }
        });
    </script>
</body>
</html>
