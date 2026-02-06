/**
 * APP.JS - Main Application JavaScript
 * Purpose: Global application initialization and utilities
 * Part of Nexus Design System
 */

(function() {
    'use strict';
    
    /**
     * Application Configuration
     */
    const NexusApp = {
        name: 'Nexus',
        version: '1.0.0',
        apiBase: '/api',
        debug: false
    };
    
    /**
     * Initialize application on DOM ready
     */
    document.addEventListener('DOMContentLoaded', function() {
        initializeApp();
    });
    
    /**
     * Main initialization function
     */
    function initializeApp() {
        console.log(`${NexusApp.name} v${NexusApp.version} initialized`);
        
        // Initialize features
        initializeTheme();
        initializeTooltips();
        initializeSmoothScroll();
        initializeFormValidation();
        initializeAOSAnimations();
        
        // Log initialization
        if (NexusApp.debug) {
            console.log('App initialized successfully');
        }
    }
    
    /**
     * Theme Management
     */
    function initializeTheme() {
        // Load saved theme preference
        const savedTheme = localStorage.getItem('nexus-theme') || 'light';
        document.documentElement.setAttribute('data-theme', savedTheme);
        
        // Theme toggle handler
        const themeToggles = document.querySelectorAll('[data-theme-toggle]');
        themeToggles.forEach(toggle => {
            toggle.addEventListener('click', toggleTheme);
        });
    }
    
    function toggleTheme() {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        
        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('nexus-theme', newTheme);
        
        // Dispatch theme change event
        window.dispatchEvent(new CustomEvent('themeChanged', { detail: { theme: newTheme } }));
    }
    
    /**
     * Tooltip Initialization
     */
    function initializeTooltips() {
        const tooltipElements = document.querySelectorAll('[data-tooltip]');
        
        tooltipElements.forEach(element => {
            element.addEventListener('mouseenter', showTooltip);
            element.addEventListener('mouseleave', hideTooltip);
        });
    }
    
    function showTooltip(event) {
        const element = event.currentTarget;
        const text = element.getAttribute('data-tooltip');
        
        const tooltip = document.createElement('div');
        tooltip.className = 'tooltip';
        tooltip.textContent = text;
        tooltip.id = 'active-tooltip';
        
        document.body.appendChild(tooltip);
        
        const rect = element.getBoundingClientRect();
        tooltip.style.left = rect.left + (rect.width / 2) - (tooltip.offsetWidth / 2) + 'px';
        tooltip.style.top = rect.top - tooltip.offsetHeight - 8 + 'px';
    }
    
    function hideTooltip() {
        const tooltip = document.getElementById('active-tooltip');
        if (tooltip) {
            tooltip.remove();
        }
    }
    
    /**
     * Smooth Scrolling for Anchor Links
     */
    function initializeSmoothScroll() {
        const links = document.querySelectorAll('a[href^="#"]');
        
        links.forEach(link => {
            link.addEventListener('click', function(e) {
                const href = this.getAttribute('href');
                
                if (href === '#') return;
                
                const target = document.querySelector(href);
                if (target) {
                    e.preventDefault();
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    }
    
    /**
     * Form Validation Enhancement
     */
    function initializeFormValidation() {
        const forms = document.querySelectorAll('form[data-validate]');
        
        forms.forEach(form => {
            form.addEventListener('submit', function(e) {
                if (!form.checkValidity()) {
                    e.preventDefault();
                    e.stopPropagation();
                    
                    // Add visual feedback for invalid fields
                    const invalidFields = form.querySelectorAll(':invalid');
                    invalidFields.forEach(field => {
                        field.classList.add('is-invalid');
                        
                        // Remove invalid class on input
                        field.addEventListener('input', function() {
                            if (field.checkValidity()) {
                                field.classList.remove('is-invalid');
                                field.classList.add('is-valid');
                            }
                        }, { once: true });
                    });
                }
            });
        });
    }
    
    /**
     * Initialize AOS (Animate On Scroll) if available
     */
    function initializeAOSAnimations() {
        if (typeof AOS !== 'undefined') {
            AOS.init({
                duration: 800,
                easing: 'ease-in-out',
                once: true,
                offset: 100
            });
        }
    }
    
    /**
     * Alert/Notification System
     */
    window.showAlert = function(title, message, type = 'info', duration = 5000) {
        const alertContainer = getOrCreateAlertContainer();
        
        const alert = document.createElement('div');
        alert.className = `alert alert-${type}`;
        alert.style.marginBottom = 'var(--space-3)';
        alert.style.animation = 'slideInRight 0.3s ease';
        
        alert.innerHTML = `
            <div class="alert-icon">
                <i class="bi bi-${getAlertIcon(type)}"></i>
            </div>
            <div class="alert-content">
                <div class="alert-title">${title}</div>
                <div>${message}</div>
            </div>
            <button class="modal-close" onclick="this.parentElement.remove()">
                <i class="bi bi-x"></i>
            </button>
        `;
        
        alertContainer.appendChild(alert);
        
        // Auto-remove after duration
        if (duration > 0) {
            setTimeout(() => {
                alert.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => alert.remove(), 300);
            }, duration);
        }
    };
    
    function getOrCreateAlertContainer() {
        let container = document.getElementById('alert-container');
        
        if (!container) {
            container = document.createElement('div');
            container.id = 'alert-container';
            container.style.position = 'fixed';
            container.style.top = '80px';
            container.style.right = '20px';
            container.style.zIndex = '9999';
            container.style.maxWidth = '400px';
            document.body.appendChild(container);
        }
        
        return container;
    }
    
    function getAlertIcon(type) {
        const icons = {
            info: 'info-circle',
            success: 'check-circle',
            warning: 'exclamation-triangle',
            danger: 'x-circle'
        };
        return icons[type] || 'info-circle';
    }
    
    /**
     * Loading Spinner Utility
     */
    window.showLoader = function(message = 'Loading...') {
        const loader = document.createElement('div');
        loader.id = 'global-loader';
        loader.className = 'modal-backdrop';
        loader.style.display = 'flex';
        loader.innerHTML = `
            <div style="text-align: center;">
                <div class="spinner" style="margin: 0 auto;"></div>
                <p style="color: var(--nexus-white); margin-top: var(--space-4);">${message}</p>
            </div>
        `;
        document.body.appendChild(loader);
        document.body.style.overflow = 'hidden';
    };
    
    window.hideLoader = function() {
        const loader = document.getElementById('global-loader');
        if (loader) {
            loader.remove();
            document.body.style.overflow = '';
        }
    };
    
    /**
     * Confirm Dialog Utility
     */
    window.confirmDialog = function(message, onConfirm, onCancel) {
        const backdrop = document.createElement('div');
        backdrop.className = 'modal-backdrop';
        backdrop.style.display = 'flex';
        
        backdrop.innerHTML = `
            <div class="modal modal-sm">
                <div class="modal-header">
                    <h3 class="modal-title">Confirm Action</h3>
                </div>
                <div class="modal-body">
                    <p>${message}</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-ghost" id="confirmCancel">Cancel</button>
                    <button class="btn btn-primary" id="confirmOk">Confirm</button>
                </div>
            </div>
        `;
        
        document.body.appendChild(backdrop);
        
        document.getElementById('confirmOk').addEventListener('click', function() {
            backdrop.remove();
            if (onConfirm) onConfirm();
        });
        
        document.getElementById('confirmCancel').addEventListener('click', function() {
            backdrop.remove();
            if (onCancel) onCancel();
        });
        
        backdrop.addEventListener('click', function(e) {
            if (e.target === backdrop) {
                backdrop.remove();
                if (onCancel) onCancel();
            }
        });
    };
    
    /**
     * Debounce Utility
     */
    window.debounce = function(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    };
    
    /**
     * Format Date Utility
     */
    window.formatDate = function(date, format = 'MMM DD, YYYY') {
        const d = new Date(date);
        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        
        return format
            .replace('YYYY', d.getFullYear())
            .replace('MMM', months[d.getMonth()])
            .replace('DD', String(d.getDate()).padStart(2, '0'));
    };
    
    // Add slide in/out animations
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes slideOutRight {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
    `;
    document.head.appendChild(style);
    
    // Make NexusApp globally available
    window.NexusApp = NexusApp;
    
})();
