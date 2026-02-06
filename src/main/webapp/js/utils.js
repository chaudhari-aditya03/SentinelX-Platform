/**
 * UTILS.JS - Utility Functions
 * Purpose: Reusable helper functions for the application
 * Part of Nexus Design System
 */

(function() {
    'use strict';
    
    /**
     * AJAX Helper Functions
     */
    const Ajax = {
        /**
         * GET request
         */
        get: function(url, callback, errorCallback) {
            fetch(url, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => callback(data))
            .catch(error => {
                console.error('GET Error:', error);
                if (errorCallback) errorCallback(error);
            });
        },
        
        /**
         * POST request
         */
        post: function(url, data, callback, errorCallback) {
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => callback(data))
            .catch(error => {
                console.error('POST Error:', error);
                if (errorCallback) errorCallback(error);
            });
        },
        
        /**
         * PUT request
         */
        put: function(url, data, callback, errorCallback) {
            fetch(url, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => callback(data))
            .catch(error => {
                console.error('PUT Error:', error);
                if (errorCallback) errorCallback(error);
            });
        },
        
        /**
         * DELETE request
         */
        delete: function(url, callback, errorCallback) {
            fetch(url, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => callback(data))
            .catch(error => {
                console.error('DELETE Error:', error);
                if (errorCallback) errorCallback(error);
            });
        }
    };
    
    /**
     * Form Validation Utilities
     */
    const FormValidator = {
        /**
         * Validate email format
         */
        isValidEmail: function(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(email);
        },
        
        /**
         * Validate phone number (basic)
         */
        isValidPhone: function(phone) {
            const re = /^[\d\s\-\+\(\)]{10,}$/;
            return re.test(phone);
        },
        
        /**
         * Validate password strength
         */
        isStrongPassword: function(password) {
            // At least 8 characters, 1 uppercase, 1 lowercase, 1 number
            const re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$/;
            return re.test(password);
        },
        
        /**
         * Validate required fields
         */
        validateRequired: function(form) {
            const requiredFields = form.querySelectorAll('[required]');
            let isValid = true;
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    field.classList.add('is-invalid');
                    isValid = false;
                } else {
                    field.classList.remove('is-invalid');
                    field.classList.add('is-valid');
                }
            });
            
            return isValid;
        }
    };
    
    /**
     * Date and Time Utilities
     */
    const DateUtils = {
        /**
         * Format date to readable string
         */
        format: function(date, format = 'MMM DD, YYYY') {
            const d = new Date(date);
            const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
                          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 
                         'Thursday', 'Friday', 'Saturday'];
            
            return format
                .replace('YYYY', d.getFullYear())
                .replace('MMM', months[d.getMonth()])
                .replace('MM', String(d.getMonth() + 1).padStart(2, '0'))
                .replace('DD', String(d.getDate()).padStart(2, '0'))
                .replace('Day', days[d.getDay()]);
        },
        
        /**
         * Get relative time (e.g., "2 hours ago")
         */
        timeAgo: function(date) {
            const seconds = Math.floor((new Date() - new Date(date)) / 1000);
            
            const intervals = {
                year: 31536000,
                month: 2592000,
                week: 604800,
                day: 86400,
                hour: 3600,
                minute: 60,
                second: 1
            };
            
            for (const [name, secondsInInterval] of Object.entries(intervals)) {
                const interval = Math.floor(seconds / secondsInInterval);
                
                if (interval >= 1) {
                    return interval === 1 
                        ? `1 ${name} ago` 
                        : `${interval} ${name}s ago`;
                }
            }
            
            return 'just now';
        },
        
        /**
         * Check if date is today
         */
        isToday: function(date) {
            const today = new Date();
            const checkDate = new Date(date);
            
            return today.getDate() === checkDate.getDate() &&
                   today.getMonth() === checkDate.getMonth() &&
                   today.getFullYear() === checkDate.getFullYear();
        },
        
        /**
         * Get date range
         */
        getDateRange: function(days) {
            const end = new Date();
            const start = new Date();
            start.setDate(start.getDate() - days);
            
            return {
                start: start,
                end: end
            };
        }
    };
    
    /**
     * String Utilities
     */
    const StringUtils = {
        /**
         * Truncate string with ellipsis
         */
        truncate: function(str, length = 50) {
            return str.length > length ? str.substring(0, length) + '...' : str;
        },
        
        /**
         * Capitalize first letter
         */
        capitalize: function(str) {
            return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase();
        },
        
        /**
         * Convert to title case
         */
        titleCase: function(str) {
            return str.toLowerCase().split(' ').map(word => 
                word.charAt(0).toUpperCase() + word.slice(1)
            ).join(' ');
        },
        
        /**
         * Generate slug from string
         */
        slugify: function(str) {
            return str
                .toLowerCase()
                .replace(/[^\w\s-]/g, '')
                .replace(/[\s_-]+/g, '-')
                .replace(/^-+|-+$/g, '');
        },
        
        /**
         * Escape HTML
         */
        escapeHtml: function(str) {
            const div = document.createElement('div');
            div.textContent = str;
            return div.innerHTML;
        }
    };
    
    /**
     * Number Utilities
     */
    const NumberUtils = {
        /**
         * Format number with commas
         */
        format: function(num) {
            return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
        },
        
        /**
         * Format as currency
         */
        currency: function(num, symbol = '$') {
            return symbol + this.format(num.toFixed(2));
        },
        
        /**
         * Format as percentage
         */
        percentage: function(num, decimals = 1) {
            return num.toFixed(decimals) + '%';
        },
        
        /**
         * Abbreviate large numbers (e.g., 1.5K, 2.3M)
         */
        abbreviate: function(num) {
            if (num >= 1000000000) {
                return (num / 1000000000).toFixed(1) + 'B';
            }
            if (num >= 1000000) {
                return (num / 1000000).toFixed(1) + 'M';
            }
            if (num >= 1000) {
                return (num / 1000).toFixed(1) + 'K';
            }
            return num.toString();
        }
    };
    
    /**
     * Array Utilities
     */
    const ArrayUtils = {
        /**
         * Remove duplicates
         */
        unique: function(arr) {
            return [...new Set(arr)];
        },
        
        /**
         * Shuffle array
         */
        shuffle: function(arr) {
            const newArr = [...arr];
            for (let i = newArr.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * (i + 1));
                [newArr[i], newArr[j]] = [newArr[j], newArr[i]];
            }
            return newArr;
        },
        
        /**
         * Group by property
         */
        groupBy: function(arr, key) {
            return arr.reduce((result, item) => {
                const group = item[key];
                if (!result[group]) result[group] = [];
                result[group].push(item);
                return result;
            }, {});
        },
        
        /**
         * Sort by property
         */
        sortBy: function(arr, key, ascending = true) {
            return arr.sort((a, b) => {
                const aVal = a[key];
                const bVal = b[key];
                
                if (ascending) {
                    return aVal > bVal ? 1 : aVal < bVal ? -1 : 0;
                } else {
                    return aVal < bVal ? 1 : aVal > bVal ? -1 : 0;
                }
            });
        }
    };
    
    /**
     * Local Storage Utilities
     */
    const StorageUtils = {
        /**
         * Set item in localStorage
         */
        set: function(key, value) {
            try {
                localStorage.setItem(key, JSON.stringify(value));
                return true;
            } catch (e) {
                console.error('Storage Error:', e);
                return false;
            }
        },
        
        /**
         * Get item from localStorage
         */
        get: function(key, defaultValue = null) {
            try {
                const item = localStorage.getItem(key);
                return item ? JSON.parse(item) : defaultValue;
            } catch (e) {
                console.error('Storage Error:', e);
                return defaultValue;
            }
        },
        
        /**
         * Remove item from localStorage
         */
        remove: function(key) {
            try {
                localStorage.removeItem(key);
                return true;
            } catch (e) {
                console.error('Storage Error:', e);
                return false;
            }
        },
        
        /**
         * Clear all localStorage
         */
        clear: function() {
            try {
                localStorage.clear();
                return true;
            } catch (e) {
                console.error('Storage Error:', e);
                return false;
            }
        }
    };
    
    /**
     * URL Utilities
     */
    const UrlUtils = {
        /**
         * Get URL parameter
         */
        getParam: function(name) {
            const params = new URLSearchParams(window.location.search);
            return params.get(name);
        },
        
        /**
         * Get all URL parameters as object
         */
        getParams: function() {
            const params = new URLSearchParams(window.location.search);
            const result = {};
            
            for (const [key, value] of params) {
                result[key] = value;
            }
            
            return result;
        },
        
        /**
         * Build query string from object
         */
        buildQuery: function(params) {
            return Object.keys(params)
                .map(key => `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`)
                .join('&');
        }
    };
    
    /**
     * Copy to Clipboard
     */
    function copyToClipboard(text) {
        if (navigator.clipboard) {
            navigator.clipboard.writeText(text).then(() => {
                showAlert('Success', 'Copied to clipboard', 'success', 2000);
            }).catch(err => {
                console.error('Copy failed:', err);
            });
        } else {
            // Fallback for older browsers
            const textarea = document.createElement('textarea');
            textarea.value = text;
            textarea.style.position = 'fixed';
            textarea.style.opacity = '0';
            document.body.appendChild(textarea);
            textarea.select();
            document.execCommand('copy');
            document.body.removeChild(textarea);
            showAlert('Success', 'Copied to clipboard', 'success', 2000);
        }
    }
    
    /**
     * Download File
     */
    function downloadFile(data, filename, type = 'text/plain') {
        const blob = new Blob([data], { type: type });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = filename;
        a.click();
        window.URL.revokeObjectURL(url);
    }
    
    /**
     * Export all utilities globally
     */
    window.NexusUtils = {
        Ajax: Ajax,
        FormValidator: FormValidator,
        DateUtils: DateUtils,
        StringUtils: StringUtils,
        NumberUtils: NumberUtils,
        ArrayUtils: ArrayUtils,
        StorageUtils: StorageUtils,
        UrlUtils: UrlUtils,
        copyToClipboard: copyToClipboard,
        downloadFile: downloadFile
    };
    
})();
