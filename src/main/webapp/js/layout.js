/**
 * LAYOUT.JS - Layout Management Script
 * Purpose: Handles dashboard layout, sidebar, and responsive behavior
 * Part of Nexus Design System
 */

(function() {
    'use strict';
    
    /**
     * Initialize layout on DOM ready
     */
    document.addEventListener('DOMContentLoaded', function() {
        initializeDashboardLayout();
    });
    
    /**
     * Dashboard Layout Initialization
     */
    function initializeDashboardLayout() {
        initializeSidebar();
        initializeResponsiveLayout();
        initializeSidebarCollapse();
        initializeScrollBehavior();
    }
    
    /**
     * Sidebar Management
     */
    function initializeSidebar() {
        const sidebar = document.getElementById('dashboardSidebar');
        const sidebarToggle = document.getElementById('sidebarToggle');
        
        if (!sidebar || !sidebarToggle) return;
        
        // Load sidebar state from localStorage
        const sidebarState = localStorage.getItem('nexus-sidebar-state');
        if (sidebarState === 'collapsed') {
            sidebar.classList.add('collapsed');
        }
        
        // Sidebar toggle handler
        sidebarToggle.addEventListener('click', function() {
            toggleSidebar();
        });
        
        // Close sidebar on outside click (mobile only)
        document.addEventListener('click', function(e) {
            if (window.innerWidth <= 1023) {
                if (!sidebar.contains(e.target) && 
                    !sidebarToggle.contains(e.target) && 
                    sidebar.classList.contains('mobile-open')) {
                    sidebar.classList.remove('mobile-open');
                }
            }
        });
    }
    
    /**
     * Toggle sidebar open/closed state
     */
    function toggleSidebar() {
        const sidebar = document.getElementById('dashboardSidebar');
        const layout = document.querySelector('.dashboard-layout');
        
        if (!sidebar) return;
        
        // Mobile behavior
        if (window.innerWidth <= 1023) {
            sidebar.classList.toggle('mobile-open');
            return;
        }
        
        // Desktop behavior
        sidebar.classList.toggle('collapsed');
        if (layout) {
            layout.classList.toggle('sidebar-collapsed');
        }
        
        // Save state
        const isCollapsed = sidebar.classList.contains('collapsed');
        localStorage.setItem('nexus-sidebar-state', isCollapsed ? 'collapsed' : 'open');
        
        // Dispatch event for other components
        window.dispatchEvent(new CustomEvent('sidebarToggled', {
            detail: { collapsed: isCollapsed }
        }));
    }
    
    /**
     * Sidebar Collapse Toggle (Desktop)
     */
    function initializeSidebarCollapse() {
        // Add collapse button if not exists
        const sidebar = document.getElementById('dashboardSidebar');
        if (!sidebar) return;
        
        // Create collapse button
        const collapseBtn = document.createElement('button');
        collapseBtn.className = 'sidebar-collapse-btn hide-mobile';
        collapseBtn.innerHTML = '<i class="bi bi-chevron-left"></i>';
        collapseBtn.setAttribute('aria-label', 'Toggle sidebar');
        collapseBtn.style.cssText = `
            position: absolute;
            top: 20px;
            right: -12px;
            width: 24px;
            height: 24px;
            background: var(--nexus-accent);
            color: var(--nexus-white);
            border: none;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--shadow-md);
            transition: all var(--transition-fast);
            z-index: 10;
        `;
        
        collapseBtn.addEventListener('click', function() {
            toggleSidebar();
            const icon = collapseBtn.querySelector('i');
            icon.className = sidebar.classList.contains('collapsed') ? 
                'bi bi-chevron-right' : 'bi bi-chevron-left';
        });
        
        sidebar.style.position = 'relative';
        sidebar.appendChild(collapseBtn);
    }
    
    /**
     * Responsive Layout Handling
     */
    function initializeResponsiveLayout() {
        let resizeTimer;
        
        window.addEventListener('resize', function() {
            clearTimeout(resizeTimer);
            resizeTimer = setTimeout(handleResize, 250);
        });
        
        // Initial check
        handleResize();
    }
    
    function handleResize() {
        const sidebar = document.getElementById('dashboardSidebar');
        if (!sidebar) return;
        
        // Reset mobile-open class on desktop
        if (window.innerWidth > 1023) {
            sidebar.classList.remove('mobile-open');
        } else {
            // Remove collapsed class on mobile
            sidebar.classList.remove('collapsed');
        }
    }
    
    /**
     * Scroll Behavior for Sticky Elements
     */
    function initializeScrollBehavior() {
        const header = document.querySelector('.dashboard-header');
        if (!header) return;
        
        let lastScroll = 0;
        
        window.addEventListener('scroll', debounce(function() {
            const currentScroll = window.pageYOffset;
            
            // Add shadow when scrolled
            if (currentScroll > 10) {
                header.style.boxShadow = 'var(--shadow-md)';
            } else {
                header.style.boxShadow = '';
            }
            
            lastScroll = currentScroll;
        }, 10));
    }
    
    /**
     * Active Navigation Item Highlighter
     */
    window.setActiveNavItem = function(pageIdentifier) {
        const navItems = document.querySelectorAll('.sidebar-nav-item');
        
        navItems.forEach(item => {
            item.classList.remove('active');
            
            const pageName = item.getAttribute('data-page');
            if (pageName === pageIdentifier) {
                item.classList.add('active');
            }
        });
    };
    
    /**
     * Auto-detect and set active nav item based on URL
     */
    function autoSetActiveNavItem() {
        const currentPath = window.location.pathname;
        const fileName = currentPath.substring(currentPath.lastIndexOf('/') + 1).replace('.jsp', '');
        
        window.setActiveNavItem(fileName);
    }
    
    // Auto-set active nav on load
    autoSetActiveNavItem();
    
    /**
     * Breadcrumb Generator
     */
    window.generateBreadcrumb = function(items) {
        const breadcrumbContainer = document.getElementById('breadcrumb-container');
        if (!breadcrumbContainer) return;
        
        const breadcrumbHTML = items.map((item, index) => {
            const isLast = index === items.length - 1;
            const activeClass = isLast ? 'active' : '';
            
            if (isLast) {
                return `
                    <div class="breadcrumb-item ${activeClass}">
                        ${item.label}
                    </div>
                `;
            } else {
                return `
                    <div class="breadcrumb-item">
                        <a href="${item.url}">${item.label}</a>
                    </div>
                    <div class="breadcrumb-separator">/</div>
                `;
            }
        }).join('');
        
        breadcrumbContainer.innerHTML = `
            <nav class="breadcrumb" aria-label="Breadcrumb">
                ${breadcrumbHTML}
            </nav>
        `;
    };
    
    /**
     * Page Title Updater
     */
    window.updatePageTitle = function(title, subtitle = '') {
        const titleElement = document.querySelector('.dashboard-page-title');
        const subtitleElement = document.querySelector('.dashboard-page-subtitle');
        
        if (titleElement) {
            titleElement.textContent = title;
        }
        
        if (subtitleElement && subtitle) {
            subtitleElement.textContent = subtitle;
        }
        
        // Also update document title
        document.title = `${title} - Nexus`;
    };
    
    /**
     * Mobile Menu Overlay
     */
    function createMobileOverlay() {
        const sidebar = document.getElementById('dashboardSidebar');
        if (!sidebar) return;
        
        let overlay = document.getElementById('mobile-overlay');
        
        if (!overlay) {
            overlay = document.createElement('div');
            overlay.id = 'mobile-overlay';
            overlay.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 999;
                display: none;
            `;
            document.body.appendChild(overlay);
            
            overlay.addEventListener('click', function() {
                sidebar.classList.remove('mobile-open');
                overlay.style.display = 'none';
            });
        }
        
        // Observer for sidebar mobile-open class
        const observer = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.attributeName === 'class') {
                    const isOpen = sidebar.classList.contains('mobile-open');
                    overlay.style.display = isOpen ? 'block' : 'none';
                }
            });
        });
        
        observer.observe(sidebar, { attributes: true });
    }
    
    createMobileOverlay();
    
    /**
     * Utility: Debounce function
     */
    function debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }
    
    /**
     * Export layout functions globally
     */
    window.NexusLayout = {
        toggleSidebar: toggleSidebar,
        setActiveNavItem: window.setActiveNavItem,
        updatePageTitle: window.updatePageTitle,
        generateBreadcrumb: window.generateBreadcrumb
    };
    
})();
