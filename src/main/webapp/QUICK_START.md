# 🎯 QUICK START GUIDE - Nexus Design System

## ⚡ TL;DR - Get Started in 5 Minutes

### 1️⃣ **Include the CSS** (in `<head>`)
```html
<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/base.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/components.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/dashboard.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/styles/theme.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
```

### 2️⃣ **Include the JavaScript** (before `</body>`)
```html
<script src="${pageContext.request.contextPath}/js/app.js"></script>
<script src="${pageContext.request.contextPath}/js/layout.js"></script>
<script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
<script src="${pageContext.request.contextPath}/js/utils.js"></script>
```

### 3️⃣ **Use a Component**
```jsp
<jsp:include page="/components/Navbar.html" />
```

---

## 🎨 Common Patterns

### **Buttons**
```html
<button class="btn btn-primary">Primary</button>
<button class="btn btn-secondary">Secondary</button>
<button class="btn btn-outline">Outline</button>
<button class="btn btn-ghost">Ghost</button>
<button class="btn btn-sm">Small</button>
<button class="btn btn-lg">Large</button>
```

### **Cards**
```html
<div class="card">
    <div class="card-header">
        <h3 class="card-title">Card Title</h3>
    </div>
    <div class="card-body">
        Content here
    </div>
    <div class="card-footer">
        Footer actions
    </div>
</div>
```

### **Forms**
```html
<div class="form-group">
    <label for="email" class="form-label required">Email</label>
    <input type="email" id="email" class="form-control" required>
    <div class="form-help">Enter your email address</div>
</div>
```

### **Tables**
```html
<div class="table-container">
    <table class="table">
        <thead>
            <tr>
                <th>Column 1</th>
                <th>Column 2</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Data 1</td>
                <td>Data 2</td>
            </tr>
        </tbody>
    </table>
</div>
```

### **Stat Cards (Dashboard)**
```html
<div class="stat-card">
    <div class="stat-card-icon primary">
        <i class="bi bi-folder"></i>
    </div>
    <div class="stat-card-value">1,234</div>
    <div class="stat-card-label">Total Items</div>
    <div class="stat-card-trend up">
        <i class="bi bi-arrow-up"></i>
        <span>12% increase</span>
    </div>
</div>
```

### **Alerts**
```html
<div class="alert alert-success">
    <div class="alert-icon">
        <i class="bi bi-check-circle"></i>
    </div>
    <div class="alert-content">
        <div class="alert-title">Success!</div>
        <div>Your action was successful.</div>
    </div>
</div>
```

### **Badges**
```html
<span class="badge badge-primary">Primary</span>
<span class="badge badge-success">Success</span>
<span class="badge badge-warning">Warning</span>
<span class="badge badge-danger">Danger</span>
```

### **Modals**
```html
<button onclick="openModal('myModal')">Open Modal</button>

<div class="modal-backdrop hidden" id="myModal">
    <div class="modal">
        <div class="modal-header">
            <h3 class="modal-title">Modal Title</h3>
            <button class="modal-close" onclick="closeModal('myModal')">
                <i class="bi bi-x"></i>
            </button>
        </div>
        <div class="modal-body">
            Modal content
        </div>
        <div class="modal-footer">
            <button class="btn btn-ghost" onclick="closeModal('myModal')">Cancel</button>
            <button class="btn btn-primary">Confirm</button>
        </div>
    </div>
</div>
```

---

## 📐 Layout Classes

### **Container**
```html
<div class="container">Centered content</div>
<div class="container-fluid">Full width</div>
```

### **Grid**
```html
<div class="grid grid-cols-3 gap-4">
    <div>Column 1</div>
    <div>Column 2</div>
    <div>Column 3</div>
</div>
```

### **Flexbox**
```html
<div class="flex items-center justify-between gap-4">
    <div>Left</div>
    <div>Right</div>
</div>
```

### **Spacing**
```html
<div class="p-4">Padding 16px</div>
<div class="m-4">Margin 16px</div>
<div class="px-6 py-4">Padding X:24px Y:16px</div>
<div class="mt-8 mb-4">Margin Top:32px Bottom:16px</div>
```

---

## 🎭 JavaScript Functions

### **Alerts**
```javascript
showAlert('Success', 'Data saved successfully', 'success', 3000);
showAlert('Error', 'Something went wrong', 'danger');
```

### **Loading**
```javascript
showLoader('Processing...');
// Do something
hideLoader();
```

### **Confirmation**
```javascript
confirmDialog('Are you sure?', function() {
    // User clicked confirm
}, function() {
    // User clicked cancel
});
```

### **Theme Toggle**
```javascript
// Auto-handles theme switching
// Just include app.js
```

### **Date Formatting**
```javascript
formatDate('2026-01-29', 'MMM DD, YYYY'); // Jan 29, 2026

// Or use utils
NexusUtils.DateUtils.format(new Date(), 'MMM DD, YYYY');
NexusUtils.DateUtils.timeAgo('2026-01-28'); // "1 day ago"
```

### **Form Validation**
```javascript
NexusUtils.FormValidator.isValidEmail('test@example.com'); // true
NexusUtils.FormValidator.isStrongPassword('Password123'); // true
```

