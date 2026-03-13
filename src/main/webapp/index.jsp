<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SwiftRide - Premium Bus Booking SPA</title>
    <!-- Tailwind CSS v3 CDN -->
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
    <!-- Google Fonts: Inter & Outfit -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Outfit:wght@400;600;700&display=swap" rel="stylesheet"/>
    
    <script>
        tailwind.config = {
          darkMode: 'class',
          theme: {
            extend: {
              colors: {
                primary: {
                    50: '#fef2f2',
                    100: '#fee2e2',
                    500: '#d84e55',
                    600: '#b91c1c',
                    700: '#991b1b',
                },
                secondary: '#1a2b49',
                accent: '#f8f9fa',
              },
              fontFamily: {
                sans: ['Inter', 'sans-serif'],
                display: ['Outfit', 'sans-serif'],
              },
              boxShadow: {
                'glass': '0 8px 32px 0 rgba(31, 38, 135, 0.07)',
                'premium': '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
              }
            }
          }
        }
    </script>

    <style>
        :root {
            --glass-bg: rgba(255, 255, 255, 0.85);
            --glass-border: rgba(255, 255, 255, 0.2);
        }

        .dark {
            --glass-bg: rgba(15, 23, 42, 0.85);
            --glass-border: rgba(255, 255, 255, 0.05);
        }

        .glass-effect {
            background: var(--glass-bg);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid var(--glass-border);
        }

        .gradient-text {
            background: linear-gradient(135deg, #d84e55 0%, #1a2b49 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hero-bg {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1544620347-c4fd4a3d5957?auto=format&fit=crop&q=80&w=2069');
            background-size: cover;
            background-position: center;
        }

        /* View Animations */
        .view-section {
            display: none;
            animation: fadeIn 0.4s ease-out forwards;
        }

        .view-section.active {
            display: block;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes bounceIn {
            0% { opacity: 0; transform: translateY(-20px) scale(0.9); }
            50% { opacity: 1; transform: translateY(5px) scale(1.02); }
            100% { transform: translateY(0) scale(1); }
        }

        @keyframes dash {
            to { stroke-dashoffset: 0; }
        }

        .animate-dash {
            stroke-dasharray: 1000;
            stroke-dashoffset: 1000;
            animation: dash 3s ease-out forwards;
        }

        .animate-bounce-in {
            animation: bounceIn 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55) forwards;
        }

        /* Seat Styles */
        .seat { transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1); }
        .seat.selected { background-color: #d84e55 !important; color: white !important; transform: scale(1.1); }
        .seat.booked { cursor: not-allowed; background-color: #e5e7eb !important; color: #9ca3af !important; border-color: #d1d5db !important; }
        .dark .seat.booked { background-color: #1e293b !important; color: #475569 !important; border-color: #334155 !important; }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #f1f1f1; }
        .dark :-webkit-scrollbar-track { background: #0f172a; }
        ::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: #94a3b8; }
    </style>
</head>
<body class="bg-slate-50 text-slate-900 dark:bg-slate-950 dark:text-slate-100 font-sans leading-relaxed overflow-x-hidden transition-colors duration-300">

<!-- Navigation -->
<nav class="sticky top-0 z-50 glass-effect border-b">
    <div class="container mx-auto px-6 py-4 flex items-center justify-between">
        <a href="#" onclick="showView('hero')" class="flex items-center gap-3 group">
            <div class="w-10 h-10 bg-primary-500 rounded-xl flex items-center justify-center text-white shadow-lg group-hover:rotate-12 transition-transform">
                <i class="fas fa-bus-alt text-xl"></i>
            </div>
            <span class="text-2xl font-display font-bold text-secondary tracking-tight">SwiftRide</span>
        </a>

        <div class="hidden md:flex items-center gap-8 font-medium" id="nav-main-links">
            <a href="#" onclick="showView('hero')" class="hover:text-primary-500 transition-colors nav-user-link">Home</a>
            <a href="#" onclick="showView('offers')" class="hover:text-primary-500 transition-colors nav-user-link">Offers</a>
            <a href="#" onclick="showView('help')" class="hover:text-primary-500 transition-colors nav-user-link">Help</a>
            
            <!-- Theme Toggle -->
            <button onclick="toggleTheme()" class="w-10 h-10 rounded-xl bg-slate-100 dark:bg-slate-800 text-slate-500 dark:text-slate-400 hover:text-primary-500 transition-all flex items-center justify-center">
                <i id="theme-icon" class="fas fa-moon"></i>
            </button>

            <div id="nav-auth-links" class="flex items-center gap-4">
                <!-- Dynamic Content -->
            </div>
        </div>

        <button class="md:hidden text-2xl text-secondary">
            <i class="fas fa-bars"></i>
        </button>
    </div>
</nav>

<!-- Booking Stepper -->
<div id="booking-stepper" class="container mx-auto px-6 py-8 flex justify-center gap-4 hidden transition-all duration-500"></div>

<!-- View: Hero / Landing -->
<section id="view-hero" class="view-section active">
    <!-- Hero Section -->
    <div class="hero-bg h-[500px] flex items-center justify-center relative">
        <div class="text-center text-white px-4">
            <h1 class="text-5xl md:text-7xl font-display font-bold mb-6 tracking-tight">Travel with Confidence</h1>
            <p class="text-xl opacity-90 mb-12 max-w-2xl mx-auto">Book your bus tickets in seconds. Reliable, fast, and always on time.</p>
        </div>
        
        <!-- Search Bar -->
        <div class="absolute -bottom-20 left-1/2 -translate-x-1/2 w-full max-w-5xl px-6">
            <div class="glass-effect p-8 rounded-[2rem] shadow-premium flex flex-col md:flex-row gap-4 items-end">
                <div class="flex-1 w-full relative">
                    <label class="block text-xs font-bold uppercase tracking-widest text-slate-500 mb-2 ml-1">From</label>
                    <div class="relative">
                        <i class="fas fa-map-marker-alt absolute left-4 top-1/2 -translate-y-1/2 text-primary-500"></i>
                        <input type="text" id="search-from" oninput="showSuggestions('from')" autocomplete="off" placeholder="Source City" class="w-full pl-12 pr-4 py-4 rounded-2xl bg-white dark:bg-slate-900 dark:text-white border-slate-200 dark:border-slate-800 focus:ring-primary-500 focus:border-primary-500 shadow-sm outline-none">
                        <div id="suggestions-from" class="absolute left-0 right-0 top-full mt-2 bg-white dark:bg-slate-900 rounded-2xl shadow-premium z-50 hidden border border-slate-100 dark:border-slate-800 overflow-hidden"></div>
                    </div>
                </div>
                <!-- Swap Button -->
                <button class="bg-white dark:bg-slate-800 p-3 rounded-full border dark:border-slate-700 shadow-sm hover:bg-slate-50 dark:hover:bg-slate-700 transition-colors -mb-2 z-10 hidden md:block" onclick="swapCities()">
                    <i class="fas fa-exchange-alt text-slate-400"></i>
                </button>
                <div class="flex-1 w-full relative">
                    <label class="block text-xs font-bold uppercase tracking-widest text-slate-500 mb-2 ml-1">To</label>
                    <div class="relative">
                        <i class="fas fa-route absolute left-4 top-1/2 -translate-y-1/2 text-primary-500"></i>
                        <input type="text" id="search-to" oninput="showSuggestions('to')" autocomplete="off" placeholder="Destination City" class="w-full pl-12 pr-4 py-4 rounded-2xl bg-white dark:bg-slate-900 dark:text-white border-slate-200 dark:border-slate-800 focus:ring-primary-500 focus:border-primary-500 shadow-sm outline-none">
                        <div id="suggestions-to" class="absolute left-0 right-0 top-full mt-2 bg-white dark:bg-slate-900 rounded-2xl shadow-premium z-50 hidden border border-slate-100 dark:border-slate-800 overflow-hidden"></div>
                    </div>
                </div>
                <div class="flex-1 w-full relative">
                    <label class="block text-xs font-bold uppercase tracking-widest text-slate-500 mb-2 ml-1">Date</label>
                    <div class="relative">
                        <i class="fas fa-calendar-alt absolute left-4 top-1/2 -translate-y-1/2 text-primary-500"></i>
                        <input type="date" id="search-date" class="w-full pl-12 pr-4 py-4 rounded-2xl bg-white dark:bg-slate-900 dark:text-white border-slate-200 dark:border-slate-800 focus:ring-primary-500 focus:border-primary-500 shadow-sm outline-none">
                    </div>
                </div>
                <button onclick="handleSearch()" class="w-full md:w-auto px-10 py-4 bg-primary-500 text-white font-bold rounded-2xl hover:bg-primary-600 shadow-lg shadow-primary-500/30 transition-all active:scale-95">
                    SEARCH
                </button>
            </div>
        </div>
    </div>

    <!-- Popular Routes -->
    <div class="mt-40 container mx-auto px-6 mb-20">
        <h2 class="text-3xl font-display font-bold text-secondary dark:text-white mb-10 flex items-center gap-3">
            <span class="w-2 h-8 bg-primary-500 rounded-full"></span>
            Popular Routes
        </h2>
        <div id="popular-routes-grid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <!-- Dynamic Routes -->
        </div>
    </div>
</section>

<!-- View: Search Results -->
<section id="view-results" class="view-section container mx-auto px-6 py-12">
    <div class="mb-8 flex items-center justify-between">
        <button onclick="showView('hero')" class="flex items-center gap-2 text-slate-500 hover:text-primary-500 font-bold transition-all group">
            <i class="fas fa-arrow-left group-hover:-translate-x-1 transition-transform"></i>
            BACK TO SEARCH
        </button>
    </div>
    <div class="flex flex-col lg:flex-row gap-8">
        <!-- Filters Sidebar -->
        <aside class="w-full lg:w-72 space-y-8">
            <div class="bg-white dark:bg-slate-900 p-8 rounded-[2.5rem] shadow-sm border border-slate-100 dark:border-slate-800 sticky top-32">
                <div class="flex items-center justify-between mb-8">
                    <h3 class="font-display font-bold text-secondary dark:text-white uppercase tracking-widest text-xs">Filters</h3>
                    <button onclick="clearFilters()" class="text-[10px] font-bold text-primary-500 uppercase hover:underline">Clear All</button>
                </div>
                
                <div class="space-y-8">
                    <!-- Bus Type -->
                    <div>
                        <h4 class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-4">Bus Type</h4>
                        <div class="space-y-3">
                            <label class="flex items-center gap-3 cursor-pointer group">
                                <input type="checkbox" name="f-type" value="AC Seater" onchange="applyFilters()" class="rounded border-slate-200 text-primary-500 focus:ring-primary-500">
                                <span class="text-sm text-slate-600 dark:text-slate-400 group-hover:text-primary-500 transition-colors">AC Seater</span>
                            </label>
                            <label class="flex items-center gap-3 cursor-pointer group">
                                <input type="checkbox" name="f-type" value="Non-AC Seater" onchange="applyFilters()" class="rounded border-slate-200 text-primary-500 focus:ring-primary-500">
                                <span class="text-sm text-slate-600 dark:text-slate-400 group-hover:text-primary-500 transition-colors">Non-AC Seater</span>
                            </label>
                        </div>
                    </div>

                    <!-- Departure Timing -->
                    <div>
                        <h4 class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-4">Departure Time</h4>
                        <div class="space-y-3">
                            <label class="flex items-center gap-3 cursor-pointer group">
                                <input type="checkbox" name="f-time" value="morning" onchange="applyFilters()" class="rounded border-slate-200 text-primary-500 focus:ring-primary-500">
                                <span class="text-sm text-slate-600 dark:text-slate-400">Morning (6AM - 12PM)</span>
                            </label>
                            <label class="flex items-center gap-3 cursor-pointer group">
                                <input type="checkbox" name="f-time" value="afternoon" onchange="applyFilters()" class="rounded border-slate-200 text-primary-500 focus:ring-primary-500">
                                <span class="text-sm text-slate-600 dark:text-slate-400">Afternoon (12PM - 6PM)</span>
                            </label>
                            <label class="flex items-center gap-3 cursor-pointer group">
                                <input type="checkbox" name="f-time" value="evening" onchange="applyFilters()" class="rounded border-slate-200 text-primary-500 focus:ring-primary-500">
                                <span class="text-sm text-slate-600 dark:text-slate-400">Evening (6PM - 12AM)</span>
                            </label>
                        </div>
                    </div>

                    <!-- Price Range -->
                    <div>
                        <h4 class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-4">Price Range</h4>
                        <div class="space-y-3">
                            <label class="flex items-center gap-3 cursor-pointer group">
                                <input type="checkbox" name="f-price" value="0-1000" onchange="applyFilters()" class="rounded border-slate-200 text-primary-500 focus:ring-primary-500">
                                <span class="text-sm text-slate-600 dark:text-slate-400">Under ₹1,000</span>
                            </label>
                            <label class="flex items-center gap-3 cursor-pointer group">
                                <input type="checkbox" name="f-price" value="1000-2000" onchange="applyFilters()" class="rounded border-slate-200 text-primary-500 focus:ring-primary-500">
                                <span class="text-sm text-slate-600 dark:text-slate-400">₹1,000 - ₹2,000</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </aside>

        <!-- Results List -->
        <div class="flex-1 space-y-6">
            <div class="flex items-center justify-between mb-4">
                <h2 id="results-count" class="text-xl font-bold text-slate-700">Available Buses</h2>
                <div class="flex items-center gap-2 text-sm text-slate-500">
                    Sort by: 
                    <select id="sort-by" onchange="handleSort()" class="border-none bg-transparent font-bold text-slate-800 focus:ring-0 cursor-pointer">
                        <option value="price-low">Price: Low to High</option>
                        <option value="rating-high">Rating: High to Low</option>
                    </select>
                </div>
            </div>
            <div id="buses-container" class="space-y-6">
                <!-- Dynamic Bus Cards -->
            </div>
        </div>
    </div>
</section>

<!-- View: Seat Selection -->
<section id="view-seats" class="view-section container mx-auto px-6 py-12">
    <div class="max-w-6xl mx-auto mb-8">
        <button onclick="showView('results')" class="flex items-center gap-2 text-slate-500 hover:text-primary-500 font-bold transition-all group">
            <i class="fas fa-arrow-left group-hover:-translate-x-1 transition-transform"></i>
            BACK TO BUS RESULTS
        </button>
    </div>
    <div class="max-w-6xl mx-auto flex flex-col lg:flex-row gap-10">
        <!-- Bus Visualizer -->
        <div class="flex-1 bg-white p-10 rounded-[2.5rem] shadow-sm border border-slate-100">
            <div class="flex items-center justify-between mb-10 pb-6 border-b border-slate-100">
                <div>
                    <h2 class="text-2xl font-display font-bold text-secondary" id="seat-bus-name">Bus Name</h2>
                    <p class="text-slate-500 text-sm" id="seat-bus-info">AC Sleeper | 12 May 2024</p>
                </div>
                <div class="flex gap-6">
                    <div class="flex items-center gap-2"><div class="w-4 h-4 rounded-sm border-2 border-emerald-500 bg-emerald-50"></div><span class="text-xs font-semibold text-slate-600 uppercase tracking-tighter">Available</span></div>
                    <div class="flex items-center gap-2"><div class="w-4 h-4 rounded-sm bg-primary-500"></div><span class="text-xs font-semibold text-slate-600 uppercase tracking-tighter">Selected</span></div>
                    <div class="flex items-center gap-2"><div class="w-4 h-4 rounded-sm bg-slate-200"></div><span class="text-xs font-semibold text-slate-600 uppercase tracking-tighter">Occupied</span></div>
                </div>
            </div>

            <div class="relative bg-slate-50 rounded-[3rem] p-8 border-4 border-slate-200 mx-auto max-w-sm">
                <!-- Steering Wheel -->
                <div class="flex justify-end mb-12 pr-4">
                    <div class="w-10 h-10 bg-slate-300 rounded-full flex items-center justify-center text-slate-500 shadow-inner">
                        <i class="fas fa-dharmachakra"></i>
                    </div>
                </div>
                
                <div id="seats-grid" class="space-y-4">
                    <!-- Dynamic Grid -->
                </div>
                
                <div class="mt-10 text-center uppercase tracking-widest text-[10px] font-bold text-slate-400 border-t pt-4">Rear of the bus</div>
            </div>
        </div>

        <!-- Booking Summary Sidebar -->
        <aside class="w-full lg:w-96">
            <div class="bg-white rounded-[2rem] shadow-premium border border-slate-50 sticky top-32 max-h-[calc(100vh-10rem)] flex flex-col overflow-hidden">
                <!-- Fixed Header -->
                <div class="p-8 pb-4 border-b border-slate-50">
                    <h3 class="text-xl font-bold text-secondary">Booking Summary</h3>
                </div>
                
                <!-- Scrollable Content -->
                <div class="flex-1 overflow-y-auto p-8 pt-4 custom-scrollbar">
                    <div class="space-y-5">
                        <div class="flex justify-between items-center bg-slate-50 dark:bg-slate-900 p-4 rounded-2xl border border-slate-100 dark:border-slate-800">
                            <span class="text-slate-500 font-medium">Selected Seats</span>
                            <span id="selected-seats-list" class="font-bold text-slate-800 dark:text-slate-100">None</span>
                        </div>
    
                        <!-- Amenities Section -->
                        <div class="px-4 space-y-3">
                            <label class="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1">Add-ons (Optional)</label>
                            <div class="flex items-center justify-between text-xs">
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input type="checkbox" id="amenity-insurance" onchange="updateSeatSummary()" class="rounded border-slate-200 text-primary-500 focus:ring-primary-500">
                                    <span class="text-slate-600 dark:text-slate-400">Travel Insurance</span>
                                </label>
                                <span class="font-bold text-slate-500">₹15</span>
                            </div>
                            <div class="flex items-center justify-between text-xs">
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input type="checkbox" id="amenity-meal" onchange="updateSeatSummary()" class="rounded border-slate-200 text-primary-500 focus:ring-primary-500">
                                    <span class="text-slate-600 dark:text-slate-400">Meal Pack (Snacks)</span>
                                </label>
                                <span class="font-bold text-slate-500">₹150</span>
                            </div>
                        </div>
    
                        <!-- SwiftCash Section -->
                        <div id="swiftcash-area" class="px-4 py-3 bg-amber-50 dark:bg-amber-900/10 rounded-2xl border border-amber-100 dark:border-amber-900/30">
                            <div class="flex items-center justify-between">
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input type="checkbox" id="use-swiftcash" onchange="updateSeatSummary()" class="rounded border-amber-300 text-amber-500 focus:ring-amber-500">
                                    <span class="text-xs font-bold text-amber-600 dark:text-amber-400 uppercase tracking-wider">Use SwiftCash</span>
                                </label>
                                <span id="available-swiftcash" class="text-xs font-bold text-amber-600">₹0</span>
                            </div>
                        </div>
    
                        <!-- Payment Method Section -->
                        <div class="px-4 space-y-3">
                            <label class="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1">Payment Method</label>
                            <div class="grid grid-cols-2 gap-2">
                                <label class="cursor-pointer">
                                    <input type="radio" name="pay-method" value="wallet" checked onchange="updateSeatSummary()" class="hidden peer">
                                    <div class="p-3 border-2 rounded-xl text-center peer-checked:border-primary-500 peer-checked:bg-primary-50 transition-all">
                                        <i class="fas fa-wallet block mb-1"></i>
                                        <span class="text-[10px] font-bold uppercase">Wallet</span>
                                    </div>
                                </label>
                                <label class="cursor-pointer">
                                    <input type="radio" name="pay-method" value="card" onchange="updateSeatSummary()" class="hidden peer">
                                    <div class="p-3 border-2 rounded-xl text-center peer-checked:border-primary-500 peer-checked:bg-primary-50 transition-all">
                                        <i class="fas fa-credit-card block mb-1"></i>
                                        <span class="text-[10px] font-bold uppercase">Card/UPI</span>
                                    </div>
                                </label>
                            </div>
                        </div>
    
                        <div id="discount-row" class="hidden justify-between items-center text-primary-500 font-bold px-4">
                            <span class="text-sm">Discount applied</span>
                            <span id="discount-amount">-₹0.00</span>
                        </div>
                    </div>
                </div>
                
                <!-- Fixed Footer -->
                <div class="p-8 pt-6 border-t border-slate-50 space-y-4 bg-slate-50/50">
                    <div class="flex justify-between items-end px-2">
                        <div>
                            <span class="text-xs font-bold text-slate-400 uppercase">Total Amount</span>
                            <div id="total-price" class="text-3xl font-display font-bold text-primary-500">₹0.00</div>
                        </div>
                    </div>
                    <button onclick="handleBookingProceed()" id="proceed-btn" disabled class="w-full py-5 bg-slate-200 text-slate-400 font-bold rounded-2xl transition-all active:scale-95 disabled:cursor-not-allowed shadow-lg shadow-slate-200/50">
                        PROCEED TO PAY
                    </button>
                </div>
            </div>
        </aside>
    </div>
</section>

<!-- View: User Dashboard -->
<section id="view-dashboard" class="view-section container mx-auto px-6 py-12">
    <div class="flex flex-col md:flex-row gap-10">
        <!-- Profile Column -->
        <div class="md:w-80 space-y-6">
            <div class="bg-white dark:bg-slate-900 p-8 rounded-[2.5rem] shadow-premium text-center relative overflow-hidden border border-slate-100 dark:border-slate-800">
                <div class="absolute top-0 left-0 w-full h-24 bg-primary-500"></div>
                <div class="relative pt-8">
                    <img id="dash-user-avatar" src="https://ui-avatars.com/api/?name=User&background=random" class="w-24 h-24 rounded-full mx-auto border-4 border-white dark:border-slate-800 shadow-lg mb-4">
                    <h3 id="dash-user-name" class="text-2xl font-display font-bold text-secondary dark:text-white">Loading...</h3>
                    <p id="dash-user-email" class="text-slate-500 mb-6">Loading...</p>
                    <div class="flex gap-2">
                        <button onclick="openProfileEdit()" class="flex-1 py-3 bg-slate-50 dark:bg-slate-800 border dark:border-slate-700 rounded-xl font-semibold hover:bg-slate-100 dark:hover:bg-slate-700 transition-all">Edit Profile</button>
                        <button onclick="topUpWallet()" class="w-12 h-12 bg-primary-50 dark:bg-primary-900/20 text-primary-500 rounded-xl hover:bg-primary-100 dark:hover:bg-primary-900/40 flex items-center justify-center transition-all"><i class="fas fa-wallet text-sm"></i></button>
                    </div>
                </div>
            </div>
            
            <div class="bg-white dark:bg-slate-900 p-6 rounded-3xl shadow-sm border border-slate-100 dark:border-slate-800 flex items-center justify-between">
                <div>
                    <span class="text-xs font-bold text-slate-400 uppercase">Wallet Balance</span>
                    <div id="dash-wallet" class="text-2xl font-display font-bold text-primary-500">₹0.00</div>
                </div>
                <button onclick="topUpWallet()" class="w-12 h-12 bg-primary-50 dark:bg-primary-900/20 text-primary-500 rounded-2xl hover:bg-primary-100 dark:hover:bg-primary-900/40 flex items-center justify-center transition-all" title="Add Money">
                    <i class="fas fa-plus"></i>
                </button>
            </div>

            <div class="bg-white dark:bg-slate-900 p-6 rounded-3xl shadow-sm border border-slate-100 dark:border-slate-800 flex items-center justify-between">
                <div>
                    <span class="text-xs font-bold text-slate-400 uppercase">SwiftCash Balance</span>
                    <div id="dash-swiftcash-val" class="text-2xl font-display font-bold text-primary-500">₹0.00</div>
                </div>
                <div class="w-12 h-12 bg-amber-50 rounded-2xl flex items-center justify-center text-amber-500">
                    <i class="fas fa-coins"></i>
                </div>
            </div>

            <!-- Refer & Earn Card -->
            <div class="bg-gradient-to-br from-amber-400 to-amber-600 p-8 rounded-[2.5rem] shadow-lg text-white relative overflow-hidden group">
                <div class="absolute -top-10 -right-10 w-32 h-32 bg-white/10 rounded-full group-hover:scale-150 transition-all duration-700"></div>
                <div class="relative z-10">
                    <div class="flex items-center gap-3 mb-4">
                        <i class="fas fa-gift text-xl"></i>
                        <span class="text-xs font-bold uppercase tracking-widest">Refer & Earn</span>
                    </div>
                    <p class="text-sm opacity-90 mb-6">Invite friends and earn <span class="font-bold text-white">₹100 SwiftCash</span>!</p>
                    <div class="bg-white/20 p-4 rounded-2xl backdrop-blur-md border border-white/20">
                        <div class="text-[10px] uppercase font-bold opacity-70 mb-1">Your Code</div>
                        <div class="flex items-center justify-between">
                            <span id="dash-ref-code" class="text-xl font-bold tracking-widest uppercase">SR-REF</span>
                            <button onclick="navigator.clipboard.writeText(document.getElementById('dash-ref-code').innerText); showNotification('Copied', 'Code copied', 'success')" class="text-white"><i class="far fa-copy"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="flex-1">
            <h2 class="text-2xl font-display font-bold text-secondary dark:text-white mb-8">My Recent Bookings</h2>
            <div id="bookings-history-grid" class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <!-- Dynamic Booking Cards -->
            </div>
        </div>
    </div>
</section>

<!-- View: Admin Dashboard -->
<section id="view-admin" class="view-section container mx-auto px-6 py-12">
    <div class="flex items-center justify-between mb-12">
        <h1 class="text-4xl font-display font-bold text-secondary dark:text-white">Admin Console</h1>
        <div class="flex gap-4">
            <!-- Global admin utilities can go here if needed -->
        </div>
    </div>

    <!-- Tabs -->
    <div class="flex gap-8 mb-8 border-b border-slate-100 pb-1">
        <button onclick="switchAdminTab('bookings')" id="tab-bookings" class="admin-tab-btn pb-4 border-b-2 border-primary-500 text-primary-500 font-bold text-sm transition-all focus:outline-none">Management Bookings</button>
        <button onclick="switchAdminTab('buses')" id="tab-buses" class="admin-tab-btn pb-4 border-b-2 border-transparent text-slate-400 font-bold text-sm hover:text-secondary transition-all focus:outline-none">Manage Buses</button>
        <button onclick="switchAdminTab('users')" id="tab-users" class="admin-tab-btn pb-4 border-b-2 border-transparent text-slate-400 font-bold text-sm hover:text-secondary transition-all focus:outline-none">Manage Users</button>
        <button onclick="switchAdminTab('coupons')" id="tab-coupons" class="admin-tab-btn pb-4 border-b-2 border-transparent text-slate-400 font-bold text-sm hover:text-secondary transition-all focus:outline-none">Manage Coupons</button>
    </div>

    <!-- Stats Grid -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-12">
        <div class="bg-white dark:bg-slate-900 p-8 rounded-3xl shadow-sm border border-slate-100 dark:border-slate-800">
            <div class="flex items-center justify-between mb-4">
                <span class="p-3 bg-blue-50 dark:bg-blue-900/20 text-blue-600 rounded-2xl"><i class="fas fa-wallet text-xl"></i></span>
                <span class="text-xs font-bold text-emerald-500 bg-emerald-50 dark:bg-emerald-900/20 px-2 py-1 rounded-full">+12%</span>
            </div>
            <p class="text-slate-500 text-sm font-medium">Monthly Revenue</p>
            <h3 id="admin-stats-revenue" class="text-3xl font-display font-bold text-slate-800 dark:text-white mt-2">₹0</h3>
        </div>
        <div class="bg-white dark:bg-slate-900 p-8 rounded-3xl shadow-sm border border-slate-100 dark:border-slate-800">
            <div class="flex items-center justify-between mb-4">
                <span class="p-3 bg-purple-50 text-purple-600 rounded-2xl"><i class="fas fa-users text-xl"></i></span>
                <span class="text-xs font-bold text-emerald-500 bg-emerald-50 px-2 py-1 rounded-full">+5.2%</span>
            </div>
            <p class="text-slate-500 text-sm font-medium">Total Users</p>
            <h3 id="admin-stats-users" class="text-3xl font-display font-bold text-slate-800 mt-2">0</h3>
        </div>
        <div class="bg-white dark:bg-slate-900 p-8 rounded-3xl shadow-sm border border-slate-100 dark:border-slate-800">
            <div class="flex items-center justify-between mb-4">
                <span class="p-3 bg-orange-50 dark:bg-orange-900/20 text-orange-600 rounded-2xl"><i class="fas fa-ticket-alt text-xl"></i></span>
            </div>
            <p class="text-slate-500 text-sm font-medium">Total Bookings</p>
            <h3 id="admin-stats-bookings" class="text-3xl font-display font-bold text-slate-800 dark:text-white mt-2">0</h3>
        </div>
        <div class="bg-white dark:bg-slate-900 p-8 rounded-3xl shadow-sm border border-slate-100 dark:border-slate-800">
            <div class="flex items-center justify-between mb-4">
                <span class="p-3 bg-emerald-50 dark:bg-emerald-900/20 text-emerald-600 rounded-2xl"><i class="fas fa-bus text-xl"></i></span>
            </div>
            <p class="text-slate-500 text-sm font-medium">Active Buses</p>
            <h3 id="admin-stats-buses" class="text-3xl font-display font-bold text-slate-800 dark:text-white mt-2">0</h3>
        </div>
    </div> <!-- Ensure this grid is closed -->



    <!-- Recent Transactions -->
    <div class="bg-white dark:bg-slate-900 rounded-[2.5rem] shadow-sm border border-slate-100 dark:border-slate-800 overflow-hidden">
        <div class="p-8 border-b border-slate-50 dark:border-slate-800 flex items-center justify-between">
            <h3 class="text-xl font-bold text-secondary dark:text-white">System Activity</h3>
            <div id="admin-actions-container" class="flex gap-3">
                <!-- Buttons will be injected here dynamically -->
            </div>
        </div>
        <div id="admin-content-bookings" class="admin-tab-content">
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="bg-slate-50 dark:bg-slate-800 text-slate-500 text-xs uppercase font-bold tracking-widest">
                        <tr>
                            <th class="px-8 py-5">Transaction ID</th>
                            <th class="px-8 py-5">User</th>
                            <th class="px-8 py-5">Route</th>
                            <th class="px-8 py-5">Amount</th>
                            <th class="px-8 py-5">Status</th>
                            <th class="px-8 py-5">Action</th>
                        </tr>
                    </thead>
                    <tbody id="admin-tx-table" class="divide-y divide-slate-50">
                        <!-- Dynamic Data -->
                    </tbody>
                </table>
            </div>
        </div>

        <div id="admin-content-buses" class="admin-tab-content hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="bg-slate-50 dark:bg-slate-800 text-slate-500 text-xs uppercase font-bold tracking-widest">
                        <tr>
                            <th class="px-8 py-5">Bus Name</th>
                            <th class="px-8 py-5">Route</th>
                            <th class="px-8 py-5">Type</th>
                            <th class="px-8 py-5">Price</th>
                            <th class="px-8 py-5">Rating</th>
                            <th class="px-8 py-5">Action</th>
                        </tr>
                    </thead>
                    <tbody id="admin-bus-table" class="divide-y divide-slate-50 dark:divide-slate-800"></tbody>
                </table>
            </div>
        </div>

        <div id="admin-content-users" class="admin-tab-content hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="bg-slate-50 dark:bg-slate-800 text-slate-500 text-xs uppercase font-bold tracking-widest">
                        <tr>
                            <th class="px-8 py-5">Full Name</th>
                            <th class="px-8 py-5">Email</th>
                            <th class="px-8 py-5">Phone</th>
                            <th class="px-8 py-5">Role</th>
                            <th class="px-8 py-5">
                                Action
                            </th>
                        </tr>
                    </thead>
                    <tbody id="admin-user-table" class="divide-y divide-slate-50 dark:divide-slate-800"></tbody>
                </table>
            </div>
        </div>

        <div id="admin-content-coupons" class="admin-tab-content hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="bg-slate-50 dark:bg-slate-800 text-slate-500 text-xs uppercase font-bold tracking-widest">
                        <tr>
                            <th class="px-8 py-5">Code</th>
                            <th class="px-8 py-5">Discount</th>
                            <th class="px-8 py-5">Min Amount</th>
                            <th class="px-8 py-5">Expiry</th>
                            <th class="px-8 py-5">Action</th>
                        </tr>
                    </thead>
                    <tbody id="admin-coupon-table" class="divide-y divide-slate-50"></tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<!-- View: Offers -->
<section id="view-offers" class="view-section container mx-auto px-6 py-12">
    <div class="text-center mb-16">
        <h1 class="text-5xl font-display font-bold text-secondary mb-4">Exclusive Offers</h1>
        <p class="text-slate-500 text-lg">Grab the best deals and save big on your next journey!</p>
    </div>
    <div id="offers-grid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <!-- Dynamic Coupons -->
    </div>
</section>

<!-- View: Help -->
<section id="view-help" class="view-section container mx-auto px-6 py-12">
    <div class="max-w-4xl mx-auto">
        <div class="text-center mb-16">
            <h1 class="text-5xl font-display font-bold text-secondary mb-4">How can we help?</h1>
            <p class="text-slate-500 text-lg">Everything you need to know about SwiftRide.</p>
        </div>
        
        <div class="space-y-6">
            <div class="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm">
                <h3 class="text-xl font-bold text-secondary mb-4">How do I cancel my ticket?</h3>
                <p class="text-slate-600">You can cancel your ticket directly from your dashboard. Go to 'My Recent Bookings' and click the 'Cancel' button on the ticket card. Please note that a 10% cancellation fee may apply.</p>
            </div>
            <div class="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm">
                <h3 class="text-xl font-bold text-secondary mb-4">What should I do if I missed my bus?</h3>
                <p class="text-slate-600">If you miss your bus, please contact our support team immediately at support@swiftride.com or call our 24/7 hotline at +91 1800 123 456.</p>
            </div>
            <div class="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm">
                <h3 class="text-xl font-bold text-secondary mb-4">How can I book a bulk ticket for a group?</h3>
                <p class="text-slate-600">For group bookings (more than 6 seats), please use our 'Corporate' portal or contact our sales team during business hours.</p>
            </div>
            <div class="bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm">
                <h3 class="text-xl font-bold text-secondary mb-4">Are there any discounts for senior citizens?</h3>
                <p class="text-slate-600">Yes! We offer a 15% discount for senior citizens on selected routes. Please use the code SENIOR15 during checkout and keep a valid ID handy during travel.</p>
            </div>
        </div>
        
        <div class="mt-16 bg-primary-500 p-12 rounded-[3rem] text-center text-white relative overflow-hidden">
            <div class="relative z-10">
                <h2 class="text-3xl font-display font-bold mb-4">Still have questions?</h2>
                <p class="opacity-90 mb-8 max-w-lg mx-auto">Our support team is always here to assist you with any inquiries or issues you may have.</p>
                <button class="px-10 py-4 bg-white text-primary-500 font-bold rounded-2xl shadow-xl hover:-translate-y-1 transition-all">Contact Us Now</button>
            </div>
            <i class="fas fa-headset absolute -right-10 -bottom-10 text-[15rem] opacity-10"></i>
        </div>
    </div>
</section>

<!-- Modals: Login / Register -->
<div id="modal-auth" class="fixed inset-0 z-[100] hidden items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm">
    <div class="bg-white w-full max-w-md rounded-[2.5rem] shadow-2xl relative overflow-hidden">
        <button onclick="closeModal('modal-auth')" class="absolute top-6 right-8 text-2xl text-slate-300 hover:text-slate-600 transition-colors">
            <i class="fas fa-times"></i>
        </button>
        
        <div class="p-10">
            <div class="mb-10">
                <h2 id="auth-title" class="text-3xl font-display font-bold text-secondary mb-2">Welcome Back</h2>
                <p id="auth-subtitle" class="text-slate-500">Sign in to your SwiftRide account</p>
            </div>
            
            <form id="auth-form" onsubmit="handleAuthSubmit(event)" class="space-y-5">
                <div id="reg-fields" class="hidden space-y-5">
                    <div class="space-y-4">
                        <input type="text" id="auth-name" placeholder="Full Name" class="w-full px-5 py-4 bg-slate-50 dark:bg-slate-900 border-transparent rounded-2xl focus:bg-white focus:ring-2 focus:ring-primary-500 outline-none transition-all font-medium">
                        <input type="text" id="auth-phone" placeholder="Phone Number" class="w-full px-5 py-4 bg-slate-50 dark:bg-slate-900 border-transparent rounded-2xl focus:bg-white focus:ring-2 focus:ring-primary-500 outline-none transition-all font-medium">
                        <input type="text" id="auth-ref" placeholder="Referral Code (Optional)" class="w-full px-5 py-4 bg-slate-50 dark:bg-slate-900 border-transparent rounded-2xl focus:bg-white focus:ring-2 focus:ring-primary-500 outline-none transition-all font-medium">
                    </div>
                </div>
                <div>
                    <label class="block text-xs font-bold uppercase tracking-widest text-slate-400 mb-2 ml-1">Email Address</label>
                    <input type="email" id="auth-email" required placeholder="alex@example.com" class="w-full px-5 py-4 rounded-2xl bg-slate-50 border-transparent focus:bg-white focus:ring-2 focus:ring-primary-500 outline-none transition-all">
                </div>
                <div id="auth-password-container">
                    <div class="flex items-center justify-between mb-2">
                        <label class="block text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Password</label>
                        <button type="button" onclick="toggleForgotMode()" id="forgot-password-link" class="text-[10px] font-bold text-primary-500 uppercase hover:underline">Forgot?</button>
                    </div>
                    <input type="password" id="auth-password" required placeholder="••••••••" class="w-full px-5 py-4 rounded-2xl bg-slate-50 border-transparent focus:bg-white focus:ring-2 focus:ring-primary-500 outline-none transition-all">
                </div>
                
                <div id="otp-fields" class="hidden space-y-5">
                    <div class="bg-primary-50 p-4 rounded-2xl border border-primary-100 flex items-center gap-4 mb-2">
                        <div class="w-10 h-10 bg-primary-500 text-white rounded-xl flex items-center justify-center animate-pulse"><i class="fas fa-shield-alt"></i></div>
                        <div>
                            <p class="text-[10px] font-bold text-primary-500 uppercase tracking-widest">Verification Required</p>
                            <p id="otp-display" class="text-sm font-bold text-slate-700">Waiting for code...</p>
                        </div>
                    </div>
                    <div>
                        <label class="block text-xs font-bold uppercase tracking-widest text-slate-400 mb-2 ml-1">Enter OTP Code</label>
                        <input type="text" id="auth-otp" placeholder="1234" maxlength="4" class="w-full px-5 py-4 rounded-2xl bg-slate-50 border-transparent focus:bg-white focus:ring-2 focus:ring-primary-500 outline-none transition-all text-center text-2xl tracking-[1em] font-display font-bold">
                    </div>
                    <div class="text-center pt-2">
                        <p class="text-[10px] text-slate-400 font-bold uppercase tracking-widest">Didn't receive the code?</p>
                        <button type="button" onclick="resendOTP()" class="text-xs font-bold text-primary-500 hover:underline mt-1">Resend OTP Code</button>
                    </div>
                </div>
                
                <button type="submit" id="auth-btn" class="w-full py-5 bg-primary-500 text-white font-bold rounded-2xl shadow-lg shadow-primary-500/30 hover:bg-primary-600 transition-all active:scale-95">
                    SIGN IN
                </button>
            </form>
            
            <div class="mt-8 text-center text-sm text-slate-500">
                <span id="auth-toggle-text">Don't have an account?</span>
                <button onclick="toggleAuthMode()" id="auth-toggle-btn" class="font-bold text-primary-500 ml-1 hover:underline">Create One</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal: Digital Boarding Pass -->
<div id="modal-boarding-pass" class="fixed inset-0 z-[150] hidden items-center justify-center p-6 backdrop-blur-md bg-secondary/40">
    <div class="bg-white rounded-[3rem] shadow-2xl max-w-lg w-full overflow-hidden animate-bounce-in relative">
        <div class="absolute top-8 right-8 z-20">
            <button onclick="closeModal('modal-boarding-pass')" class="w-10 h-10 bg-slate-100 hover:bg-slate-200 rounded-full flex items-center justify-center transition-all"><i class="fas fa-times text-slate-500"></i></button>
        </div>
        <div class="p-8 bg-primary-500 text-white relative overflow-hidden">
            <div class="absolute -top-16 -right-16 w-40 h-40 bg-white/10 rounded-full"></div>
            <div class="relative z-10 text-center">
                <div class="text-xs uppercase tracking-[0.3em] opacity-70 mb-1">SwiftRide Platinum Express</div>
                <h2 class="text-3xl font-display font-bold">Boarding Pass</h2>
            </div>
        </div>
        <div class="px-10 py-4 bg-primary-500/5 border-b border-dashed border-primary-100">
            <div class="flex justify-between items-center">
                <div class="text-center">
                    <div class="text-4xl font-display font-bold text-secondary" id="pass-from">-</div>
                    <div class="text-[9px] text-slate-400 font-bold uppercase tracking-widest mt-1">Origin</div>
                </div>
                <div class="flex-1 flex items-center justify-center gap-1 px-4">
                    <div class="flex-1 border-b-2 border-dashed border-slate-200"></div>
                    <div class="w-8 h-8 bg-primary-500 rounded-full flex items-center justify-center text-white text-xs"><i class="fas fa-bus"></i></div>
                    <div class="flex-1 border-b-2 border-dashed border-slate-200"></div>
                </div>
                <div class="text-center">
                    <div class="text-4xl font-display font-bold text-secondary" id="pass-to">-</div>
                    <div class="text-[9px] text-slate-400 font-bold uppercase tracking-widest mt-1">Destination</div>
                </div>
            </div>
        </div>
        <div class="p-10 space-y-6">
            <div class="grid grid-cols-2 gap-x-8 gap-y-5">
                <div>
                    <div class="text-[9px] font-bold text-slate-400 uppercase tracking-widest mb-1">Passenger Name</div>
                    <div class="font-bold text-slate-800" id="pass-name">-</div>
                </div>
                <div>
                    <div class="text-[9px] font-bold text-slate-400 uppercase tracking-widest mb-1">PNR Number</div>
                    <div class="font-bold text-primary-500 font-mono tracking-wider" id="pass-pnr">-</div>
                </div>
                <div>
                    <div class="text-[9px] font-bold text-slate-400 uppercase tracking-widest mb-1">Seat(s)</div>
                    <div class="font-bold text-slate-800" id="pass-seats">-</div>
                </div>
                <div>
                    <div class="text-[9px] font-bold text-slate-400 uppercase tracking-widest mb-1">Travel Date</div>
                    <div class="font-bold text-slate-800" id="pass-date">-</div>
                </div>
                <div class="col-span-2">
                    <div class="text-[9px] font-bold text-slate-400 uppercase tracking-widest mb-1">Bus Service</div>
                    <div class="font-bold text-slate-800" id="pass-bus">-</div>
                </div>
            </div>
            <div class="flex justify-center py-4 border-t border-dashed border-slate-200">
                <!-- Simulated QR Code -->
                <div class="w-24 h-24 bg-slate-100 rounded-2xl flex items-center justify-center">
                    <i class="fas fa-qrcode text-5xl text-slate-300"></i>
                </div>
            </div>
            <button onclick="window.print()" class="w-full py-5 bg-secondary text-white font-bold rounded-2xl shadow-lg shadow-secondary/20 hover:bg-slate-800 transition-all active:scale-95">
                <i class="fas fa-download mr-2"></i>DOWNLOAD / PRINT PASS
            </button>
        </div>
    </div>
</div>

<!-- Global System Modal (Replaces Alerts/Prompts/Confirms) -->
<div id="modal-system" class="fixed inset-0 z-[500] hidden items-center justify-center p-6 backdrop-blur-md bg-secondary/60">
    <div class="bg-white rounded-3xl shadow-2xl max-w-sm w-full overflow-hidden animate-bounce-in">
        <div class="p-8 text-center relative">
            <div id="sys-icon-container" class="w-16 h-16 mx-auto rounded-2xl flex items-center justify-center text-2xl mb-6 bg-primary-50 text-primary-500">
                <i id="sys-icon" class="fas fa-info-circle"></i>
            </div>
            <h3 id="sys-title" class="text-xl font-display font-bold text-secondary mb-2">Message</h3>
            <p id="sys-msg" class="text-slate-500 text-sm mb-6 leading-relaxed">System message here.</p>
            
            <div id="sys-input-container" class="hidden mb-6">
                <input type="text" id="sys-input" class="w-full px-5 py-4 rounded-xl bg-slate-50 border border-slate-200 focus:bg-white focus:ring-2 focus:ring-primary-500 outline-none transition-all text-center font-medium" placeholder="...">
            </div>

            <div id="sys-form-container" class="hidden mb-6 space-y-3">
                <!-- Multi-inputs will be injected here -->
            </div>
            
            <div class="flex gap-3 justify-center">
                <button id="sys-btn-cancel" class="hidden flex-1 py-3 bg-slate-100 hover:bg-slate-200 text-slate-600 font-bold rounded-xl transition-colors">Cancel</button>
                <button id="sys-btn-confirm" class="flex-1 py-3 bg-primary-500 hover:bg-primary-600 text-white font-bold rounded-xl shadow-lg shadow-primary-500/30 transition-all active:scale-95">OK</button>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script>
    // --- Mock Database Engine ---
    const DB_KEY = 'swiftride_db';
    // --- Global State ---
    let searchResults = [];

    const INDIAN_CITIES = [
        'Mumbai', 'Delhi', 'Bangalore', 'Hyderabad', 'Ahmedabad', 'Chennai', 'Kolkata', 'Surat', 
        'Pune', 'Jaipur', 'Lucknow', 'Kanpur', 'Nagpur', 'Indore', 'Thane', 'Bhopal', 'Visakhapatnam'
    ];

    const CITY_LOGISTICS = {
        'Mumbai-Pune': { duration: '3h 30m', kms: 150 },
        'Pune-Mumbai': { duration: '3h 30m', kms: 150 },
        'Delhi-Jaipur': { duration: '5h 15m', kms: 280 },
        'Jaipur-Delhi': { duration: '5h 15m', kms: 280 },
        'Bangalore-Hyderabad': { duration: '9h 45m', kms: 570 },
        'Hyderabad-Bangalore': { duration: '9h 45m', kms: 570 },
        'Mumbai-Nagpur': { duration: '14h 00m', kms: 810 },
        'Nagpur-Mumbai': { duration: '14h 00m', kms: 810 },
        'Chennai-Bangalore': { duration: '6h 30m', kms: 350 },
        'Bangalore-Chennai': { duration: '6h 30m', kms: 350 },
        'DEFAULT': { duration: '8h 00m', kms: 450 }
    };

    function initDB() {
        if (!localStorage.getItem(DB_KEY)) {
            const initialData = {
                users: [
                    { id: 1, name: 'Swift Admin', email: 'admin@swiftride.com', password: 'admin', role: 'ADMIN', phone: '9876543210', wallet: 5000, swiftCash: 0, referralCode: 'SR-ADMIN', verified: true },
                    { id: 2, name: 'John Doe', email: 'john@example.com', password: 'password', role: 'USER', phone: '9988776655', wallet: 1200, swiftCash: 50, referralCode: 'JD-9988', verified: true }
                ],
                analytics: {
                    dailyRevenue: [1200, 4500, 3200, 8900, 5600, 11000, 7800],
                    dailyBookings: [2, 7, 4, 12, 9, 15, 10]
                },
                buses: [], // Will be generated dynamically on first search if empty
                bookings: [
                    { id: 'TXN-9901', userId: 2, busId: 101, busName: 'Mumbai Express #402', from: 'Mumbai', to: 'Pune', seats: ['1A', '3B'], amount: 1700, status: 'CONFIRMED', date: '2024-05-10', pnr: 'SR99201' }
                ],
                coupons: [
                    { code: 'SWIFT2026', discount: 25, minAmount: 1000, expiry: '2026-12-31', desc: 'Flat 25% OFF on all bookings through 2026!' },
                    { code: 'WELCOMESR', discount: 50, minAmount: 500, expiry: '2026-12-31', desc: 'Welcome Offer: 50% discount on your first journey.' },
                    { code: 'FESTIVE30', discount: 30, minAmount: 1500, expiry: '2026-12-31', desc: 'Festive Season Special: Get 30% OFF on group travels.' },
                    { code: 'WINTERFUN', discount: 15, minAmount: 800, expiry: '2026-12-31', desc: '15% Discount on Winter travel bookings.' },
                    { code: 'EARLYBIRD', discount: 20, minAmount: 1200, expiry: '2026-12-31', desc: 'Book early and save 20% on all AC Sleepers!' }
                ]
            };
            
            // Seed defaults with isVerified
            initialData.users = initialData.users.map(u => ({ ...u, isVerified: true, wallet: u.wallet || 0, swiftCash: u.swiftCash || 0, referralCode: u.referralCode || `SR-${Math.random().toString(36).substring(2, 7).toUpperCase()}` }));
            
            // Seed some random buses
            const types = ['AC Seater', 'Non-AC Seater'];
            const allAmenities = ['WiFi', 'Charging Point', 'Water Bottle', 'Blanket', 'Pillow', 'Emergency Exit'];
            
            for(let i=0; i<30; i++) {
                const city1 = INDIAN_CITIES[Math.floor(Math.random() * INDIAN_CITIES.length)];
                let city2 = INDIAN_CITIES[Math.floor(Math.random() * INDIAN_CITIES.length)];
                while(city1 === city2) city2 = INDIAN_CITIES[Math.floor(Math.random() * INDIAN_CITIES.length)];
                
                const routeKey1 = `${city1}-${city2}`;
                const routeKey2 = `${city2}-${city1}`;
                const logistics = CITY_LOGISTICS[routeKey1] || CITY_LOGISTICS[routeKey2] || CITY_LOGISTICS['DEFAULT'];
                
                const busType = types[i % types.length];
                let typeMultiplier = 1.0;
                if (busType === 'AC Seater') typeMultiplier = 1.4;
                if (busType === 'Non-AC Seater') typeMultiplier = 1.1;
                
                // Assign random amenities
                const busAmenities = allAmenities.filter(() => Math.random() > 0.4);
                const amenityBonus = busAmenities.length * 25;
                const randomVariance = Math.floor(Math.random() * 101) - 50; // -50 to +50
                
                const basePrice = Math.floor((logistics.kms * 2.5) * typeMultiplier) + amenityBonus + randomVariance;
                
                initialData.buses.push({
                    id: 1000 + i,
                    name: `Fleet ${String.fromCharCode(65 + (i%26))}-${100 + i}`,
                    type: busType,
                    from: city1,
                    to: city2,
                    kms: logistics.kms,
                    price: basePrice,
                    amenities: busAmenities,
                    rating: (4 + Math.random()).toFixed(1),
                    ratingCount: 10 + Math.floor(Math.random() * 200),
                    departure: `${Math.floor(Math.random() * 12) + 1}:00 ${Math.random() > 0.5 ? 'AM' : 'PM'}`,
                    duration: logistics.duration,
                    bookedSeats: Array.from({length: Math.floor(Math.random() * 10)}, () => Math.floor(Math.random() * 40) + 'A')
                });
            }
            
            localStorage.setItem(DB_KEY, JSON.stringify(initialData));
        } else {
            // Migration/Re-seed check: If buses exist but lack amenities or are empty, re-seed them
            const db = getDB();
            if (!db.buses || db.buses.length < 5 || (db.buses.length > 0 && !db.buses[0].amenities)) {
                console.log("Migrating/Re-seeding buses for improved fare logic...");
                db.buses = []; // Clear old buses to avoid duplicates with old pricing
                const types = ['AC Seater', 'Non-AC Seater'];
                const allAmenities = ['WiFi', 'Charging Point', 'Water Bottle', 'Blanket', 'Pillow', 'Emergency Exit'];
                
                for(let i=0; i<30; i++) {
                    const city1 = INDIAN_CITIES[Math.floor(Math.random() * INDIAN_CITIES.length)];
                    let city2 = INDIAN_CITIES[Math.floor(Math.random() * INDIAN_CITIES.length)];
                    while(city1 === city2) city2 = INDIAN_CITIES[Math.floor(Math.random() * INDIAN_CITIES.length)];
                    
                    const routeKey1 = `${city1}-${city2}`;
                    const routeKey2 = `${city2}-${city1}`;
                    const logistics = CITY_LOGISTICS[routeKey1] || CITY_LOGISTICS[routeKey2] || CITY_LOGISTICS['DEFAULT'];
                    
                    const busType = types[i % types.length];
                    let typeMultiplier = 1.0;
                    if (busType === 'AC Seater') typeMultiplier = 1.4;
                    if (busType === 'Non-AC Seater') typeMultiplier = 1.1;
                    
                    const busAmenities = allAmenities.filter(() => Math.random() > 0.4);
                    const amenityBonus = busAmenities.length * 25;
                    const randomVariance = Math.floor(Math.random() * 101) - 50;
                    const basePrice = Math.floor((logistics.kms * 2.5) * typeMultiplier) + amenityBonus + randomVariance;
                    
                    db.buses.push({
                        id: 1000 + i,
                        name: `Fleet ${String.fromCharCode(65 + (i%26))}-${100 + i}`,
                        type: busType,
                        from: city1,
                        to: city2,
                        kms: logistics.kms,
                        price: basePrice,
                        amenities: busAmenities,
                        rating: (4 + Math.random()).toFixed(1),
                        ratingCount: 10 + Math.floor(Math.random() * 200),
                        departure: `${Math.floor(Math.random() * 12) + 1}:00 ${Math.random() > 0.5 ? 'AM' : 'PM'}`,
                        duration: logistics.duration,
                        bookedSeats: []
                    });
                }
                saveDB(db);
            }
        }
    }

    function getDB() { return JSON.parse(localStorage.getItem(DB_KEY)); }
    function saveDB(data) { localStorage.setItem(DB_KEY, JSON.stringify(data)); }

    // --- Theme Management ---
    function initTheme() {
        const theme = localStorage.getItem('swiftride_theme') || 'light';
        if (theme === 'dark') {
            document.documentElement.classList.add('dark');
            document.getElementById('theme-icon').classList.replace('fa-moon', 'fa-sun');
        }
    }

    function toggleTheme() {
        const isDark = document.documentElement.classList.toggle('dark');
        localStorage.setItem('swiftride_theme', isDark ? 'dark' : 'light');
        const icon = document.getElementById('theme-icon');
        if (isDark) icon.classList.replace('fa-moon', 'fa-sun');
        else icon.classList.replace('fa-sun', 'fa-moon');
    }

    function showNotification(title, msg, type = 'success') {
        const toast = document.createElement('div');
        toast.className = `fixed top-24 right-6 z-[200] p-6 rounded-3xl shadow-premium border flex items-center gap-4 animate-bounce-in glass-effect ${type === 'success' ? 'border-emerald-100 text-emerald-600' : 'border-primary-100 text-primary-500'}`;
        toast.innerHTML = `
            <div class="w-10 h-10 rounded-full bg-current bg-opacity-10 flex items-center justify-center">
                <i class="fas ${type === 'success' ? 'fa-check-circle' : 'fa-info-circle'}"></i>
            </div>
            <div>
                <h4 class="font-bold text-sm">${title}</h4>
                <p class="text-[10px] opacity-80">${msg}</p>
            </div>
        `;
        document.body.appendChild(toast);
        setTimeout(() => toast.remove(), 4000);
    }

    // --- State Management ---
    let currentUser = JSON.parse(localStorage.getItem('swiftride_session')) || null;
    let selectedBus = null;
    let tempSelectedSeats = [];
    let isRegisterMode = false;
    let isForgotMode = false;
    let generatedOTP = null;
    let tempUser = null;
    let appliedCoupon = null;

    // --- Custom System Modal (Replaces Native Popups) ---
    function showSystemModal({ title = 'Message', msg = '', type = 'info', hasInput = false, showCancel = false, inputs = [], initialValue = '' }) {
        return new Promise((resolve) => {
            const modal = document.getElementById('modal-system');
            const iconContainer = document.getElementById('sys-icon-container');
            const icon = document.getElementById('sys-icon');
            const titleEl = document.getElementById('sys-title');
            const msgEl = document.getElementById('sys-msg');
            const inputContainer = document.getElementById('sys-input-container');
            const inputEl = document.getElementById('sys-input');
            const formContainer = document.getElementById('sys-form-container');
            const btnCancel = document.getElementById('sys-btn-cancel');
            const btnConfirm = document.getElementById('sys-btn-confirm');
            
            // Reset styles
            iconContainer.className = 'w-16 h-16 mx-auto rounded-2xl flex items-center justify-center text-2xl mb-6';
            inputEl.value = initialValue;
            formContainer.innerHTML = '';
            
            // Apply Type
            if (type === 'error') {
                iconContainer.classList.add('bg-red-50', 'text-red-500');
                icon.className = 'fas fa-exclamation-triangle';
                btnConfirm.className = 'flex-1 py-3 bg-red-500 hover:bg-red-600 text-white font-bold rounded-xl shadow-lg shadow-red-500/30 transition-all active:scale-95';
            } else if (type === 'success') {
                iconContainer.classList.add('bg-emerald-50', 'text-emerald-500');
                icon.className = 'fas fa-check-circle';
                btnConfirm.className = 'flex-1 py-3 bg-emerald-500 hover:bg-emerald-600 text-white font-bold rounded-xl shadow-lg shadow-emerald-500/30 transition-all active:scale-95';
            } else if (type === 'prompt' || type === 'confirm') {
                iconContainer.classList.add('bg-secondary', 'text-white');
                icon.className = 'fas fa-question-circle';
                btnConfirm.className = 'flex-1 py-3 bg-secondary hover:bg-slate-800 text-white font-bold rounded-xl shadow-lg shadow-secondary/30 transition-all active:scale-95';
            } else {
                iconContainer.classList.add('bg-primary-50', 'text-primary-500');
                icon.className = 'fas fa-info-circle';
                btnConfirm.className = 'flex-1 py-3 bg-primary-500 hover:bg-primary-600 text-white font-bold rounded-xl shadow-lg shadow-primary-500/30 transition-all active:scale-95';
            }
            
            titleEl.innerText = title;
            msgEl.innerText = msg;
            
            // Multi-Input Form rendering
            if (inputs.length > 0) {
                formContainer.classList.remove('hidden');
                inputContainer.classList.add('hidden');
                inputs.forEach(inp => {
                    const group = document.createElement('div');
                    group.className = 'text-left';
                    group.innerHTML = `
                        <label class="block text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1 ml-2">${inp.label}</label>
                        <input type="${inp.type || 'text'}" name="${inp.name}" class="w-full px-5 py-3 rounded-xl bg-slate-50 border border-slate-100 focus:bg-white focus:ring-2 focus:ring-primary-500 outline-none transition-all text-sm font-medium" placeholder="${inp.placeholder || ''}" value="${inp.value || ''}">
                    `;
                    formContainer.appendChild(group);
                });
            } else {
                formContainer.classList.add('hidden');
                inputContainer.classList.toggle('hidden', !hasInput);
            }
            
            btnCancel.classList.toggle('hidden', !showCancel);
            
            // Setup Listeners
            const cleanup = () => {
                modal.classList.add('hidden');
                modal.classList.remove('flex');
            };
            
            btnConfirm.onclick = () => {
                if (inputs.length > 0) {
                    const data = {};
                    let isValid = true;
                    formContainer.querySelectorAll('input').forEach(inp => {
                        if (!inp.value && inp.required !== false) isValid = false;
                        data[inp.name] = inp.value;
                    });
                    if (!isValid) return showNotification('Error', 'Please fill all fields', 'error');
                    cleanup();
                    resolve(data);
                } else {
                    cleanup();
                    resolve(hasInput ? (inputEl.value || null) : true);
                }
            };
            
            btnCancel.onclick = () => {
                cleanup();
                resolve(null);
            };
            
            // Show
            modal.classList.remove('hidden');
            modal.classList.add('flex');
            if (inputs.length > 0) {
                formContainer.querySelector('input').focus();
            } else if (hasInput) {
                inputEl.focus();
            }
        });
    }

    // Override Native Browser Functions
    window.alert = function(msg) {
        // We do not await here because native alert is synchronous in intent, but since we map to async UI, 
        // callers will just fire and forget. Many places in the code don't await alert(), this avoids hanging.
        const isErr = msg.toLowerCase().includes('incorrect') || msg.toLowerCase().includes('fail') || msg.toLowerCase().includes('invalid') || msg.toLowerCase().includes('exist') || msg.toLowerCase().includes('unverified');
        showSystemModal({ title: isErr ? 'Error' : 'Notification', msg: msg, type: isErr ? 'error' : 'info' });
    };

    window.prompt = async function(msg, defaultText = '') {
        // Note: For existing synchronous code, replacing prompt with async requires adjusting calls 
        // to async/await where possible.
        return await showSystemModal({ title: 'Input Required', msg: msg, type: 'prompt', hasInput: true, showCancel: true });
    };

    window.confirm = async function(msg) {
        return await showSystemModal({ title: 'Confirm Action', msg: msg, type: 'confirm', showCancel: true });
    };

    // --- View Router ---
    function showView(viewId) {
        document.querySelectorAll('.view-section').forEach(v => v.classList.remove('active'));
        document.getElementById(`view-${viewId}`).classList.add('active');
        window.scrollTo(0, 0);
        
        updateStepper(viewId);

        // Context specific loading
        if (viewId === 'dashboard') loadDashboard();
        if (viewId === 'admin') loadAdmin();
        if (viewId === 'offers') loadOffers();
    }

    function updateStepper(view) {
        const stepper = document.getElementById('booking-stepper');
        if (['hero', 'results', 'seats'].includes(view)) {
            stepper.classList.remove('hidden');
            stepper.classList.add('flex');
            
            const steps = ['hero', 'results', 'seats'];
            const labels = ['Search', 'Buses', 'Seats'];
            
            const currentIdx = steps.indexOf(view);
            
            stepper.innerHTML = labels.map((label, idx) => `
                <div class="flex items-center gap-3 ${idx <= currentIdx ? 'text-primary-500' : 'text-slate-300 dark:text-slate-700'}">
                    <div class="w-8 h-8 rounded-full border-2 ${idx <= currentIdx ? 'border-primary-500 bg-primary-50 dark:bg-primary-900/20' : 'border-slate-200 dark:border-slate-800'} flex items-center justify-center font-bold text-xs transition-all">
                        ${idx < currentIdx ? '<i class="fas fa-check"></i>' : idx + 1}
                    </div>
                    <span class="text-xs font-bold uppercase tracking-widest hidden sm:inline">${label}</span>
                    ${idx < labels.length - 1 ? '<div class="w-8 h-[2px] bg-slate-100 dark:bg-slate-800 mx-2"></div>' : ''}
                </div>
            `).join('');
        } else {
            stepper.classList.add('hidden');
        }
    }

    // --- Auth Logic ---
    function updateNav() {
        const container = document.getElementById('nav-auth-links');
        const userLinks = document.querySelectorAll('.nav-user-link');
        
        if (currentUser) {
            const isAdmin = currentUser.role === 'ADMIN';
            
            // Hide normal navigation links if Admin
            userLinks.forEach(link => link.classList.toggle('hidden', isAdmin));

            container.innerHTML = `
                <a href="#" onclick="showView('${isAdmin ? 'admin' : 'dashboard'}')" class="text-secondary dark:text-white hover:text-primary-500 font-bold">${currentUser.name.split(' ')[0]}</a>
                ${isAdmin ? '<a href="#" onclick="showView(\'admin\')" class="text-xs bg-slate-100 dark:bg-slate-800 px-3 py-1 rounded-full text-slate-500 dark:text-slate-400 font-bold">ADMIN</a>' : ''}
                <button onclick="handleLogout()" class="px-6 py-2 bg-slate-50 dark:bg-slate-800 border dark:border-slate-700 rounded-xl hover:bg-slate-100 dark:hover:bg-slate-700 transition-colors">Logout</button>
            `;
        } else {
            container.innerHTML = `
                <button onclick="openModal('modal-auth')" class="hover:text-primary-500 transition-colors">Sign In</button>
                <button onclick="openModal('modal-auth', true)" class="px-8 py-3 bg-primary-500 text-white rounded-2xl shadow-lg shadow-primary-500/20 hover:bg-primary-600">Register</button>
            `;
        }
    }

    function openModal(id, reg = false) {
        document.getElementById(id).classList.remove('hidden');
        document.getElementById(id).classList.add('flex');
        if (id === 'modal-auth') {
            if (reg) {
                isRegisterMode = false; // reset
                toggleAuthMode();
            } else {
                isRegisterMode = true; // reset
                toggleAuthMode();
            }
        }
    }

    function closeModal(id) {
        document.getElementById(id).classList.add('hidden');
        document.getElementById(id).classList.remove('flex');
    }

    function toggleAuthMode() {
        isRegisterMode = !isRegisterMode;
        isForgotMode = false;
        document.getElementById('otp-fields').classList.add('hidden');
        
        // PRIVACY: Clear all fields when switching modes
        ['auth-email', 'auth-password', 'auth-name', 'auth-phone', 'auth-ref', 'auth-otp'].forEach(id => {
            const el = document.getElementById(id);
            if (el) el.value = '';
        });
        
        document.getElementById('reg-fields').classList.toggle('hidden', !isRegisterMode);
        document.getElementById('auth-email').closest('div').classList.remove('hidden');
        
        document.getElementById('auth-password-container').classList.remove('hidden');
        document.getElementById('auth-password').required = true;
        document.getElementById('forgot-password-link').classList.toggle('hidden', isRegisterMode);
        
        document.getElementById('auth-title').innerText = isRegisterMode ? 'Creating Account' : 'Welcome Back';
        document.getElementById('auth-subtitle').innerText = isRegisterMode ? 'Join SwiftRide for exclusive offers' : 'Sign in to your SwiftRide account';
        document.getElementById('auth-btn').innerText = isRegisterMode ? 'CREATE ACCOUNT' : 'SIGN IN';
        document.getElementById('auth-toggle-text').innerText = isRegisterMode ? 'Already have an account?' : "Don't have an account?";
        document.getElementById('auth-toggle-btn').innerText = isRegisterMode ? 'Sign In' : 'Create One';
        document.getElementById('auth-toggle-btn').onclick = toggleAuthMode;
    }

    function toggleForgotMode() {
        isForgotMode = true;
        isRegisterMode = false;
        generatedOTP = null;
        tempUser = null;
        
        document.getElementById('reg-fields').classList.add('hidden');
        document.getElementById('otp-fields').classList.add('hidden');
        
        // PRIVACY: Clear all fields
        ['auth-email', 'auth-password', 'auth-name', 'auth-phone', 'auth-ref', 'auth-otp'].forEach(id => {
            const el = document.getElementById(id);
            if (el) el.value = '';
        });

        document.getElementById('auth-email').closest('div').classList.remove('hidden');
        
        document.getElementById('auth-password-container').classList.add('hidden');
        document.getElementById('auth-password').required = false;
        
        document.getElementById('auth-title').innerText = 'Reset Password';
        document.getElementById('auth-subtitle').innerText = 'Enter your email to receive an OTP';
        document.getElementById('auth-btn').innerText = 'SEND OTP';
        
        document.getElementById('auth-toggle-text').innerText = 'Remember your password?';
        document.getElementById('auth-toggle-btn').innerText = 'Sign In';
        document.getElementById('auth-toggle-btn').onclick = () => { isRegisterMode = true; toggleAuthMode(); };
    }

    async function handleAuthSubmit(e) {
        e.preventDefault();
        const email = document.getElementById('auth-email').value;
        const pass = document.getElementById('auth-password').value;
        const db = getDB();

        if (isForgotMode) {
            if (generatedOTP) {
                const userOTP = document.getElementById('auth-otp').value;
                if (userOTP === generatedOTP) {
                    const newPass = await showSystemModal({ title: 'Set New Password', msg: 'Please enter a new secure password (min 4 characters):', hasInput: true, type: 'prompt' });
                    if (newPass && newPass.length >= 4) {
                         const user = db.users.find(u => u.email === tempUser.email);
                         user.password = newPass;
                         user.isVerified = true;
                         user.verified = true;
                         saveDB(db);
                         await showSystemModal({ title: 'Success', msg: 'Password reset successfully! Please sign in with your new credentials.', type: 'success' });
                         isRegisterMode = true; toggleAuthMode(); // switches back to generic Login
                    } else {
                         if (newPass !== null) await showSystemModal({ title: 'Error', msg: 'Invalid password length. Please try again.', type: 'error' });
                    }
                } else {
                    await showSystemModal({ title: 'Invalid OTP', msg: 'The OTP code you entered is incorrect.', type: 'error' });
                }
            } else {
                 const user = db.users.find(u => u.email === email);
                 if (!user) return await showSystemModal({ title: 'Account Not Found', msg: 'No account is registered with this email address.', type: 'error' });
                 tempUser = user;
                 generatedOTP = Math.floor(1000 + Math.random() * 9000).toString();
                 
                 // PRIVACY: Don't show it in the modal itself anymore
                 document.getElementById('otp-display').innerText = `Verification code sent to your email.`;
                 showNotification('OTP Sent', `Your verification code is: ${generatedOTP}`, 'info');
                 document.getElementById('otp-fields').classList.remove('hidden');
                 document.getElementById('auth-email').closest('div').classList.add('hidden');
                 document.getElementById('auth-password-container').classList.add('hidden');
                 
                 document.getElementById('auth-title').innerText = 'Verify Identity';
                 document.getElementById('auth-subtitle').innerText = `We've sent a code to ${email}`;
                 document.getElementById('auth-btn').innerText = 'VERIFY OTP';
            }
            return;
        }

        if (isRegisterMode) {
            // Step 2: Verify OTP
            if (generatedOTP) {
                const userOTP = document.getElementById('auth-otp').value;
                if (userOTP === generatedOTP) {
                    tempUser.isVerified = true;
                    
                    // Handle referral code
                    if (tempUser.referredBy) {
                        const referrer = db.users.find(u => u.referralCode === tempUser.referredBy);
                        if (referrer) {
                            referrer.swiftCash = (referrer.swiftCash || 0) + 100; // Referrer gets 100 SwiftCash
                            tempUser.swiftCash = (tempUser.swiftCash || 0) + 50; // Referee gets 50 SwiftCash
                            showNotification('Referral Bonus!', `You and ${referrer.name} received SwiftCash!`, 'success');
                        }
                    }

                    db.users.push(tempUser);
                    saveDB(db);
                    currentUser = tempUser;
                    await showSystemModal({ title: 'Welcome!', msg: 'Registration Successful! Welcome to SwiftRide.', type: 'success' });
                    finalizeAuth();
                } else {
                    await showSystemModal({ title: 'Invalid OTP', msg: 'The code you entered is incorrect.', type: 'error' });
                }
                return;
            }

            // Step 1: Check existence and generate OTP
            const name = document.getElementById('auth-name').value;
            const phone = document.getElementById('auth-phone').value;
            const referralCode = document.getElementById('auth-ref').value.toUpperCase();
            
            const existingUser = db.users.find(u => u.email === email);
            if (existingUser) {
                if (existingUser.isVerified) {
                    await showSystemModal({ title: 'Account Exists', msg: 'An account with this email already exists and is verified. Please sign in.', type: 'info' });
                    isRegisterMode = true; // reset
                    toggleAuthMode(); // switches to login
                } else {
                    // Start unverified flow
                    startOTPFlow({ id: existingUser.id, name, email, password: pass, role: 'USER', phone, joined: existingUser.joined, referralCode: existingUser.referralCode, swiftCash: existingUser.swiftCash, wallet: existingUser.wallet, referredBy: referralCode });
                }
                return;
            }

            if(!name || !phone) return await showSystemModal({ title: 'Missing Info', msg: 'Please provide your full name and phone number to continue.', type: 'error' });
            
            startOTPFlow({ 
                id: Date.now(), 
                name, 
                email, 
                password: pass, 
                role: 'USER', 
                phone, 
                joined: new Date().toISOString().split('T')[0],
                wallet: 0,
                swiftCash: 0,
                referralCode: `SR-${Math.random().toString(36).substring(2, 7).toUpperCase()}`,
                referredBy: referralCode || null
            });
        } else {
            // Login Mode
            const user = db.users.find(u => u.email === email && u.password === pass);
            if (!user) {
                const emailExists = db.users.some(u => u.email === email);
                if (emailExists) return await showSystemModal({ title: 'Invalid Login', msg: 'Incorrect password for this email.', type: 'error' });
                return await showSystemModal({ title: 'Account Missing', msg: 'This account does not exist. Please register first.', type: 'error' });
            }
            if (!user.isVerified && !user.verified && user.role !== 'ADMIN') return await showSystemModal({ title: 'Unverified Account', msg: 'Your account is not verified. Please register again to verify.', type: 'error' });
            
            // Normalize legacy DB data for future use
            user.isVerified = true;
            currentUser = user;
            finalizeAuth();

        }
    }

    function startOTPFlow(userData) {
        tempUser = userData;
        generatedOTP = Math.floor(1000 + Math.random() * 9000).toString();
        
        // PRIVACY: Don't show it in the modal itself anymore
        document.getElementById('otp-display').innerText = `Verification code sent to your email.`;
        showNotification('OTP Sent', `Your verification code is: ${generatedOTP}`, 'info');
        
        document.getElementById('otp-fields').classList.remove('hidden');
        document.getElementById('reg-fields').classList.add('hidden');
        document.getElementById('auth-email').closest('div').classList.add('hidden');
        document.getElementById('auth-password-container').classList.add('hidden');
        document.getElementById('auth-password').required = false;
        document.getElementById('auth-title').innerText = 'Verify Email';
        document.getElementById('auth-subtitle').innerText = `We've sent a code to ${tempUser.email}`;
        document.getElementById('auth-btn').innerText = 'VERIFY & SIGN UP';
        document.getElementById('auth-otp').focus();
    }

    async function resendOTP() {
        if (!tempUser) return;
        generatedOTP = Math.floor(1000 + Math.random() * 9000).toString();
        document.getElementById('auth-otp').value = '';
        document.getElementById('auth-otp').focus();
        showNotification('OTP Resent', `A new verification code is: ${generatedOTP}`, 'success');
        document.getElementById('otp-display').innerText = `A new code has been sent to your email.`;
    }

    function finalizeAuth() {
        localStorage.setItem('swiftride_session', JSON.stringify(currentUser));
        closeModal('modal-auth');
        updateNav();
        // Reset modal state
        isRegisterMode = false;
        generatedOTP = null;
        tempUser = null;
        document.getElementById('otp-fields').classList.add('hidden');
        
        if (currentUser && currentUser.role === 'ADMIN') {
            showView('admin');
        } else {
            showView('dashboard');
        }
    }

    function handleLogout() {
        currentUser = null;
        localStorage.removeItem('swiftride_session');
        updateNav();
        document.querySelectorAll('.nav-user-link').forEach(link => link.classList.remove('hidden'));
        showView('hero');
    }

    // --- Autocomplete Logic ---
    function showSuggestions(type) {
        const input = document.getElementById(`search-${type}`);
        const list = document.getElementById(`suggestions-${type}`);
        const query = input.value.toLowerCase();
        
        if (!query) {
            list.classList.add('hidden');
            return;
        }

        const filtered = INDIAN_CITIES.filter(c => c.toLowerCase().includes(query)).slice(0, 5);
        if (filtered.length === 0) {
            list.classList.add('hidden');
            return;
        }

        list.innerHTML = filtered.map(c => `
            <div onclick="selectSuggestion('${type}', '${c}')" class="px-5 py-3 hover:bg-slate-50 cursor-pointer text-sm font-medium text-slate-700 transition-colors">
                <i class="fas fa-city mr-3 text-slate-300"></i> ${c}
            </div>
        `).join('');
        list.classList.remove('hidden');
    }

    function selectSuggestion(type, value) {
        document.getElementById(`search-${type}`).value = value;
        document.getElementById(`suggestions-${type}`).classList.add('hidden');
    }

    // Hide suggestions when clicking outside
    document.addEventListener('click', (e) => {
        if (!e.target.closest('#search-from') && !e.target.closest('#suggestions-from')) {
            document.getElementById('suggestions-from').classList.add('hidden');
        }
        if (!e.target.closest('#search-to') && !e.target.closest('#suggestions-to')) {
            document.getElementById('suggestions-to').classList.add('hidden');
        }
    });

    // --- Search Logic ---
    function handleSearch() {
        const from = document.getElementById('search-from').value;
        const to = document.getElementById('search-to').value;
        const date = document.getElementById('search-date').value;
        
        if (!from || !to || !date) return alert('Please fill all search fields');
        if (from === to) return alert('Source and Destination cannot be same');

        const db = getDB();
        const routeKey = `${from}-${to}`;
        const logistics = CITY_LOGISTICS[routeKey] || CITY_LOGISTICS['DEFAULT'];
        
        // Filter existing buses for this route
        let results = db.buses.filter(b => 
            b.from.toLowerCase() === from.toLowerCase() && 
            b.to.toLowerCase() === to.toLowerCase()
        );

        if (results.length === 0) {
            const types = ['AC Seater', 'Non-AC Seater'];
            for(let i=0; i<10; i++) {
                const depH = 5 + (i * 2); 
                const depTime = `${depH > 12 ? depH - 12 : depH}:00 ${depH >= 12 ? 'PM' : 'AM'}`;
                
                const busType = types[i % 2];
                const allAmenities = ['WiFi', 'Charging Point', 'Water Bottle', 'Blanket', 'Pillow'];
                
                // Multi-Factor Pricing Logic
                let typeMultiplier = 1.0;
                if (busType === 'AC Seater') typeMultiplier = 1.45;
                if (busType === 'Non-AC Seater') typeMultiplier = 1.15;
                
                const busAmenities = allAmenities.filter(() => Math.random() > 0.5);
                const amenityBonus = busAmenities.length * 30;
                const randomVariance = Math.floor(Math.random() * 121) - 60; // -60 to +60
                
                const finalPrice = Math.floor((logistics.kms * 2.8) * typeMultiplier) + amenityBonus + randomVariance;
                
                const newBus = {
                    id: Date.now() + i,
                    name: `Swift ${String.fromCharCode(65 + (i % 26))}-${100 + i}`,
                    type: busType,
                    from: from,
                    to: to,
                    kms: logistics.kms,
                    price: finalPrice,
                    amenities: busAmenities,
                    rating: (3.5 + (Math.random() * 1.5)).toFixed(1),
                    ratingCount: Math.floor(Math.random() * 800) + 100,
                    departure: depTime,
                    departureDate: date,
                    duration: logistics.duration,
                    bookedSeats: Array.from({length: Math.floor(Math.random() * 5)}, () => (Math.floor(Math.random() * 40) + 1) + String.fromCharCode(65 + Math.floor(Math.random() * 2)))
                };
                results.push(newBus);
                db.buses.push(newBus); // PERSIST to DB
            }
            saveDB(db);
        }

        // Chronological Sort
        results.sort((a,b) => {
            const getH = (t) => {
                let [h, m] = t.split(' ')[0].split(':').map(Number);
                if (t.includes('PM') && h !== 12) h += 12;
                if (t.includes('AM') && h === 12) h = 0;
                return h * 60 + m;
            }
            return getH(a.departure) - getH(b.departure);
        });

        searchResults = results;
        handleSort(); // Initial sort based on current selection
        showView('results');
    }

    function handleSort() {
        const sortBy = document.getElementById('sort-by').value;
        let sorted = [...searchResults];

        if (sortBy === 'price-low') {
            sorted.sort((a, b) => a.price - b.price);
        } else if (sortBy === 'rating-high') {
            sorted.sort((a, b) => b.rating - a.rating);
        }

        renderBusResults(sorted);
    }

    function applyFilters() {
        const types = Array.from(document.querySelectorAll('input[name="f-type"]:checked')).map(i => i.value);
        const times = Array.from(document.querySelectorAll('input[name="f-time"]:checked')).map(i => i.value);
        const prices = Array.from(document.querySelectorAll('input[name="f-price"]:checked')).map(i => i.value);

        let filtered = searchResults.filter(bus => {
            // Type Filter
            if (types.length > 0) {
                if (!types.includes(bus.type)) return false;
            }

            // Time Filter
            if (times.length > 0) {
                const hour = parseInt(bus.departure.split(':')[0]) + (bus.departure.includes('PM') && !bus.departure.includes('12') ? 12 : 0);
                const period = (hour >= 6 && hour < 12) ? 'morning' : (hour >= 12 && hour < 18) ? 'afternoon' : 'evening';
                if (!times.includes(period)) return false;
            }

            // Price Filter
            if (prices.length > 0) {
                const match = prices.some(p => {
                    const [min, max] = p.split('-').map(Number);
                    return bus.price >= min && (max ? bus.price <= max : true);
                });
                if (!match) return false;
            }

            return true;
        });

        renderBusResults(filtered);
    }

    function clearFilters() {
        document.querySelectorAll('input[type="checkbox"][name^="f-"]').forEach(i => i.checked = false);
        renderBusResults(searchResults);
    }

    function renderBusResults(buses) {
        const container = document.getElementById('buses-container');
        document.getElementById('results-count').innerText = `${buses.length} Buses Found`;
        
        if (buses.length === 0) {
            container.innerHTML = `<div class="p-20 text-center glass-effect rounded-[3rem]"><i class="fas fa-bus text-6xl text-slate-200 mb-6"></i><p class="text-slate-500 font-medium">No buses found for this route. Try another search.</p></div>`;
            return;
        }

        container.innerHTML = buses.map(bus => {
            const arrival = calculateArrivalExtended(bus.departure, bus.duration, bus.departureDate);
            return `
            <div class="bg-white p-8 rounded-[2.5rem] shadow-sm border border-slate-100 hover:shadow-premium transition-all group">
                <div class="flex flex-col md:flex-row gap-8 items-center">
                    <div class="flex-1">
                        <div class="flex items-center gap-3 mb-4">
                            <span class="px-3 py-1 bg-primary-50 dark:bg-primary-900/20 text-primary-500 text-[10px] font-bold uppercase rounded-lg">${bus.kms} KM Journey</span>
                            ${(bus.bookedSeats.length / 40) > 0.5 ? `<span class="px-3 py-1 bg-amber-50 dark:bg-amber-900/20 text-amber-600 text-[10px] font-bold uppercase rounded-lg animate-pulse"><i class="fas fa-fire mr-1"></i>High Demand</span>` : ''}
                        </div>
                        <h3 class="text-2xl font-display font-bold text-secondary dark:text-white mb-2">${bus.name}</h3>
                        <div class="flex flex-wrap gap-2 mb-4">
                            ${(bus.amenities || []).map(a => `<span class="px-2 py-0.5 bg-slate-50 dark:bg-slate-800 text-slate-400 text-[9px] font-semibold rounded-md border border-slate-100 dark:border-slate-700 tracking-tight"><i class="fas fa-check-circle mr-1 text-emerald-500"></i>${a}</span>`).join('')}
                        </div>
                        <div class="flex items-center gap-6 text-slate-500 text-sm">
                            <span><i class="fas fa-wind mr-2"></i>${bus.type}</span>
                            <span><i class="fas fa-road mr-2"></i>${bus.kms} KMs</span>
                            <div class="flex items-center gap-1 text-amber-500 font-bold">
                                <i class="fas fa-star text-xs"></i>
                                <span>${bus.rating}</span>
                                <span class="text-slate-400 font-normal text-[10px] ml-1">(${bus.ratingCount} reviews)</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="flex flex-col md:flex-row items-center gap-10 md:border-l pl-10 border-slate-100">
                        <div class="text-center">
                            <div class="text-slate-400 text-[10px] font-bold uppercase tracking-widest mb-1">Departure</div>
                            <div class="text-xl font-display font-bold text-secondary">${bus.departure}</div>
                            <div class="text-[10px] text-slate-500 font-bold">${formatDateUI(bus.departureDate)}</div>
                        </div>
                        <div class="flex flex-col items-center gap-1">
                            <span class="text-[10px] font-bold text-slate-400">${bus.duration}</span>
                            <div class="flex items-center gap-1 opacity-20">
                                <i class="fas fa-circle text-[6px]"></i>
                                <div class="w-12 h-[1px] bg-secondary"></div>
                                <i class="fas fa-bus text-[10px]"></i>
                            </div>
                        </div>
                        <div class="text-center">
                            <div class="text-slate-400 text-[10px] font-bold uppercase tracking-widest mb-1">Arrival</div>
                            <div class="text-xl font-display font-bold text-secondary">${arrival.time}</div>
                            <div class="text-[10px] text-slate-500 font-bold">${arrival.date}</div>
                        </div>
                    </div>

                    <div class="text-center md:pl-10 md:border-l border-slate-100">
                        <div class="text-slate-400 text-[10px] font-bold uppercase tracking-widest mb-1">Per Ticket</div>
                        <div class="text-4xl font-display font-bold text-primary-500 mb-4">&#8377;${bus.price}</div>
                        <button onclick="selectBus(${bus.id})" class="px-8 py-3 bg-secondary text-white font-bold rounded-2xl hover:bg-primary-500 transition-all">Select Seats</button>
                    </div>
                </div>
            </div>
        `}).join('');
    }

    function formatDateUI(dateStr) {
        const d = new Date(dateStr);
        return d.toLocaleDateString('en-GB', { day: '2-digit', month: 'short' });
    }

    function calculateArrivalExtended(departure, duration, depDate) {
        const [time, period] = departure.split(' ');
        let [hours, minutes] = time.split(':').map(Number);
        if (period === 'PM' && hours !== 12) hours += 12;
        if (period === 'AM' && hours === 12) hours = 0;

        const [dHours, dMins] = duration.match(/\d+/g).map(Number);
        
        // Fix: parse YYYY-MM-DD as local time, not UTC
        const [yr, mo, day] = (depDate || new Date().toISOString().split('T')[0]).split('-').map(Number);
        let arrDate = new Date(yr, mo - 1, day, hours + dHours, minutes + (dMins || 0));
        
        return {
            time: arrDate.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: true }),
            date: arrDate.toLocaleDateString('en-GB', { day: '2-digit', month: 'short' })
        };
    }


    // --- Seat Selection Logic ---
    function selectBus(busId) {
        const db = getDB();
        selectedBus = db.buses.find(b => b.id == busId); // == for type coercion
        if (!selectedBus) {
            showNotification('Error', 'Bus not found. Please search again.', 'info');
            return;
        }
        tempSelectedSeats = [];
        appliedCoupon = null;
        
        document.getElementById('seat-bus-name').innerText = selectedBus.name;
        document.getElementById('seat-bus-info').innerText = `${selectedBus.type} | ${selectedBus.departureDate || 'Today'}`;
        
        const swiftCashVal = document.getElementById('available-swiftcash');
        if(swiftCashVal && currentUser) swiftCashVal.innerText = `₹${(currentUser.swiftCash || 0).toLocaleString()}`;

        renderSeats();
        updateSeatSummary();
        showView('seats');
    }

    function renderSeats() {
        const grid = document.getElementById('seats-grid');
        grid.innerHTML = '';
        const rows = 10;
        const labels = ['A', 'B', 'C', 'D'];

        for (let i = 1; i <= rows; i++) {
            const rowDiv = document.createElement('div');
            rowDiv.className = 'flex justify-between items-center px-4';
            
            const createPair = (sLabels) => {
                const pair = document.createElement('div');
                pair.className = 'flex gap-4';
                sLabels.forEach(l => {
                    const sid = i + l;
                    const isBooked = selectedBus.bookedSeats.includes(sid);
                    const isWomenSeat = (l === 'A' || l === 'D') && (i >= 8); // Example logic
                    
                    const btn = document.createElement('button');
                    btn.className = `seat w-12 h-12 rounded-xl border-2 flex items-center justify-center font-bold text-xs ${isBooked ? 'booked' : isWomenSeat ? 'border-pink-300 bg-pink-50 text-pink-600' : 'border-emerald-500 bg-emerald-50 text-emerald-700'}`;
                    btn.innerHTML = isWomenSeat && !isBooked ? `<i class="fas fa-venus text-[10px] absolute -top-1 -right-1"></i>${sid}` : sid;
                    btn.dataset.seatId = sid; // Store seat ID in dataset for reliable retrieval
                    btn.style.position = 'relative';
                    if (!isBooked) btn.onclick = () => {
                        if(isWomenSeat && currentUser && currentUser.role === 'USER') {
                            // In a real app we would check gender, here we just show a subtle note
                            showNotification('Specialized Seat', 'This seat is preferred for Female passengers.', 'info');
                        }
                        toggleSeat(sid);
                    };
                    pair.appendChild(btn);
                });
                return pair;
            };

            rowDiv.appendChild(createPair(['A', 'B']));
            rowDiv.appendChild(createPair(['C', 'D']));
            grid.appendChild(rowDiv);
        }
    }

    function toggleSeat(sid) {
        const idx = tempSelectedSeats.indexOf(sid);
        if (idx > -1) tempSelectedSeats.splice(idx, 1);
        else {
            if (tempSelectedSeats.length >= 6) return alert('Max 6 seats allowed');
            tempSelectedSeats.push(sid);
        }
        
        // Use dataset.seatId for reliable comparison (avoids innerText HTML issues)
        document.querySelectorAll('.seat').forEach(s => {
            if (s.dataset.seatId && tempSelectedSeats.includes(s.dataset.seatId)) s.classList.add('selected');
            else s.classList.remove('selected');
        });
        
        updateSeatSummary();
    }

    function updateSeatSummary() {
        document.getElementById('selected-seats-list').innerText = tempSelectedSeats.length > 0 ? tempSelectedSeats.join(', ') : 'None';
        const subtotal = tempSelectedSeats.length * selectedBus.price;
        let discountVal = 0;
        
        // Amenities
        let amenityTotal = 0;
        if(document.getElementById('amenity-insurance').checked) amenityTotal += 15 * tempSelectedSeats.length;
        if(document.getElementById('amenity-meal').checked) amenityTotal += 150 * tempSelectedSeats.length;

        if (appliedCoupon) {
            if (subtotal >= appliedCoupon.minAmount) {
                discountVal = Math.floor((subtotal * appliedCoupon.discount) / 100);
            } else {
                appliedCoupon = null;
                showNotification('Coupon Removed', 'Conditions not met.', 'info');
            }
        }

        let swiftCashDiscount = 0;
        if(document.getElementById('use-swiftcash').checked && currentUser) {
            swiftCashDiscount = Math.min(currentUser.swiftCash || 0, subtotal + amenityTotal - discountVal);
        }

        // Multi-Tier Seat Pricing Logic
        let tieredMarkup = 0;
        tempSelectedSeats.forEach(sid => {
            const row = parseInt(sid);
            const col = sid.slice(-1);
            if (row <= 2) tieredMarkup += 100; // Front Row Premium
            if (col === 'A' || col === 'D') tieredMarkup += 50; // Window Surcharge
        });

        const total = subtotal + tieredMarkup + amenityTotal - discountVal - swiftCashDiscount;
        
        // Update UI
        const discountRow = document.getElementById('discount-row');
        const discAmt = document.getElementById('discount-amount');
        
        let totalDisc = discountVal + swiftCashDiscount;

        if (totalDisc > 0) {
            discountRow.classList.remove('hidden');
            discountRow.classList.add('flex');
            discAmt.innerText = `-₹${totalDisc.toLocaleString()}.00`;
        } else {
            discountRow.classList.add('hidden');
        }

        document.getElementById('total-price').innerText = `₹${total.toLocaleString()}.00`;
        
        const btn = document.getElementById('proceed-btn');
        if (tempSelectedSeats.length > 0) {
            btn.disabled = false;
            btn.classList.replace('bg-slate-200', 'bg-primary-500');
            btn.classList.replace('text-slate-400', 'text-white');
        } else {
            btn.disabled = true;
            btn.classList.replace('bg-primary-500', 'bg-slate-200');
            btn.classList.replace('text-white', 'text-slate-400');
        }
    }

    function applyCoupon() {
        const input = document.getElementById('coupon-input').value.toUpperCase();
        if(!input) return;
        
        const db = getDB();
        const coupon = (db.coupons || []).find(cp => cp.code === input);
        const subtotal = tempSelectedSeats.length * selectedBus.price;

        if(!coupon) return alert('Invalid Coupon Code');
        if(new Date(coupon.expiry) < new Date()) return alert('Coupon has expired');
        if(subtotal < coupon.minAmount) return alert(`Minimum booking amount of ₹${coupon.minAmount} required to avail this offer.`);

        appliedCoupon = coupon;
        showNotification('Offer Applied!', `${coupon.discount}% discount has been added to your booking.`, 'success');
        updateSeatSummary();
    }

    function rateJourney(busId) {
        const rating = prompt('Rate your journey (1-5):');
        if(!rating || rating < 1 || rating > 5) return;
        
        const db = getDB();
        const bus = db.buses.find(b => b.id == busId);
        if(bus) {
            const currentRating = parseFloat(bus.rating);
            const count = parseInt(bus.ratingCount);
            bus.rating = ((currentRating * count + parseInt(rating)) / (count + 1)).toFixed(1);
            bus.ratingCount = count + 1;
            saveDB(db);
            showNotification('Thank You!', 'Your rating has been recorded.', 'success');
            loadDashboard();
        }
    }

    async function handleBookingProceed() {
        if (!currentUser) return openModal('modal-auth');
        
        const db = getDB();
        const subtotal = tempSelectedSeats.length * selectedBus.price;
        
        let amenityTotal = 0;
        const amenities = [];
        if(document.getElementById('amenity-insurance').checked) { amenityTotal += 15 * tempSelectedSeats.length; amenities.push('Insurance'); }
        if(document.getElementById('amenity-meal').checked) { amenityTotal += 150 * tempSelectedSeats.length; amenities.push('Meal'); }

        let discount = 0;
        if(appliedCoupon && subtotal >= appliedCoupon.minAmount) {
            discount = Math.floor((subtotal * appliedCoupon.discount) / 100);
        }

        let swiftCashUsed = 0;
        if(document.getElementById('use-swiftcash').checked && currentUser) {
            swiftCashUsed = Math.min(currentUser.swiftCash || 0, subtotal + amenityTotal - discount);
        }

        // Tiered Markup
        let tieredMarkup = 0;
        tempSelectedSeats.forEach(sid => {
            const row = parseInt(sid);
            const col = sid.slice(-1);
            if (row <= 2) tieredMarkup += 100;
            if (col === 'A' || col === 'D') tieredMarkup += 50;
        });

        const total = subtotal + tieredMarkup + amenityTotal - discount - swiftCashUsed;
        const payMethod = document.querySelector('input[name="pay-method"]:checked').value;

        let walletDeduction = 0;
        let cardUpiPayment = 0;

        if (payMethod === 'wallet') {
            if ((currentUser.wallet || 0) < total) {
                const balance = currentUser.wallet || 0;
                const remaining = total - balance;
                const useSplit = await showSystemModal({
                    title: 'Insufficient Balance',
                    msg: `Insufficient Wallet Balance (₹${balance}). Do you want to use the amount in wallet (₹${balance}) and pay the rest (₹${remaining}) from Card or UPI?`,
                    type: 'confirm',
                    showCancel: true
                });
                if (!useSplit) return;
                
                walletDeduction = balance;
                cardUpiPayment = remaining;
            } else {
                walletDeduction = total;
            }
        } else if (payMethod === 'card') {
            const confirmed = await showSystemModal({
                title: 'Confirm Payment',
                msg: `Proceed to pay ₹${total} via Card/UPI? (Simulated Payment)`,
                type: 'confirm',
                showCancel: true
            });
            if(!confirmed) return;
            cardUpiPayment = total;
        }

        const newBooking = {
            id: 'TXN-' + Math.floor(Math.random()*10000),
            userId: currentUser.id,
            busId: selectedBus.id,
            busName: selectedBus.name,
            from: selectedBus.from,
            to: selectedBus.to,
            seats: tempSelectedSeats,
            amount: total,
            walletPaid: walletDeduction,
            cardUpiPaid: cardUpiPayment,
            discount: discount + swiftCashUsed,
            coupon: appliedCoupon ? appliedCoupon.code : null,
            amenities: amenities,
            swiftCashUsed: swiftCashUsed,
            status: 'CONFIRMED',
            date: new Date().toISOString().split('T')[0],
            pnr: 'SR' + Math.floor(Math.random()*1000000)
        };
        
        db.bookings.push(newBooking);
        
        // Update User Balances
        const userInDb = db.users.find(u => u.id === currentUser.id);
        userInDb.wallet = Math.max(0, (userInDb.wallet || 0) - walletDeduction);
        userInDb.swiftCash = Math.max(0, (userInDb.swiftCash || 0) - swiftCashUsed);
        
        // Update Analytics (using total including card payment)
        if(!db.analytics) db.analytics = { dailyRevenue: [], dailyBookings: [] };
        if (db.analytics.dailyRevenue.length === 0) db.analytics.dailyRevenue.push(0);
        if (db.analytics.dailyBookings.length === 0) db.analytics.dailyBookings.push(0);
        
        db.analytics.dailyRevenue[db.analytics.dailyRevenue.length - 1] += total;
        db.analytics.dailyBookings[db.analytics.dailyBookings.length - 1] += 1;

        // Mark seats as booked in DB
        const bus = db.buses.find(b => b.id === selectedBus.id);
        if (bus) {
            bus.bookedSeats.push(...tempSelectedSeats);
        }
        
        saveDB(db);
        currentUser = userInDb; // Update session
        localStorage.setItem('swiftride_session', JSON.stringify(currentUser));
        
        await showSystemModal({
            title: 'Booking Successful!',
            msg: `Your PNR is: ${newBooking.pnr}. You can find your digital boarding pass in the dashboard.`,
            type: 'success'
        });
        
        showView('dashboard');
    }

    // --- Dashboard Logic ---
    function loadDashboard() {
        if (!currentUser) return showView('hero');
        document.getElementById('dash-user-name').innerText = currentUser.name;
        document.getElementById('dash-user-email').innerText = currentUser.email;
        document.getElementById('dash-user-avatar').src = `https://ui-avatars.com/api/?name=${encodeURIComponent(currentUser.name)}&background=d84e55&color=fff`;
        document.getElementById('dash-wallet').innerText = `₹${(currentUser.wallet || 0).toLocaleString()}`;
        document.getElementById('dash-ref-code').innerText = currentUser.referralCode || 'N/A';
        document.getElementById('dash-swiftcash-val').innerText = `₹${(currentUser.swiftCash || 0).toLocaleString()}.00`;
        
        const db = getDB();
        const userBookings = db.bookings.filter(b => b.userId === currentUser.id).reverse();
        const container = document.getElementById('bookings-history-grid');
        
        if (userBookings.length === 0) {
            container.innerHTML = `<div class="col-span-full py-20 text-center glass-effect rounded-[3rem] opacity-50"><p>No bookings found yet.</p></div>`;
            return;
        }

        container.innerHTML = userBookings.map(b => `
            <div class="bg-white p-6 rounded-3xl shadow-sm border border-slate-100 flex flex-col group hover:shadow-premium transition-all overflow-hidden relative">
                <div class="flex items-center justify-between mb-4">
                    <div>
                        <div class="text-[10px] font-bold text-primary-500 tracking-widest uppercase mb-1">PNR: ${b.pnr}</div>
                        <h4 class="text-xl font-display font-bold text-secondary">${b.from} <i class="fas fa-arrow-right text-xs mx-1 opacity-30"></i> ${b.to}</h4>
                    </div>
                    <div class="text-right">
                        <div class="text-xl font-display font-bold text-secondary">₹${b.amount}</div>
                        <span class="px-3 py-1 ${b.status === 'CANCELLED' ? 'bg-red-50 text-red-600' : 'bg-emerald-50 text-emerald-600'} text-[10px] font-bold rounded-lg uppercase">${b.status}</span>
                    </div>
                </div>
                <div class="flex items-center justify-between pt-4 border-t border-slate-50 text-slate-500 text-xs">
                    <span><i class="far fa-calendar-alt mr-2"></i>${new Date(b.date).toLocaleDateString()}</span>
                    <span><i class="fas fa-couch mr-2"></i>Seats: ${b.seats.join(', ')}</span>
                </div>
                <div class="flex gap-2 mt-4 pt-2">
                    ${b.status !== 'CANCELLED' ? `
                        <button onclick="showBoardingPass('${b.pnr}')" class="flex-1 py-3 bg-primary-50 text-primary-500 rounded-xl font-bold hover:bg-primary-100 transition-all text-[10px] uppercase">Boarding Pass</button>
                        <button onclick="handleUserCancel('${b.pnr}')" class="flex-1 py-3 bg-red-50 text-red-500 rounded-xl font-bold hover:bg-red-100 transition-all text-[10px] uppercase">Cancel</button>
                        <button onclick="rateJourney('${b.busId}')" class="px-4 py-3 bg-amber-50 text-amber-600 rounded-xl font-bold hover:bg-amber-100 transition-all text-[10px] uppercase"><i class="fas fa-star"></i></button>
                    ` : '<div class="w-full py-3 text-center text-slate-400 font-bold text-[10px] uppercase italic">Booking Cancelled</div>'}
                </div>
            </div>
        `).join('');
    }

    async function handleUserCancel(pnr) {
        const confirmed = await showSystemModal({
            title: 'Cancel Booking?',
            msg: 'Are you sure you want to cancel this booking? A 10% cancellation fee will apply.',
            type: 'confirm',
            showCancel: true
        });
        if(!confirmed) return;
        
        const db = getDB();
        const booking = db.bookings.find(b => b.pnr === pnr);
        if(!booking || booking.status === 'CANCELLED') return;

        // Release seats
        const bus = db.buses.find(b => b.id === booking.busId);
        if(bus) {
            bus.bookedSeats = bus.bookedSeats.filter(s => !booking.seats.includes(s));
        }

        // Process Refunds
        const refundAmount = Math.floor(booking.amount * 0.90); // 10% fee
        const user = db.users.find(u => u.id === booking.userId);
        if (user) {
            user.wallet = (user.wallet || 0) + refundAmount;
            if (booking.swiftCashUsed) {
                user.swiftCash = (user.swiftCash || 0) + booking.swiftCashUsed; 
            }
            if (currentUser && currentUser.id === user.id) {
                currentUser = user;
                localStorage.setItem('swiftride_session', JSON.stringify(currentUser));
            }
        }

        // Deduct from Admin Analytics (latest day)
        if (db.analytics && db.analytics.dailyRevenue.length > 0) {
            db.analytics.dailyRevenue[db.analytics.dailyRevenue.length - 1] = Math.max(0, db.analytics.dailyRevenue[db.analytics.dailyRevenue.length - 1] - booking.amount);
            db.analytics.dailyBookings[db.analytics.dailyBookings.length - 1] = Math.max(0, db.analytics.dailyBookings[db.analytics.dailyBookings.length - 1] - 1);
        }

        booking.status = 'CANCELLED';
        saveDB(db);
        await showSystemModal({
            title: 'Cancelled',
            msg: `Ticket Cancelled Successfully. ₹${refundAmount.toLocaleString()} has been refunded to your Wallet.`,
            type: 'success'
        });
        loadDashboard();
    }

    async function printTicket(pnr) {
        await showSystemModal({
            title: 'Digital Ticket',
            msg: `Generating Digital Ticket for PNR: ${pnr}...\nYour ticket will be sent to ${currentUser.email}`,
            type: 'info'
        });
    }

    async function openProfileEdit() {
        const result = await showSystemModal({
            title: 'Update Profile',
            msg: 'Modify your profile details below:',
            type: 'prompt',
            inputs: [
                { label: 'Full Name', name: 'name', value: currentUser.name, placeholder: 'Your name' },
                { label: 'Phone Number', name: 'phone', value: currentUser.phone || '', placeholder: 'Your phone' }
            ],
            showCancel: true
        });

        if(!result) return;
        const { name: newName, phone: newPhone } = result;
        
        const db = getDB();
        const user = db.users.find(u => u.id === currentUser.id);
        if(user) {
            user.name = newName;
            if(newPhone) user.phone = newPhone;
            currentUser.name = newName;
            if(newPhone) currentUser.phone = newPhone;
            saveDB(db);
            localStorage.setItem('swiftride_session', JSON.stringify(currentUser));
            updateNav();
            loadDashboard();
            await showSystemModal({ title: 'Success', msg: 'Profile Updated Successfully', type: 'success' });
        }
    }

    async function topUpWallet() {
        if (!currentUser) return openModal('modal-auth');
        const amount = await showSystemModal({ title: 'Wallet Top-up', msg: 'Enter amount to add to wallet (₹):', hasInput: true, type: 'prompt' });
        if (!amount || isNaN(amount) || amount <= 0) return await showSystemModal({ title: 'Invalid Amount', msg: 'Please enter a valid positive number.', type: 'error' });
        
        const db = getDB();
        const userInDb = db.users.find(u => u.id === currentUser.id);
        if (userInDb) {
            const addAmt = parseInt(amount);
            userInDb.wallet = (userInDb.wallet || 0) + addAmt;
            saveDB(db);
            currentUser = userInDb;
            localStorage.setItem('swiftride_session', JSON.stringify(currentUser));
            showNotification('Success', `₹${addAmt.toLocaleString()} added to your wallet!`, 'success');
            loadDashboard();
        }
    }

    // --- Admin CRUD Logic ---
    async function addBus() {
        const result = await showSystemModal({
            title: 'Add New Bus',
            msg: 'Enter details for the new bus service:',
            type: 'prompt',
            inputs: [
                { label: 'Bus Name', name: 'name', placeholder: 'e.g. Skyline #505' },
                { label: 'Source City', name: 'from', placeholder: 'e.g. Mumbai' },
                { label: 'Destination City', name: 'to', placeholder: 'e.g. Pune' },
                { label: 'Ticket Price (₹)', name: 'price', type: 'number', placeholder: 'e.g. 500' }
            ],
            showCancel: true
        });

        if(!result) return;
        const { name, from, to, price: priceInput } = result;
        const price = parseInt(priceInput);
        
        if(!name || !from || !to || isNaN(price) || price <= 0) return await showSystemModal({ title: 'Error', msg: 'Invalid inputs. Please check all fields.', type: 'error' });

        const db = getDB();
        db.buses.push({
            id: Date.now(),
            name,
            from,
            to,
            price,
            type: 'AC Seater',
            rating: '4.5',
            ratingCount: 1,
            departure: '10:00 AM',
            duration: '6h 00m',
            bookedSeats: []
        });
        saveDB(db);
        await showSystemModal({ title: 'Success', msg: 'Bus Added Successfully', type: 'success' });
        loadAdmin();
    }

    function loadAdmin() {
        if (!currentUser || currentUser.role !== 'ADMIN') return showView('hero');
        const db = getDB();
        
        const totalRev = db.bookings.reduce((sum, b) => sum + (b.status === 'CONFIRMED' ? b.amount : 0), 0);
        document.getElementById('admin-stats-revenue').innerText = `₹${totalRev.toLocaleString()}`;
        document.getElementById('admin-stats-users').innerText = db.users.length;
        document.getElementById('admin-stats-bookings').innerText = db.bookings.length;
        document.getElementById('admin-stats-buses').innerText = db.buses.length;

        switchAdminTab('bookings'); // Default to Bookings
    }

    function renderAdminBookings() {

        const db = getDB();
        const container = document.getElementById('admin-tx-table');
        container.innerHTML = db.bookings.slice().reverse().map(b => {
            const user = db.users.find(u => u.id === b.userId);
            return `
                <tr class="hover:bg-slate-50 transition-colors">
                    <td class="px-8 py-5 font-bold text-secondary text-sm">#${b.id}</td>
                    <td class="px-8 py-5">
                        <div class="flex items-center gap-3">
                            <div class="w-8 h-8 rounded-full bg-slate-100 flex items-center justify-center text-[10px] font-bold">${user ? user.name.charAt(0) : '?'}</div>
                            <div>
                                <p class="text-sm font-bold text-slate-800">${user ? user.name : 'Unknown'}</p>
                                <p class="text-[10px] text-slate-400">${user ? user.email : '-'}</p>
                            </div>
                        </div>
                    </td>
                    <td class="px-8 py-5 font-medium text-slate-600 text-sm">${b.from} → ${b.to}</td>
                    <td class="px-8 py-5 font-bold text-slate-800 text-sm">&#8377;${b.amount}</td>
                    <td class="px-8 py-5">
                        <span class="px-3 py-1 ${b.status === 'CANCELLED' ? 'bg-red-50 text-red-500' : 'bg-emerald-50 text-emerald-600'} text-[10px] font-bold rounded-lg uppercase">${b.status}</span>
                    </td>
                    <td class="px-8 py-5">
                        <button onclick="deleteBooking('${b.id}')" class="text-red-500 hover:text-red-700 transition-colors">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </td>
                </tr>
            `;
        }).join('');
    }

    function switchAdminTab(tabId) {
        document.querySelectorAll('.admin-tab-content').forEach(c => c.classList.add('hidden'));
        document.querySelectorAll('.admin-tab-btn').forEach(b => {
            b.classList.remove('border-primary-500', 'text-primary-500');
            b.classList.add('border-transparent', 'text-slate-400');
        });

        document.getElementById(`admin-content-${tabId}`).classList.remove('hidden');
        document.getElementById(`tab-${tabId}`).classList.add('border-primary-500', 'text-primary-500');
        document.getElementById(`tab-${tabId}`).classList.remove('border-transparent', 'text-slate-400');
        
        // Update Action Buttons
        const actionContainer = document.getElementById('admin-actions-container');
        actionContainer.innerHTML = '';
        
        if (tabId === 'bookings') {
            const btn = document.createElement('button');
            btn.onclick = generateAdminReport;
            btn.className = 'px-4 py-2 bg-indigo-50 text-indigo-600 rounded-xl font-bold text-xs hover:bg-indigo-100 transition-all';
            btn.innerHTML = '<i class="fas fa-file-export mr-2"></i>Generate Report';
            actionContainer.appendChild(btn);
            renderAdminBookings();
        } else if (tabId === 'buses') {
            const btn = document.createElement('button');
            btn.onclick = addBus;
            btn.className = 'px-4 py-2 bg-primary-500 text-white rounded-xl font-bold text-xs shadow-lg shadow-primary-500/20 hover:bg-primary-600 transition-all';
            btn.innerHTML = '<i class="fas fa-plus mr-2"></i>Add New Bus';
            actionContainer.appendChild(btn);
            renderAdminBuses();
        } else if (tabId === 'users') {
            const btn = document.createElement('button');
            btn.onclick = adminAddNewAdmin;
            btn.className = 'px-4 py-2 bg-emerald-500 text-white rounded-xl font-bold text-xs shadow-lg shadow-emerald-500/20 hover:bg-emerald-600 transition-all';
            btn.innerHTML = '<i class="fas fa-user-plus mr-2"></i>Add Admin';
            
            const filter = document.createElement('select');
            filter.id = 'admin-user-role-filter';
            filter.onchange = (e) => renderAdminUsers(e.target.value);
            filter.className = 'px-4 py-2 bg-slate-50 dark:bg-slate-800 border dark:border-slate-700 rounded-xl font-bold text-xs text-slate-600 dark:text-slate-300 outline-none focus:ring-2 focus:ring-primary-500 transition-all';
            filter.innerHTML = `
                <option value="ALL">All Roles</option>
                <option value="ADMIN">Admins Only</option>
                <option value="USER">Users Only</option>
            `;
            
            actionContainer.appendChild(filter);
            actionContainer.appendChild(btn);
            renderAdminUsers();
        } else if (tabId === 'coupons') {
            const btn = document.createElement('button');
            btn.onclick = adminAddCoupon;
            btn.className = 'px-4 py-2 bg-purple-500 text-white rounded-xl font-bold text-xs shadow-lg shadow-purple-500/20 hover:bg-purple-600 transition-all';
            btn.innerHTML = '<i class="fas fa-tag mr-2"></i>Add Coupon';
            actionContainer.appendChild(btn);
            renderAdminCoupons();
        }
    }

    function renderAdminBuses() {
        const db = getDB();
        const container = document.getElementById('admin-bus-table');
        container.innerHTML = db.buses.slice().reverse().map(bus => `
            <tr class="hover:bg-slate-50 transition-colors">
                <td class="px-8 py-5 font-bold text-secondary text-sm">${bus.name}</td>
                <td class="px-8 py-5 font-medium text-slate-600 text-sm">${bus.from} → ${bus.to}</td>
                <td class="px-8 py-5 text-sm text-slate-500">${bus.type}</td>
                <td class="px-8 py-5 font-bold text-slate-800 text-sm">₹${bus.price}</td>
                <td class="px-8 py-5 text-sm font-bold text-amber-500"><i class="fas fa-star mr-1"></i>${bus.rating}</td>
                <td class="px-8 py-5">
                    <button onclick="adminDeleteBus(${bus.id})" class="text-red-400 hover:text-red-600 transition-colors"><i class="fas fa-trash-alt"></i></button>
                </td>
            </tr>
        `).join('');
    }

    function renderAdminUsers(roleFilter = 'ALL') {
        const db = getDB();
        const container = document.getElementById('admin-user-table');
        
        let users = db.users.slice().reverse();
        if (roleFilter !== 'ALL') {
            users = users.filter(u => u.role === roleFilter);
        }

        container.innerHTML = users.map(u => `
            <tr class="hover:bg-slate-50 transition-colors">
                <td class="px-8 py-5">
                    <div class="flex items-center gap-3">
                        <div class="w-8 h-8 rounded-full bg-slate-100 flex items-center justify-center text-[10px] font-bold">${u.name.charAt(0)}</div>
                        <span class="text-sm font-bold text-slate-800">${u.name}</span>
                    </div>
                </td>
                <td class="px-8 py-5 text-sm text-slate-500">${u.email}</td>
                <td class="px-8 py-5 text-sm text-slate-500">${u.phone || '-'}</td>
                <td class="px-8 py-5">
                    <span class="px-3 py-1 ${u.role === 'ADMIN' ? 'bg-indigo-50 text-indigo-600' : 'bg-slate-50 text-slate-600'} text-[10px] font-bold rounded-lg uppercase">${u.role}</span>
                </td>
                <td class="px-8 py-5">
                    ${u.id !== currentUser.id ? `
                        <div class="flex gap-3">
                            <button onclick="adminDeleteUser(${u.id})" class="text-red-400 hover:text-red-600 transition-colors" title="Delete User"><i class="fas fa-trash-alt"></i></button>
                        </div>
                    ` : '<span class="text-[10px] text-slate-300 italic font-bold">YOU</span>'}
                </td>
            </tr>
        `).join('');
    }

    async function adminDeleteBus(id) {
        if(!(await showSystemModal({ title: 'Delete Bus?', msg: 'Are you sure you want to delete this bus?', type: 'confirm', showCancel: true }))) return;
        const db = getDB();
        db.buses = db.buses.filter(b => b.id !== id);
        saveDB(db);
        renderAdminBuses();
    }

    async function adminDeleteUser(id) {
        if(!(await showSystemModal({ title: 'Delete User?', msg: 'Are you sure you want to delete this user? This action cannot be undone.', type: 'confirm', showCancel: true }))) return;
        const db = getDB();
        db.users = db.users.filter(u => u.id !== id);
        saveDB(db);
        renderAdminUsers();
        loadAdmin(); // Update stats
    }

    async function adminAddNewAdmin() {
        const result = await showSystemModal({
            title: 'Create Admin Account',
            msg: 'Enter credentials for the new administrator:',
            type: 'prompt',
            inputs: [
                { label: 'Full Name', name: 'name', placeholder: 'e.g. Jane Smith' },
                { label: 'Email Address', name: 'email', type: 'email', placeholder: 'e.g. jane@swiftride.com' },
                { label: 'Password', name: 'password', type: 'password', placeholder: '••••••••' }
            ],
            showCancel: true
        });

        if(!result) return;
        const { name, email, password } = result;
 
        const db = getDB();
        const existing = db.users.find(u => u.email === email);
        if(existing) return await showSystemModal({ title: 'Duplicate Email', msg: 'A user with this email already exists.', type: 'error' });
 
        db.users.push({
            id: Date.now(),
            name,
            email,
            password,
            role: 'ADMIN',
            phone: 'N/A',
            isVerified: true,
            wallet: 0,
            swiftCash: 0,
            joined: new Date().toISOString().split('T')[0]
        });
        saveDB(db);
        await showSystemModal({ title: 'Success', msg: 'New Admin Created Successfully!', type: 'success' });
        renderAdminUsers();
        loadAdmin();
    }

    function renderAdminCoupons() {
        const db = getDB();
        const container = document.getElementById('admin-coupon-table');
        container.innerHTML = (db.coupons || []).map(cp => `
            <tr class="hover:bg-slate-50 transition-colors">
                <td class="px-8 py-5 font-bold text-primary-500 text-sm">${cp.code}</td>
                <td class="px-8 py-5 text-sm text-slate-800">${cp.discount}%</td>
                <td class="px-8 py-5 text-sm text-slate-500">₹${cp.minAmount}</td>
                <td class="px-8 py-5 text-sm ${new Date(cp.expiry) < new Date() ? 'text-red-500 font-bold' : 'text-slate-500'}">${cp.expiry}</td>
                <td class="px-8 py-5 flex gap-4">
                    <button onclick="adminEditCoupon('${cp.code}')" class="text-slate-400 hover:text-primary-500 transition-colors"><i class="fas fa-edit"></i></button>
                    <button onclick="adminDeleteCoupon('${cp.code}')" class="text-red-400 hover:text-red-600 transition-colors"><i class="fas fa-trash-alt"></i></button>
                </td>
            </tr>
        `).join('');
    }

    async function adminAddCoupon() {
        const result = await showSystemModal({
            title: 'Create New Coupon',
            msg: 'Set the details for the discount offer:',
            type: 'prompt',
            inputs: [
                { label: 'Coupon Code', name: 'code', placeholder: 'e.g. SAVE50' },
                { label: 'Discount Percentage (%)', name: 'discount', type: 'number', placeholder: 'e.g. 50' },
                { label: 'Minimum Amount (₹)', name: 'minAmount', type: 'number', placeholder: 'e.g. 1000' },
                { label: 'Expiry Date', name: 'expiry', type: 'date', value: new Date().toISOString().split('T')[0] },
                { label: 'Short Description', name: 'desc', placeholder: 'e.g. Flat 50% discount on all routes' }
            ],
            showCancel: true
        });

        if(!result) return;
        const { code, discount: discVal, minAmount: minVal, expiry, desc } = result;
        const discount = parseInt(discVal);
        const minAmount = parseInt(minVal);
        
        if(!code || isNaN(discount) || isNaN(minAmount) || !expiry) return await showSystemModal({ title: 'Error', msg: 'Invalid numerical inputs', type: 'error' });

        const db = getDB();
        if(!db.coupons) db.coupons = [];
        db.coupons.push({ code: code.toUpperCase(), discount, minAmount, expiry, desc });
        saveDB(db);
        renderAdminCoupons();
        await showNotification('Success', 'Coupon created successfully!', 'success');
    }

    async function adminEditCoupon(oldCode) {
        const db = getDB();
        const cp = db.coupons.find(c => c.code === oldCode);
        if(!cp) return;

        const result = await showSystemModal({
            title: 'Edit Coupon',
            msg: `Updating coupon: ${oldCode}`,
            type: 'prompt',
            inputs: [
                { label: 'Discount %', name: 'discount', type: 'number', value: cp.discount },
                { label: 'Min Amount (₹)', name: 'minAmount', type: 'number', value: cp.minAmount },
                { label: 'Expiry Date', name: 'expiry', type: 'date', value: cp.expiry },
                { label: 'Description', name: 'desc', value: cp.desc }
            ],
            showCancel: true
        });

        if(!result) return;
        const { discount: discVal, minAmount: minVal, expiry, desc } = result;
        const discount = parseInt(discVal);
        const minAmount = parseInt(minVal);
        
        if(isNaN(discount) || isNaN(minAmount)) return await showSystemModal({ title: 'Error', msg: 'Invalid numerical inputs', type: 'error' });

        cp.discount = discount;
        cp.minAmount = minAmount;
        cp.expiry = expiry;
        cp.desc = desc;
        
        saveDB(db);
        renderAdminCoupons();
        await showSystemModal({ title: 'Updated', msg: 'Coupon updated successfully.', type: 'success' });
    }

    async function adminDeleteCoupon(code) {
        if(!(await showSystemModal({ title: 'Delete Coupon?', msg: `Are you sure you want to delete coupon ${code}?`, type: 'confirm', showCancel: true }))) return;
        const db = getDB();
        db.coupons = db.coupons.filter(cp => cp.code !== code);
        saveDB(db);
        renderAdminCoupons();
        await showSystemModal({ title: 'Deleted', msg: 'Coupon removed successfully.', type: 'success' });
    }

    // --- Offers Logic ---
    function loadOffers() {
        const db = getDB();
        const container = document.getElementById('offers-grid');
        const now = new Date();
        
        const validCoupons = (db.coupons || []).filter(cp => new Date(cp.expiry) >= now);
        
        if(validCoupons.length === 0) {
            container.innerHTML = `<div class="col-span-full py-20 text-center glass-effect rounded-[3rem] opacity-50"><p>No active offers at the moment. Check back later!</p></div>`;
            return;
        }

        container.innerHTML = validCoupons.map(cp => `
            <div class="bg-white p-8 rounded-[2.5rem] border border-slate-100 shadow-sm hover:shadow-premium transition-all hover:-translate-y-2 relative overflow-hidden group">
                <div class="absolute -top-10 -right-10 w-32 h-32 bg-primary-50 rounded-full group-hover:bg-primary-500 group-hover:scale-150 transition-all duration-500"></div>
                <div class="relative z-10">
                    <div class="text-xs font-bold text-primary-500 uppercase tracking-widest mb-2 group-hover:text-white transition-colors">Limited Time Offer</div>
                    <h3 class="text-3xl font-display font-bold text-secondary mb-4 group-hover:text-white transition-colors">${cp.discount}% OFF</h3>
                    <p class="text-slate-500 text-sm mb-6 group-hover:text-white/80 transition-colors">${cp.desc}</p>
                    <div class="flex items-center justify-between pt-6 border-t border-slate-50 group-hover:border-white/20">
                        <div>
                            <span class="text-[10px] font-bold text-slate-400 uppercase group-hover:text-white/60">Use Code</span>
                            <div class="text-xl font-bold text-secondary group-hover:text-white transition-colors tracking-widest">${cp.code}</div>
                        </div>
                        <button onclick="copyCoupon('${cp.code}')" class="px-4 py-2 bg-slate-50 text-slate-400 rounded-xl font-bold text-xs group-hover:bg-white group-hover:text-primary-500 transition-all">COPY</button>
                    </div>
                </div>
            </div>
        `).join('');
    }
    async function copyCoupon(code) {
        navigator.clipboard.writeText(code);
        await showSystemModal({ title: 'Code Copied', msg: `Coupon ${code} copied to clipboard! Apply it during checkout to save.`, type: 'success' });
    }

    async function generateAdminReport() {
        const db = getDB();
        if(!db.bookings || db.bookings.length === 0) return await showSystemModal({ title: 'No Data', msg: 'There are no bookings to export.', type: 'info' });

        let csv = 'Transaction ID,User ID,Bus ID,Route,Amount,Status,Date,PNR,Seats\\n';
        db.bookings.forEach(b => {
            const row = [b.id, b.userId, b.busId, `${b.from}-${b.to}`, b.amount, b.status, b.date, b.pnr, `"${b.seats.join(',')}"`];
            csv += row.join(',') + '\\n';
        });

        const blob = new Blob([csv], { type: 'text/csv' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.setAttribute('hidden', '');
        a.setAttribute('href', url);
        a.setAttribute('download', `SwiftRide_Report_${new Date().toISOString().split('T')[0]}.csv`);
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    }

    async function deleteBooking(id) {
        if(!(await showSystemModal({ title: 'Delete Record?', msg: 'Are you sure you want to permanently delete this booking record?', type: 'confirm', showCancel: true }))) return;
        const db = getDB();
        db.bookings = db.bookings.filter(b => b.id !== id);
        saveDB(db);
        loadAdmin();
    }

    function swapCities() {
        const from = document.getElementById('search-from');
        const to = document.getElementById('search-to');
        [from.value, to.value] = [to.value, from.value];
    }

    function init() {
        initDB();
        initTheme();
        
        currentUser = JSON.parse(localStorage.getItem('swiftride_session')) || null;
        updateNav();

        // Enforce Root Redirects
        if (currentUser && currentUser.role === 'ADMIN') {
            showView('admin');
        } else {
            showView('hero');
        }

        startSocialProof();
        
        // Fill popular routes
        const db = getDB();
        const popular = [
            { from: 'Mumbai', to: 'Nagpur', price: 1200 },
            { from: 'Delhi', to: 'Jaipur', price: 450 },
            { from: 'Bangalore', to: 'Hyderabad', price: 900 },
            { from: 'Pune', to: 'Mumbai', price: 350 }
        ];
        document.getElementById('popular-routes-grid').innerHTML = popular.map(b => `
            <div class="bg-white p-8 rounded-[2.5rem] shadow-sm border border-slate-100 hover:shadow-premium transition-all hover:-translate-y-2 cursor-pointer group" onclick="document.getElementById('search-from').value='${b.from}'; document.getElementById('search-to').value='${b.to}'; window.scrollTo({top: document.getElementById('search-from').offsetTop - 100, behavior: 'smooth'})">
                <div class="w-12 h-12 bg-slate-50 rounded-2xl flex items-center justify-center text-primary-500 mb-6 group-hover:bg-primary-500 group-hover:text-white transition-colors">
                    <i class="fas fa-map-marked-alt text-xl"></i>
                </div>
                <h4 class="text-xl font-display font-bold text-secondary mb-2">${b.from} to ${b.to}</h4>
                <div class="flex items-center justify-between">
                    <span class="text-slate-500 text-sm">Starts at <strong class="text-primary-500 font-bold">₹${b.price}</strong></span>
                    <i class="fas fa-arrow-right text-slate-200 group-hover:text-primary-500 transition-colors"></i>
                </div>
            </div>
        `).join('');
    }

    function showBoardingPass(pnr) {
        const db = getDB();
        const booking = db.bookings.find(b => b.pnr === pnr);
        if (!booking) return alert('Booking not found');

        document.getElementById('pass-pnr').innerText = booking.pnr;
        document.getElementById('pass-from').innerText = booking.from;
        document.getElementById('pass-to').innerText = booking.to;
        document.getElementById('pass-bus').innerText = booking.busName || 'SwiftRide Express';
        document.getElementById('pass-seats').innerText = (booking.seats || []).join(', ');
        document.getElementById('pass-date').innerText = new Date(booking.date).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
        document.getElementById('pass-name').innerText = currentUser ? currentUser.name : 'Passenger';

        document.getElementById('modal-boarding-pass').classList.remove('hidden');
        document.getElementById('modal-boarding-pass').classList.add('flex');
    }

    function startSocialProof() {
        const names = ['Rahul', 'Anjali', 'Vikram', 'Sneha', 'Arjun', 'Priya', 'Siddharth', 'Meera', 'Karan', 'Pooja', 'Rohan', 'Neha'];
        
        setInterval(() => {
            if (Math.random() > 0.4) {
                const db = getDB();
                if (!db.buses || db.buses.length === 0) return;
                
                // Pick a random bus
                const bus = db.buses[Math.floor(Math.random() * db.buses.length)];
                const name = names[Math.floor(Math.random() * names.length)];
                const seatCount = Math.floor(Math.random() * 3) + 1;
                
                // Find available seats
                const allSeats = [];
                for (let i = 1; i <= 10; i++) ['A', 'B', 'C', 'D'].forEach(l => allSeats.push(i + l));
                
                const available = allSeats.filter(s => !bus.bookedSeats.includes(s));
                if (available.length < seatCount) return; // Bus is full or near full
                
                // Book seats
                const seatsToBook = [];
                for (let i = 0; i < seatCount; i++) {
                    const randomIdx = Math.floor(Math.random() * available.length);
                    seatsToBook.push(available.splice(randomIdx, 1)[0]);
                }
                bus.bookedSeats.push(...seatsToBook);
                
                // Add simulated booking to analytics
                const amount = bus.price * seatCount;
                if(!db.analytics) db.analytics = { dailyRevenue: [0], dailyBookings: [0] };
                if (db.analytics.dailyRevenue.length === 0) db.analytics.dailyRevenue.push(0);
                if (db.analytics.dailyBookings.length === 0) db.analytics.dailyBookings.push(0);
                
                db.analytics.dailyRevenue[db.analytics.dailyRevenue.length - 1] += amount;
                db.analytics.dailyBookings[db.analytics.dailyBookings.length - 1] += 1;
                
                db.bookings.push({
                    id: 'TXN-' + Math.floor(Math.random()*10000),
                    userId: 0, // Guest
                    busId: bus.id,
                    from: bus.from,
                    to: bus.to,
                    seats: seatsToBook,
                    amount: amount,
                    status: 'CONFIRMED',
                    date: new Date().toISOString().split('T')[0],
                    pnr: 'SR' + Math.floor(Math.random()*1000000)
                });

                saveDB(db);
                
                // Live UI update if Admin is viewing dashboard
                if (currentUser && currentUser.role === 'ADMIN' && document.getElementById('view-admin').classList.contains('active')) {
                    loadAdmin(); // Refresh stats in real time
                }
                
                // Live UI update if user is currently looking at this bus's seat map
                if (selectedBus && selectedBus.id === bus.id) {
                    selectedBus.bookedSeats.push(...seatsToBook); // Update local reference
                    if (document.getElementById('view-seats').classList.contains('active')) {
                        renderSeats();
                    }
                }
                
                showNotification('🔴 Live Booking', `${name} just booked ${seatCount} seat(s) on ${bus.name} (${bus.from} → ${bus.to})!`, 'info');
            }
        }, 18000);
    }

    init();
</script>
</body>
</html>
