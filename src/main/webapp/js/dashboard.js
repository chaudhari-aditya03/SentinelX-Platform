/**
 * DASHBOARD.JS - Dashboard Functionality
 * Purpose: Charts, widgets, and dashboard-specific interactions
 * Part of Nexus Design System
 */

(function() {
    'use strict';
    
    /**
     * Initialize dashboard on DOM ready
     */
    document.addEventListener('DOMContentLoaded', function() {
        if (isDashboardPage()) {
            initializeDashboard();
        }
    });
    
    /**
     * Check if current page is a dashboard
     */
    function isDashboardPage() {
        return window.location.pathname.includes('dashboard');
    }
    
    /**
     * Main Dashboard Initialization
     */
    function initializeDashboard() {
        console.log('Dashboard initialized');
        
        initializeCharts();
        initializeStatCards();
        initializeDataTables();
        initializeRefreshHandlers();
        animateNumbers();
    }
    
    /**
     * Initialize Charts (Chart.js)
     */
    function initializeCharts() {
        // Only run if Chart.js is loaded
        if (typeof Chart === 'undefined') return;
        
        // Set global Chart.js defaults
        Chart.defaults.font.family = 'Inter, sans-serif';
        Chart.defaults.color = getComputedStyle(document.documentElement)
            .getPropertyValue('--nexus-text-secondary');
        
        // Initialize specific charts
        initializeStatusChart();
        initializeTrendChart();
        initializeActivityChart();
    }
    
    /**
     * Status Distribution Chart (Doughnut)
     */
    function initializeStatusChart() {
        const canvas = document.getElementById('statusChart');
        if (!canvas) return;
        
        const ctx = canvas.getContext('2d');
        
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Filed', 'Under Review', 'Under Investigation', 'Resolved', 'Closed'],
                datasets: [{
                    data: [180, 55, 120, 250, 95],
                    backgroundColor: [
                        '#00A3FF',  // Nexus Accent
                        '#F59E0B',  // Warning
                        '#3B82F6',  // Info
                        '#10B981',  // Success
                        '#9CA3AF'   // Gray
                    ],
                    borderWidth: 0,
                    hoverOffset: 10
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 15,
                            usePointStyle: true,
                            pointStyle: 'circle'
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        cornerRadius: 8,
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.parsed || 0;
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percentage = ((value / total) * 100).toFixed(1);
                                return `${label}: ${value} (${percentage}%)`;
                            }
                        }
                    }
                }
            }
        });
    }
    
    /**
     * Trend Line Chart
     */
    function initializeTrendChart() {
        const canvas = document.getElementById('trendChart');
        if (!canvas) return;
        
        const ctx = canvas.getContext('2d');
        
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [
                    {
                        label: 'Complaints',
                        data: [65, 78, 90, 81, 96, 105],
                        borderColor: '#00A3FF',
                        backgroundColor: 'rgba(0, 163, 255, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointRadius: 4,
                        pointHoverRadius: 6
                    },
                    {
                        label: 'Resolved',
                        data: [45, 62, 70, 68, 80, 88],
                        borderColor: '#10B981',
                        backgroundColor: 'rgba(16, 185, 129, 0.1)',
                        tension: 0.4,
                        fill: true,
                        pointRadius: 4,
                        pointHoverRadius: 6
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: {
                    intersect: false,
                    mode: 'index'
                },
                plugins: {
                    legend: {
                        position: 'top',
                        labels: {
                            usePointStyle: true,
                            padding: 15
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        cornerRadius: 8
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });
    }
    
    /**
     * Activity Bar Chart
     */
    function initializeActivityChart() {
        const canvas = document.getElementById('activityChart');
        if (!canvas) return;
        
        const ctx = canvas.getContext('2d');
        
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                datasets: [{
                    label: 'Daily Activity',
                    data: [12, 19, 15, 25, 22, 18, 10],
                    backgroundColor: '#00A3FF',
                    borderRadius: 8,
                    maxBarThickness: 40
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        cornerRadius: 8
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });
    }
    
    /**
     * Stat Cards Animations
     */
    function initializeStatCards() {
        const statCards = document.querySelectorAll('.stat-card');
        
        statCards.forEach((card, index) => {
            // Stagger animation
            card.style.animationDelay = `${index * 0.1}s`;
            card.style.opacity = '0';
            card.style.animation = 'fadeInUp 0.5s ease forwards';
        });
        
        // Add CSS animation
        if (!document.getElementById('stat-card-animation')) {
            const style = document.createElement('style');
            style.id = 'stat-card-animation';
            style.textContent = `
                @keyframes fadeInUp {
                    from {
                        opacity: 0;
                        transform: translateY(20px);
                    }
                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }
            `;
            document.head.appendChild(style);
        }
    }
    
    /**
     * Animate Numbers (Count Up Effect)
     */
    function animateNumbers() {
        const numbers = document.querySelectorAll('.stat-card-value');
        
        numbers.forEach(element => {
            const target = parseInt(element.textContent.replace(/,/g, ''));
            if (isNaN(target)) return;
            
            const duration = 2000; // 2 seconds
            const increment = target / (duration / 16); // 60fps
            let current = 0;
            
            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    element.textContent = formatNumber(target);
                    clearInterval(timer);
                } else {
                    element.textContent = formatNumber(Math.floor(current));
                }
            }, 16);
        });
    }
    
    /**
     * Format number with commas
     */
    function formatNumber(num) {
        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }
    
    /**
     * Initialize Data Tables with Search and Sort
     */
    function initializeDataTables() {
        const tables = document.querySelectorAll('[data-table-search]');
        
        tables.forEach(table => {
            const searchInput = document.createElement('input');
            searchInput.type = 'search';
            searchInput.className = 'form-control form-control-sm';
            searchInput.placeholder = 'Search table...';
            searchInput.style.maxWidth = '300px';
            searchInput.style.marginBottom = 'var(--space-4)';
            
            table.parentElement.insertBefore(searchInput, table);
            
            searchInput.addEventListener('input', debounce(function() {
                filterTable(table, searchInput.value);
            }, 300));
        });
        
        // Make table headers sortable
        const sortableHeaders = document.querySelectorAll('th[data-sortable]');
        sortableHeaders.forEach(header => {
            header.style.cursor = 'pointer';
            header.addEventListener('click', function() {
                sortTable(this);
            });
        });
    }
    
    /**
     * Filter table rows based on search term
     */
    function filterTable(table, searchTerm) {
        const tbody = table.querySelector('tbody');
        if (!tbody) return;
        
        const rows = tbody.querySelectorAll('tr');
        const term = searchTerm.toLowerCase();
        
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(term) ? '' : 'none';
        });
    }
    
    /**
     * Sort table by column
     */
    function sortTable(header) {
        const table = header.closest('table');
        const tbody = table.querySelector('tbody');
        const rows = Array.from(tbody.querySelectorAll('tr'));
        const columnIndex = Array.from(header.parentElement.children).indexOf(header);
        const isAscending = header.classList.contains('sort-asc');
        
        // Remove sort classes from all headers
        table.querySelectorAll('th').forEach(th => {
            th.classList.remove('sort-asc', 'sort-desc');
        });
        
        // Sort rows
        rows.sort((a, b) => {
            const aValue = a.children[columnIndex].textContent.trim();
            const bValue = b.children[columnIndex].textContent.trim();
            
            // Try numeric sort first
            const aNum = parseFloat(aValue.replace(/[^0-9.-]/g, ''));
            const bNum = parseFloat(bValue.replace(/[^0-9.-]/g, ''));
            
            if (!isNaN(aNum) && !isNaN(bNum)) {
                return isAscending ? bNum - aNum : aNum - bNum;
            }
            
            // String sort
            return isAscending ? 
                bValue.localeCompare(aValue) : 
                aValue.localeCompare(bValue);
        });
        
        // Re-append sorted rows
        rows.forEach(row => tbody.appendChild(row));
        
        // Toggle sort indicator
        header.classList.add(isAscending ? 'sort-desc' : 'sort-asc');
    }
    
    /**
     * Refresh Dashboard Data
     */
    function initializeRefreshHandlers() {
        const refreshButtons = document.querySelectorAll('[data-refresh]');
        
        refreshButtons.forEach(button => {
            button.addEventListener('click', function() {
                const target = this.getAttribute('data-refresh');
                refreshWidget(target);
            });
        });
    }
    
    /**
     * Refresh specific widget
     */
    function refreshWidget(widgetId) {
        const widget = document.getElementById(widgetId);
        if (!widget) return;
        
        // Add loading state
        widget.style.opacity = '0.5';
        widget.style.pointerEvents = 'none';
        
        // Simulate data refresh
        setTimeout(() => {
            widget.style.opacity = '1';
            widget.style.pointerEvents = 'auto';
            
            showAlert('Success', 'Widget data refreshed', 'success', 2000);
        }, 1000);
    }
    
    /**
     * Export data to CSV
     */
    window.exportTableToCSV = function(tableId, filename = 'export.csv') {
        const table = document.getElementById(tableId);
        if (!table) return;
        
        const rows = table.querySelectorAll('tr');
        const csv = [];
        
        rows.forEach(row => {
            const cols = row.querySelectorAll('td, th');
            const rowData = Array.from(cols).map(col => {
                return '"' + col.textContent.trim().replace(/"/g, '""') + '"';
            });
            csv.push(rowData.join(','));
        });
        
        const csvContent = csv.join('\n');
        const blob = new Blob([csvContent], { type: 'text/csv' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = filename;
        a.click();
        window.URL.revokeObjectURL(url);
        
        showAlert('Success', 'Data exported successfully', 'success');
    };
    
    /**
     * Utility: Debounce
     */
    function debounce(func, wait) {
        let timeout;
        return function(...args) {
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(this, args), wait);
        };
    }
    
    /**
     * Real-time Clock (for dashboard header)
     */
    function initializeRealTimeClock() {
        const clockElement = document.getElementById('dashboard-clock');
        if (!clockElement) return;
        
        function updateClock() {
            const now = new Date();
            const timeString = now.toLocaleTimeString('en-US', {
                hour: '2-digit',
                minute: '2-digit'
            });
            clockElement.textContent = timeString;
        }
        
        updateClock();
        setInterval(updateClock, 1000);
    }
    
    initializeRealTimeClock();
    
    /**
     * Export dashboard functions globally
     */
    window.NexusDashboard = {
        refreshWidget: refreshWidget,
        exportTableToCSV: window.exportTableToCSV,
        animateNumbers: animateNumbers
    };
    
})();
