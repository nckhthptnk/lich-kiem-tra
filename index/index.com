<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Lịch Thi Kiểm Tra</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            box-sizing: border-box;
        }
        
        .pastel-bg {
            background: linear-gradient(135deg, #fef7ff 0%, #f0f9ff 50%, #f0fdf4 100%);
        }
        
        .card-shadow {
            box-shadow: 0 4px 6px -1px rgba(219, 234, 254, 0.3), 0 2px 4px -1px rgba(219, 234, 254, 0.2);
        }
        
        .input-focus:focus {
            outline: none;
            border-color: #c084fc;
            box-shadow: 0 0 0 3px rgba(192, 132, 252, 0.1);
        }
        
        .btn-hover:hover {
            transform: translateY(-1px);
            box-shadow: 0 8px 15px -3px rgba(192, 132, 252, 0.3);
        }
        
        .fade-in {
            animation: fadeIn 0.3s ease-in;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body class="pastel-bg min-h-full">
    <div class="container mx-auto px-4 py-8 max-w-6xl">
        <header class="text-center mb-8">
            <div class="flex justify-between items-center mb-4">
                <a 
                    href="https://nckhthptnk.github.io/minitkb/" 
                    target="_blank" 
                    rel="noopener noreferrer"
                    class="px-4 py-2 bg-gradient-to-r from-gray-100 to-gray-200 text-gray-700 rounded-xl font-medium btn-hover transition-all duration-200 flex items-center text-sm"
                >
                    🏠 Về Trang Chủ
                </a>
                <div class="flex-1"></div>
            </div>
            <h1 class="text-3xl font-bold text-purple-700 mb-2">📚 QUẢN LÝ LỊCH THI - KIỂM TRA</h1>
            <p class="text-purple-500 font-light">Theo dõi và quản lý lịch thi một cách dễ dàng</p>
        </header>

        <main>
            <!-- Form thêm lịch thi -->
            <div class="bg-gradient-to-br from-purple-50 to-blue-50 rounded-2xl card-shadow p-6 mb-8 border border-purple-100">
                <h2 class="text-xl font-medium text-purple-700 mb-6 flex items-center">
                    <span class="mr-2">➕</span>
                    Thêm Lịch Thi Mới
                </h2>
                
                <form id="examForm" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="subject" class="block text-sm font-medium text-purple-600 mb-2">Môn Kiểm Tra</label>
                        <select 
                            id="subjectSelect" 
                            class="w-full px-4 py-3 border border-purple-200 rounded-xl input-focus transition-all duration-200 bg-purple-50"
                            onchange="handleSubjectChange()"
                            required
                        >
                            <option value="">-- Chọn môn học --</option>
                            <option value="Toán học">📐 Toán học</option>
                            <option value="Vật Lí">⚡ Vật Lí</option>
                            <option value="Hóa học">🧪 Hóa học</option>
                            <option value="Sinh học">🌱 Sinh học</option>
                            <option value="Công nghệ">⚙️ Công nghệ</option>
                            <option value="Giáo dục Quốc Phòng">🛡️ Giáo dục Quốc Phòng</option>
                            <option value="Tin học">💻 Tin học</option>
                            <option value="Ngữ Văn">📚 Ngữ Văn</option>
                            <option value="Tiếng Anh">🇬🇧 Tiếng Anh</option>
                            <option value="other">✏️ Khác (tự nhập)</option>
                        </select>
                        <input 
                            type="text" 
                            id="customSubject" 
                            name="subject"
                            class="w-full px-4 py-3 border border-purple-200 rounded-xl input-focus transition-all duration-200 bg-purple-50 mt-3 hidden"
                            placeholder="Nhập tên môn học khác..."
                        >
                    </div>
                    
                    <div>
                        <label for="room" class="block text-sm font-medium text-purple-600 mb-2">Phòng Kiểm Tra</label>
                        <input 
                            type="text" 
                            id="room" 
                            name="room"
                            class="w-full px-4 py-3 border border-purple-200 rounded-xl input-focus transition-all duration-200 bg-purple-50"
                            placeholder="Ví dụ: A101, B205..."
                            required
                        >
                    </div>
                    
                    <div>
                        <label for="date" class="block text-sm font-medium text-purple-600 mb-2">Ngày Kiểm Tra</label>
                        <input 
                            type="date" 
                            id="date" 
                            name="date"
                            class="w-full px-4 py-3 border border-purple-200 rounded-xl input-focus transition-all duration-200 bg-purple-50"
                            required
                        >
                    </div>
                    
                    <div>
                        <label for="time" class="block text-sm font-medium text-purple-600 mb-2">Giờ Kiểm Tra</label>
                        <input 
                            type="time" 
                            id="time" 
                            name="time"
                            class="w-full px-4 py-3 border border-purple-200 rounded-xl input-focus transition-all duration-200 bg-purple-50"
                            placeholder="Nhập giờ kiểm tra"
                            required
                        >
                    </div>
                    
                    <div class="md:col-span-2">
                        <button 
                            type="submit" 
                            class="w-full md:w-auto px-8 py-3 bg-gradient-to-r from-purple-400 to-blue-400 text-white rounded-xl font-medium btn-hover transition-all duration-200"
                        >
                            ✨ Thêm Lịch Thi
                        </button>
                    </div>
                </form>
            </div>

            <!-- Danh sách lịch thi -->
            <div class="bg-gradient-to-br from-blue-50 to-green-50 rounded-2xl card-shadow p-6 border border-blue-100">
                <div class="flex flex-col md:flex-row md:items-center justify-between mb-6">
                    <h2 class="text-xl font-medium text-blue-700 flex items-center mb-4 md:mb-0">
                        <span class="mr-2">📋</span>
                        Danh Sách Lịch Thi
                    </h2>
                    <button 
                        onclick="exportToPrint()" 
                        class="px-6 py-2 bg-gradient-to-r from-green-400 to-blue-400 text-white rounded-xl font-medium btn-hover transition-all duration-200 flex items-center"
                    >
                        🖨️ Xuất Màn Hình
                    </button>
                </div>
                
                <div id="examList" class="space-y-4">
                    <div class="text-center py-8 text-slate-400">
                        <div class="text-4xl mb-2">📝</div>
                        <p>Chưa có lịch thi nào. Hãy thêm lịch thi đầu tiên!</p>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        let exams = [];
        let examIdCounter = 1;

        // Lấy các phần tử DOM
        const examForm = document.getElementById('examForm');
        const examList = document.getElementById('examList');

        // Xử lý thay đổi môn học
        function handleSubjectChange() {
            const subjectSelect = document.getElementById('subjectSelect');
            const customSubject = document.getElementById('customSubject');
            
            if (subjectSelect.value === 'other') {
                customSubject.classList.remove('hidden');
                customSubject.required = true;
                subjectSelect.removeAttribute('name');
            } else {
                customSubject.classList.add('hidden');
                customSubject.required = false;
                customSubject.value = '';
                subjectSelect.setAttribute('name', 'subject');
            }
        }

        // Xử lý form submit
        examForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(examForm);
            const subjectSelect = document.getElementById('subjectSelect');
            const customSubject = document.getElementById('customSubject');
            
            let subjectValue;
            if (subjectSelect.value === 'other') {
                subjectValue = customSubject.value;
            } else {
                subjectValue = subjectSelect.value;
            }
            
            const exam = {
                id: examIdCounter++,
                subject: subjectValue,
                room: formData.get('room'),
                date: formData.get('date'),
                time: formData.get('time')
            };
            
            exams.push(exam);
            renderExamList();
            examForm.reset();
            
            // Reset trạng thái form
            document.getElementById('customSubject').classList.add('hidden');
            document.getElementById('customSubject').required = false;
            document.getElementById('subjectSelect').setAttribute('name', 'subject');
            
            // Hiển thị thông báo thành công
            showNotification('✅ Đã thêm lịch thi thành công!');
        });

        // Render danh sách lịch thi
        function renderExamList() {
            if (exams.length === 0) {
                examList.innerHTML = `
                    <div class="text-center py-8 text-slate-400">
                        <div class="text-4xl mb-2">📝</div>
                        <p>Chưa có lịch thi nào. Hãy thêm lịch thi đầu tiên!</p>
                    </div>
                `;
                return;
            }

            // Sắp xếp theo ngày và giờ
            const sortedExams = [...exams].sort((a, b) => {
                const dateTimeA = new Date(`${a.date}T${a.time}`);
                const dateTimeB = new Date(`${b.date}T${b.time}`);
                return dateTimeA - dateTimeB;
            });

            examList.innerHTML = sortedExams.map(exam => {
                const examDate = new Date(`${exam.date}T${exam.time}`);
                const now = new Date();
                const isUpcoming = examDate > now;
                const isPast = examDate < now;
                
                return `
                    <div class="exam-card bg-gradient-to-r from-pink-50 to-purple-50 rounded-xl p-4 border border-pink-100 fade-in ${isPast ? 'opacity-60' : ''}">
                        <div class="flex flex-col md:flex-row md:items-center justify-between">
                            <div class="flex-1">
                                <div class="flex items-center mb-2">
                                    <span class="text-lg font-medium text-purple-700">${exam.subject}</span>
                                    ${isUpcoming ? '<span class="ml-2 px-2 py-1 bg-green-100 text-green-700 text-xs rounded-full">Sắp tới</span>' : ''}
                                    ${isPast ? '<span class="ml-2 px-2 py-1 bg-gray-100 text-gray-600 text-xs rounded-full">Đã qua</span>' : ''}
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-2 text-sm text-purple-600">
                                    <div class="flex items-center">
                                        <span class="mr-2">📅</span>
                                        ${formatDate(exam.date)}
                                    </div>
                                    <div class="flex items-center">
                                        <span class="mr-2">🕐</span>
                                        ${exam.time}
                                    </div>
                                    <div class="flex items-center">
                                        <span class="mr-2">🏫</span>
                                        Phòng ${exam.room}
                                    </div>
                                </div>
                            </div>
                            <div class="mt-3 md:mt-0 md:ml-4">
                                <button 
                                    onclick="deleteExam(${exam.id})" 
                                    class="px-4 py-2 text-rose-500 hover:bg-rose-50 rounded-lg transition-colors duration-200 text-sm"
                                >
                                    🗑️ Xóa
                                </button>
                            </div>
                        </div>
                    </div>
                `;
            }).join('');
        }

        // Xóa lịch thi
        function deleteExam(id) {
            exams = exams.filter(exam => exam.id !== id);
            renderExamList();
            showNotification('🗑️ Đã xóa lịch thi');
        }

        // Format ngày
        function formatDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString('vi-VN', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
        }

        // Hiển thị thông báo
        function showNotification(message) {
            const notification = document.createElement('div');
            notification.className = 'fixed top-4 right-4 bg-gradient-to-r from-purple-100 to-pink-100 border border-purple-200 rounded-xl px-6 py-3 card-shadow z-50 fade-in text-purple-700';
            notification.textContent = message;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.style.opacity = '0';
                notification.style.transform = 'translateY(-10px)';
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 300);
            }, 2000);
        }

        // Xuất màn hình
        function exportToPrint() {
            if (exams.length === 0) {
                showNotification('⚠️ Chưa có lịch thi nào để xuất!');
                return;
            }

            // Tạo nội dung để in
            const printContent = generatePrintContent();
            
            // Tạo cửa sổ mới để in
            const printWindow = window.open('', '_blank');
            printWindow.document.write(printContent);
            printWindow.document.close();
            
            // Tự động mở hộp thoại in
            printWindow.onload = function() {
                printWindow.print();
            };
            
            showNotification('📄 Đã mở cửa sổ xuất màn hình!');
        }

        // Tạo nội dung để in
        function generatePrintContent() {
            const sortedExams = [...exams].sort((a, b) => {
                const dateTimeA = new Date(`${a.date}T${a.time}`);
                const dateTimeB = new Date(`${b.date}T${b.time}`);
                return dateTimeA - dateTimeB;
            });

            const examRows = sortedExams.map((exam, index) => {
                const examDate = new Date(`${exam.date}T${exam.time}`);
                const now = new Date();
                const status = examDate > now ? 'Sắp tới' : examDate < now ? 'Đã qua' : 'Hôm nay';
                
                return `
                    <tr style="border-bottom: 1px solid #e5e7eb;">
                        <td style="padding: 12px; text-align: center; font-weight: bold;">${index + 1}</td>
                        <td style="padding: 12px; font-weight: 600;">${exam.subject}</td>
                        <td style="padding: 12px; text-align: center;">${formatDate(exam.date)}</td>
                        <td style="padding: 12px; text-align: center; font-weight: 600;">${exam.time}</td>
                        <td style="padding: 12px; text-align: center;">${exam.room}</td>
                        <td style="padding: 12px; text-align: center;">
                            <span style="padding: 4px 8px; border-radius: 12px; font-size: 12px; 
                                ${status === 'Sắp tới' ? 'background-color: #dcfce7; color: #166534;' : 
                                  status === 'Đã qua' ? 'background-color: #f3f4f6; color: #6b7280;' : 
                                  'background-color: #fef3c7; color: #92400e;'}">${status}</span>
                        </td>
                    </tr>
                `;
            }).join('');

            return `
                <!DOCTYPE html>
                <html lang="vi">
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Lịch Thi Kiểm Tra</title>
                    <style>
                        body {
                            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                            margin: 20px;
                            color: #333;
                            line-height: 1.6;
                        }
                        .header {
                            text-align: center;
                            margin-bottom: 30px;
                            border-bottom: 3px solid #8b5cf6;
                            padding-bottom: 20px;
                        }
                        .header h1 {
                            color: #8b5cf6;
                            margin: 0;
                            font-size: 28px;
                            font-weight: bold;
                        }
                        .header p {
                            color: #6b7280;
                            margin: 10px 0 0 0;
                            font-size: 16px;
                        }
                        .info {
                            display: flex;
                            justify-content: space-between;
                            margin-bottom: 20px;
                            font-size: 14px;
                            color: #6b7280;
                        }
                        table {
                            width: 100%;
                            border-collapse: collapse;
                            margin-top: 20px;
                            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                        }
                        th {
                            background: linear-gradient(135deg, #8b5cf6, #3b82f6);
                            color: white;
                            padding: 15px 12px;
                            text-align: center;
                            font-weight: 600;
                            font-size: 14px;
                        }
                        td {
                            font-size: 14px;
                        }
                        tr:nth-child(even) {
                            background-color: #f8fafc;
                        }
                        tr:hover {
                            background-color: #f1f5f9;
                        }
                        .footer {
                            margin-top: 30px;
                            text-align: center;
                            font-size: 12px;
                            color: #9ca3af;
                            border-top: 1px solid #e5e7eb;
                            padding-top: 20px;
                        }
                        @media print {
                            body { margin: 0; }
                            .header { page-break-inside: avoid; }
                            table { page-break-inside: auto; }
                            tr { page-break-inside: avoid; }
                        }
                    </style>
                </head>
                <body>
                    <div class="header">
                        <h1>📚 LỊCH THI - KIỂM TRA</h1>
                        <p>Danh sách lịch thi được xuất từ hệ thống quản lý</p>
                    </div>
                    
                    <div class="info">
                        <span>📅 Ngày xuất: ${new Date().toLocaleDateString('vi-VN', {
                            weekday: 'long',
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric'
                        })}</span>
                        <span>📊 Tổng số lịch thi: ${exams.length}</span>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th style="width: 8%;">STT</th>
                                <th style="width: 25%;">Môn Kiểm Tra</th>
                                <th style="width: 25%;">Ngày Thi</th>
                                <th style="width: 12%;">Giờ Thi</th>
                                <th style="width: 15%;">Phòng Thi</th>
                                <th style="width: 15%;">Trạng Thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${examRows}
                        </tbody>
                    </table>

                    <div class="footer">
                        <p>🎓 Hệ thống quản lý lịch thi - Được tạo bởi Canva Code</p>
                        <p>Thời gian xuất: ${new Date().toLocaleString('vi-VN')}</p>
                    </div>
                </body>
                </html>
            `;
        }

        // Khởi tạo
        renderExamList();
    </script>
</</body>
<script>(function(){function c(){var b=a.contentDocument||a.contentWindow.document;if(b){var d=b.createElement('script');d.innerHTML="window.__CF$cv$params={r:'994af41f84d79626',t:'MTc2MTQ5MjE5My4wMDAwMDA='};var a=document.createElement('script');a.nonce='';a.src='/cdn-cgi/challenge-platform/scripts/jsd/main.js';document.getElementsByTagName('head')[0].appendChild(a);";b.getElementsByTagName('head')[0].appendChild(d)}}if(document.body){var a=document.createElement('iframe');a.height=1;a.width=1;a.style.position='absolute';a.style.top=0;a.style.left=0;a.style.border='none';a.style.visibility='hidden';document.body.appendChild(a);if('loading'!==document.readyState)c();else if(window.addEventListener)document.addEventListener('DOMContentLoaded',c);else{var e=document.onreadystatechange||function(){};document.onreadystatechange=function(b){e(b);'loading'!==document.readyState&&(document.onreadystatechange=e,c())}}}})();</script></html>