### **Number Formatting**
```javascript
NexusUtils.NumberUtils.format(1234567); // "1,234,567"
NexusUtils.NumberUtils.currency(49.99); // "$49.99"
NexusUtils.NumberUtils.percentage(85.5); // "85.5%"
NexusUtils.NumberUtils.abbreviate(1500000); // "1.5M"
```

---

## 🎨 Color Variables

```css
/* Primary Colors */
var(--nexus-primary)      /* #1C3144 - Dark Blue */
var(--nexus-accent)       /* #00A3FF - Bright Blue */

/* Semantic Colors */
var(--nexus-success)      /* #10B981 - Green */
var(--nexus-warning)      /* #F59E0B - Orange */
var(--nexus-danger)       /* #EF4444 - Red */
var(--nexus-info)         /* #3B82F6 - Blue */

/* Neutrals */
var(--nexus-white)
var(--nexus-gray-100)
var(--nexus-gray-500)
var(--nexus-black)

/* Text Colors */
var(--nexus-text-primary)
var(--nexus-text-secondary)
var(--nexus-text-tertiary)

/* Backgrounds */
var(--nexus-bg-primary)
var(--nexus-bg-secondary)
var(--nexus-bg-tertiary)
```

---

## 📱 Responsive Breakpoints

```css
/* Mobile (Default) */
< 640px

/* Tablet */
@media (min-width: 640px)  /* sm: */
@media (min-width: 768px)  /* md: */

/* Desktop */
@media (min-width: 1024px) /* lg: */
@media (min-width: 1280px) /* xl: */
@media (min-width: 1536px) /* 2xl: */
```

**Usage:**
```html
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
    <!-- 1 column mobile, 2 tablet, 3 desktop -->
</div>
```

---

## 🏗️ Dashboard Layout

```jsp
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Nexus</title>
    <!-- Include CSS -->
</head>
<body>
    <div class="dashboard-layout">
        <jsp:include page="/components/Sidebar.html" />
        <jsp:include page="/components/DashboardHeader.html" />
        
        <main class="dashboard-main">
            <div class="dashboard-page-header">
                <h1 class="dashboard-page-title">Page Title</h1>
                <p class="dashboard-page-subtitle">Description</p>
            </div>
            
            <!-- Your content here -->
            
        </main>
    </div>
    <!-- Include JS -->
</body>
</html>
```

---

## 🚀 Common Tasks

### **Add a New Page**
1. Copy template from guide
2. Include CSS and JS
3. Add navbar/sidebar components
4. Build content with design system classes
5. Test on mobile

### **Style a Form**
1. Use `.form-group` wrapper
2. Add `.form-label` for labels
3. Use `.form-control` for inputs
4. Add `.required` class if needed
5. Include `.form-help` for hints
6. Use validation classes (`.is-valid`, `.is-invalid`)

### **Create a Data Table**
1. Wrap in `.table-container`
2. Use `.table` class
3. Add `<thead>` and `<tbody>`
4. Optional: `.table-striped`, `.table-bordered`, `.table-compact`
5. Add `data-table-search` attribute for search functionality

### **Add Charts**
1. Include Chart.js: `<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>`
2. Create canvas: `<canvas id="myChart"></canvas>`
3. Initialize in JavaScript (see `dashboard.js` for examples)

### **Dark Mode**
1. Include theme.css
2. Include DashboardHeader.html (has toggle)
3. It works automatically!

---

## 🐛 Troubleshooting

### **Styles Not Loading**
- Check file paths: Use `${pageContext.request.contextPath}/styles/...`
- Verify files exist in `/styles/` directory
- Check browser console for 404 errors

### **Components Not Showing**
- Verify JSTL: `<%@ taglib uri="jakarta.tags.core" prefix="c" %>`
- Check session: `${sessionScope.role}`
- Ensure component path is correct

### **JavaScript Errors**
- Check console (F12)
- Ensure app.js is loaded before using functions
- Verify function names match documentation

### **Sidebar Not Showing for Role**
- Check session attribute: `sessionScope.role`
- Ensure value is "ADMIN", "POLICE", or "CIVILIAN" (uppercase)
- Verify `<c:if test="${...}">` logic

---

## 📚 Full Documentation

For complete documentation, see:
- **DESIGN_SYSTEM_GUIDE.md** - Complete implementation guide
- **README_REFACTORING_COMPLETE.md** - What's been built
- Component HTML files - Usage examples
- CSS files - Inline comments
- JS files - Function documentation

---

## ✅ Checklist for New Page

- [ ] Include all 5 CSS files (base, layout, components, dashboard, theme)
- [ ] Include Bootstrap Icons
- [ ] Include all 4 JS files (app, layout, dashboard, utils)
- [ ] Add proper meta tags (title, description)
- [ ] Include appropriate components (Navbar/Sidebar/Footer)
- [ ] Use semantic HTML5 tags
- [ ] Add ARIA labels for accessibility
- [ ] Test on mobile, tablet, desktop
- [ ] Check dark mode appearance
- [ ] Validate HTML
- [ ] Test keyboard navigation

---

## 🎉 You're Ready!

Start refactoring your pages with this professional design system. Everything you need is built and documented. Just follow the patterns above!

**Need help?** Check the full guides in the `/webapp` directory.

**Good luck!** 🚀
