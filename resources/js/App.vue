<template>
  <div id="app" class="selection:bg-emerald-100 selection:text-emerald-900">
    <!-- Navigation -->
    <nav class="navbar fixed top-0 w-full z-50 bg-white/90 backdrop-blur-xl border-b border-gray-100 py-3 transition-all duration-300" :class="{ 'py-2 shadow-lg': scrolled }">
      <div class="container mx-auto px-4 lg:px-6 flex justify-between items-center">
        <div class="nav-brand group cursor-pointer">
          <div class="flex items-center gap-3">
            <img :src="'/assets/logo_main.png'" alt="ISellOnline Logo" class="h-8 lg:h-9 group-hover:scale-105 transition-transform" />
            <div class="flex flex-col">
              <span class="text-xl lg:text-2xl font-black text-emerald-900 leading-none tracking-tight">ISellOnline</span>
              <span class="text-[9px] text-emerald-600 font-bold uppercase tracking-widest mt-0.5">{{ tagline }}</span>
            </div>
          </div>
        </div>
        
        <div class="nav-links hidden md:flex items-center gap-6 lg:gap-8">
          <a href="#features" class="text-sm lg:text-base text-gray-600 hover:text-emerald-600 font-bold transition-colors">Features</a>
          <a href="#how-it-works" class="text-sm lg:text-base text-gray-600 hover:text-emerald-600 font-bold transition-colors">How It Works</a>
          <a href="#pricing" class="text-sm lg:text-base text-gray-600 hover:text-emerald-600 font-bold transition-colors">Pricing</a>
          <a href="#contact" class="text-sm lg:text-base text-gray-600 hover:text-emerald-600 font-bold transition-colors">Contact</a>
          <button class="bg-emerald-600 text-white px-5 py-2 lg:px-6 lg:py-2.5 rounded-full font-bold text-sm lg:text-base hover:bg-emerald-700 hover:shadow-xl hover:shadow-emerald-200 transition-all active:scale-95">
            Get Started
          </button>
        </div>

        <button class="md:hidden p-2 text-gray-600" @click="mobileMenuOpen = !mobileMenuOpen">
          <Bars3Icon v-if="!mobileMenuOpen" class="w-6 h-6" />
          <XMarkIcon v-else class="w-6 h-6" />
        </button>
      </div>

      <!-- Mobile Menu -->
      <transition 
        enter-active-class="transition duration-200 ease-out"
        enter-from-class="translate-y-[-10px] opacity-0"
        enter-to-class="translate-y-0 opacity-100"
        leave-active-class="transition duration-150 ease-in"
        leave-from-class="translate-y-0 opacity-100"
        leave-to-class="translate-y-[-10px] opacity-0"
      >
        <div v-if="mobileMenuOpen" class="md:hidden absolute top-full left-0 w-full bg-white border-b border-gray-100 shadow-2xl p-6 flex flex-col gap-4">
          <a href="#features" class="text-base font-bold text-gray-800" @click="mobileMenuOpen = false">Features</a>
          <a href="#how-it-works" class="text-base font-bold text-gray-800" @click="mobileMenuOpen = false">How It Works</a>
          <a href="#pricing" class="text-base font-bold text-gray-800" @click="mobileMenuOpen = false">Pricing</a>
          <a href="#contact" class="text-base font-bold text-gray-800" @click="mobileMenuOpen = false">Contact</a>
          <button class="w-full bg-emerald-600 text-white py-3 rounded-2xl font-bold text-lg shadow-lg">Start Free Trial</button>
        </div>
      </transition>
    </nav>

    <!-- Hero Section -->
    <section class="hero pt-24 lg:pt-32 pb-16 lg:pb-20 overflow-hidden">
      <div class="container mx-auto px-4 lg:px-6 md:px-12">
        <div class="flex flex-col lg:flex-row items-center gap-10 lg:gap-16">
          <div class="lg:w-1/2 space-y-6 lg:space-y-8 text-center lg:text-left animate-fade-up">
            <div class="inline-flex items-center gap-2 px-3 py-1.5 lg:px-4 lg:py-2 bg-emerald-50 text-emerald-700 rounded-full text-xs lg:text-sm font-bold border border-emerald-100 animate-bounce-subtle">
              <BoltIcon class="w-3.5 h-3.5 lg:w-4 h-4" />
              <span>AI-Powered E-commerce</span>
            </div>
            
            <h1 class="text-3xl md:text-4xl lg:text-5xl font-black text-white leading-tight">
              Launch Your Store in 5 Mins. <span class="text-emerald-400 drop-shadow-sm">No Dev Needed.</span>
            </h1>
            
            <p class="text-base lg:text-lg text-emerald-50/80 max-w-2xl mx-auto lg:mx-0 font-medium leading-relaxed">
              No need to hire a developer, ISellOnline Got you! 
              Turn WhatsApp chats into a complete store. Manage products and payments with simple text messages.
            </p>
            
            <div class="flex flex-row items-center gap-3 justify-center lg:justify-start pt-2">
              <button class="px-6 py-3 bg-white text-emerald-700 rounded-xl font-bold text-sm lg:text-base hover:scale-105 transition-all shadow-lg hover:shadow-white/10 active:scale-95 group">
                Create My Store
                <ArrowRightIcon class="w-4 h-4 inline-block ml-1.5 group-hover:translate-x-1 transition-transform" />
              </button>
              <button class="px-6 py-3 bg-emerald-700/30 text-white border border-emerald-400/30 backdrop-blur-md rounded-xl font-bold text-sm lg:text-base hover:bg-emerald-700/50 transition-all active:scale-95">
                Watch Demo
              </button>
            </div>

            <div class="flex items-center justify-center lg:justify-start gap-4 lg:gap-6 pt-6 italic text-emerald-100/60 font-medium text-xs lg:text-sm">
              <div class="flex -space-x-3">
                <img v-for="i in 4" :key="i" :src="`https://i.pravatar.cc/100?img=${i+10}`" class="w-10 h-10 lg:w-12 lg:h-12 rounded-full border-2 border-emerald-800 shadow-xl" />
              </div>
              <div class="text-left">
                <p class="text-white font-bold leading-none">2,500+ Sellers</p>
                <div class="flex items-center gap-1 mt-1">
                  <StarIcon v-for="i in 5" :key="i" class="w-3 h-3 lg:w-4 h-4 text-emerald-400 fill-current" />
                </div>
              </div>
            </div>
          </div>

          <div class="lg:w-1/2 relative group w-full max-w-[400px] lg:max-w-none">
            <!-- Decorative elements -->
            <div class="absolute -top-10 -right-10 w-48 h-48 lg:w-64 lg:h-64 bg-emerald-400/20 blur-3xl rounded-full animate-pulse"></div>
            
            <div class="relative z-10 p-2 lg:p-6 bg-white/5 backdrop-blur-2xl border border-white/10 rounded-[30px] lg:rounded-[40px] shadow-3xl animate-float">
              <div class="phone-mockup relative bg-gray-900 rounded-[24px] lg:rounded-[32px] border-[6px] lg:border-[8px] border-gray-800 shadow-inner overflow-hidden aspect-[9/16] max-w-[320px] lg:max-w-[360px] mx-auto">
                <!-- Status Bar -->
                <div class="h-6 lg:h-8 bg-emerald-800 flex items-center justify-between px-4 lg:px-6 pt-1 lg:pt-2">
                   <span class="text-[8px] lg:text-[10px] text-white font-bold tracking-tight">9:41</span>
                   <div class="flex gap-1 lg:gap-1.5">
                     <span class="text-[8px] lg:text-[10px] text-white font-bold">5G</span>
                   </div>
                </div>
                
                <!-- Chat Header -->
                <div class="h-14 lg:h-16 bg-emerald-800 border-b border-emerald-700 flex items-center px-4 gap-3 shadow-md">
                   <div class="w-8 h-8 lg:w-10 lg:h-10 rounded-full bg-emerald-600 flex items-center justify-center">
                     <ChatBubbleLeftRightIcon class="w-5 h-5 lg:w-6 lg:h-6 text-white" />
                   </div>
                   <div>
                     <h4 class="text-xs lg:text-sm font-bold text-white">ISellOnline AI</h4>
                     <p class="text-[8px] lg:text-[10px] text-emerald-300 font-medium tracking-tight">Online Assistant</p>
                   </div>
                </div>

                <!-- Chat Body -->
                <div ref="chatContainer" class="h-[400px] lg:h-[450px] overflow-y-auto p-4 space-y-3 lg:space-y-4 bg-[#0b141a] scroll-smooth custom-scrollbar">
                  <div v-for="(msg, i) in activeMessages" :key="i" 
                    class="flex flex-col max-w-[85%] animate-fade-up-short"
                    :class="msg.role === 'user' ? 'ml-auto items-end' : 'mr-auto items-start'">
                    <div class="p-2.5 lg:p-3 rounded-xl lg:rounded-2xl text-[12px] lg:text-sm" 
                      :class="msg.role === 'user' ? 'bg-[#005c4b] text-white rounded-tr-none shadow-sm' : 'bg-[#202c33] text-white rounded-tl-none shadow-sm'">
                      <p class="whitespace-pre-line" v-html="msg.text"></p>
                    </div>
                    <span class="text-[8px] lg:text-[9px] text-gray-500 font-medium mt-1 px-1">{{ msg.time }}</span>
                  </div>
                </div>

                <!-- Chat Input Mockup -->
                <div class="absolute bottom-0 left-0 w-full p-3 lg:p-4 bg-[#0b141a]">
                   <div class="flex items-center gap-2 bg-[#202c33] rounded-full px-3 py-1.5 lg:px-4 lg:py-2 text-gray-400">
                     <FaceSmileIcon class="w-4 h-4 lg:w-5 lg:h-5 flex-shrink-0" />
                     <span class="flex-grow text-[10px] lg:text-xs italic">Type as message...</span>
                     <PaperClipIcon class="w-4 h-4 lg:w-5 lg:h-5 flex-shrink-0" />
                     <CameraIcon class="w-4 h-4 lg:w-5 lg:h-5 flex-shrink-0" />
                   </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Logo Cloud -->
    <div class="bg-emerald-950 py-10 relative overflow-hidden">
      <div class="container mx-auto px-6 relative z-10 flex flex-wrap justify-center gap-8 lg:gap-16 opacity-30 grayscale hover:grayscale-0 transition-all duration-700">
        <div v-for="i in 5" :key="i" class="text-white text-xl lg:text-2xl font-black italic tracking-tighter">BRAND_{{ i }}</div>
      </div>
    </div>

    <!-- How It Works Section -->
    <section id="how-it-works" class="py-24 lg:py-32 bg-white relative overflow-hidden">
      <div class="container mx-auto px-4 lg:px-6 relative z-10">
        <div class="text-center max-w-3xl mx-auto mb-16 lg:mb-20">
          <h2 class="text-3xl lg:text-5xl font-black text-gray-900 mb-4 lg:mb-6">Built for <span class="text-emerald-600">Speed.</span></h2>
          <p class="text-lg lg:text-xl text-gray-500 font-medium">Three phases of your business growth managed seamlessly via WhatsApp.</p>
        </div>
        
        <div class="flex flex-wrap justify-center gap-3 lg:gap-4 mb-12 lg:mb-16">
          <button 
            v-for="(flow, index) in flows" 
            :key="index"
            :class="['px-6 py-3 lg:px-8 lg:py-4 rounded-xl lg:rounded-2xl text-base lg:text-lg font-bold transition-all duration-300 transform', 
                    activeFlow === index 
                    ? 'bg-emerald-600 text-white shadow-2xl shadow-emerald-200 scale-105' 
                    : 'bg-gray-50 text-gray-400 hover:bg-gray-100 hover:text-gray-600']"
            @click="activeFlow = index"
          >
            {{ flow.name }}
          </button>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 lg:gap-8">
          <div 
            v-for="(step, idx) in flows[activeFlow].steps" 
            :key="idx"
            class="group relative bg-white p-6 lg:p-8 rounded-[24px] lg:rounded-[32px] border-2 border-gray-50 hover:border-emerald-100 hover:shadow-2xl hover:shadow-emerald-100/50 transition-all active:scale-95 animate-fade-up"
            :style="{ animationDelay: `${idx * 0.1}s` }"
          >
            <div class="w-12 h-12 lg:w-16 lg:h-16 bg-emerald-50 text-emerald-600 rounded-xl lg:rounded-2xl flex items-center justify-center mb-6 group-hover:bg-emerald-600 group-hover:text-white transition-colors duration-500 shadow-sm">
              <component :is="step.heroIcon" class="w-6 h-6 lg:w-8 lg:h-8" />
            </div>
            <div class="absolute top-6 right-6 lg:top-8 lg:right-8 text-3xl lg:text-4xl font-black text-gray-100 group-hover:text-emerald-50 transition-colors">0{{ idx + 1 }}</div>
            <h3 class="text-lg lg:text-xl font-black text-gray-900 mb-2 lg:mb-3 tracking-tight">{{ step.title }}</h3>
            <p class="text-sm lg:text-base text-gray-500 leading-relaxed font-medium">{{ step.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-24 lg:py-32 bg-gray-50">
      <div class="container mx-auto px-4 lg:px-6">
        <div class="text-center max-w-3xl mx-auto mb-16 lg:mb-20">
          <h2 class="text-3xl lg:text-5xl font-black text-gray-900 mb-4 lg:mb-6 underline decoration-emerald-500/10 decoration-8 underline-offset-8">Powerful Features</h2>
          <p class="text-lg lg:text-xl text-gray-500 font-medium">Standard tools designed for extraordinary business owners.</p>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-5 lg:gap-6">
          <div v-for="(feature, index) in features" :key="index" 
            class="bg-white p-6 lg:p-8 rounded-[30px] lg:rounded-[40px] shadow-lg shadow-gray-200/50 hover:shadow-2xl hover:shadow-emerald-200/50 hover:-translate-y-2 transition-all duration-500 border border-gray-100 group">
            <div class="w-12 h-12 lg:w-16 lg:h-16 bg-gradient-to-br from-emerald-500 to-green-600 rounded-xl lg:rounded-2xl flex items-center justify-center mb-6 lg:mb-8 shadow-lg shadow-emerald-200 group-hover:rotate-6 transition-transform">
              <component :is="feature.heroIcon" class="w-6 h-6 lg:w-8 lg:h-8 text-white" />
            </div>
            <h3 class="text-lg lg:text-xl font-black text-gray-900 mb-3 lg:mb-4 tracking-tight">{{ feature.title }}</h3>
            <p class="text-sm lg:text-base text-gray-500 font-medium leading-relaxed">{{ feature.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Testimonials -->
    <section class="py-24 lg:py-32 bg-white">
      <div class="container mx-auto px-4 lg:px-6 text-center">
        <div class="mb-16 lg:mb-20 space-y-4">
          <h2 class="text-3xl lg:text-5xl font-black text-gray-900 underline decoration-green-500/10 decoration-8 underline-offset-8">Success Stories</h2>
          <p class="text-lg lg:text-xl text-gray-500 font-medium tracking-tight">Listen to our sellers who redefined their business.</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 lg:gap-8 text-left">
          <div v-for="(test, i) in testimonials" :key="i" 
            class="bg-gray-50 p-8 lg:p-10 rounded-[30px] lg:rounded-[48px] relative group hover:bg-emerald-950 transition-colors duration-700">
            <p class="text-base lg:text-lg text-gray-700 font-medium leading-relaxed italic z-10 relative group-hover:text-emerald-50 transition-colors h-36 lg:h-40 overflow-hidden">
               {{ test.content }}
            </p>
            <div class="mt-8 flex items-center gap-4 border-t border-gray-200 pt-8 group-hover:border-emerald-800 transition-colors">
              <img :src="test.avatar" class="w-12 h-12 lg:w-16 lg:h-16 rounded-xl lg:rounded-2xl object-cover shadow-xl grayscale group-hover:grayscale-0 transition-all duration-700" />
              <div>
                <h4 class="text-base lg:text-lg font-black text-gray-900 group-hover:text-white transition-colors tracking-tight">{{ test.name }}</h4>
                <p class="text-xs lg:text-sm text-emerald-600 font-bold group-hover:text-emerald-400 transition-colors">{{ test.business }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="py-24 lg:py-32 bg-emerald-950 px-4 lg:px-6">
      <div class="container mx-auto max-w-7xl">
        <div class="text-center mb-16 lg:mb-24 max-w-3xl mx-auto">
          <h2 class="text-4xl lg:text-6xl font-black text-white mb-6 lg:mb-8 tracking-tight">Ready to <span class="text-emerald-500 underline decoration-emerald-500/20 underline-offset-8">Scale?</span></h2>
          <p class="text-lg lg:text-xl text-emerald-50/60 font-medium">No hidden fees. No complicated setups. Just pure growth.</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 lg:gap-8">
          <div v-for="(plan, i) in pricingPlans" :key="i" 
            class="relative flex flex-col bg-emerald-900/30 backdrop-blur-3xl p-6 lg:p-8 rounded-[30px] lg:rounded-[48px] border border-emerald-400/10 hover:border-emerald-400/30 transition-all duration-500 group overflow-hidden"
            :class="{ 'scale-105 lg:scale-110 border-emerald-400/40 bg-emerald-900/50 shadow-3xl shadow-emerald-500/10 z-10': plan.popular }">
            
            <div v-if="plan.popular" class="absolute top-0 right-0 bg-emerald-400 text-emerald-950 py-1.5 px-6 lg:px-8 rounded-bl-3xl text-[9px] lg:text-[10px] font-black uppercase tracking-widest shadow-lg">Recommended</div>
            
            <div class="mb-8 lg:mb-10">
              <h3 class="text-xl lg:text-2xl font-black text-white mb-2 tracking-tight">{{ plan.name }}</h3>
              <div class="flex items-baseline gap-1">
                <span class="text-3xl lg:text-4xl font-black text-white">₦{{ plan.price }}</span>
                <span class="text-emerald-400/60 font-bold text-sm">/mo</span>
              </div>
            </div>

            <ul class="space-y-3 lg:space-y-4 mb-8 lg:mb-12 flex-grow">
              <li v-for="feat in plan.features" :key="feat" class="flex items-center gap-2 lg:gap-3 text-emerald-50/80 font-medium text-[13px] lg:text-sm">
                <CheckBadgeIcon class="w-4 h-4 lg:w-5 lg:h-5 text-emerald-400 flex-shrink-0" />
                <span>{{ feat }}</span>
              </li>
            </ul>

            <button class="w-full py-4 lg:py-5 rounded-xl lg:rounded-2xl font-black text-base lg:text-lg transition-all duration-500 active:scale-95 shadow-lg"
              :class="plan.popular ? 'bg-emerald-400 text-emerald-950 shadow-emerald-400/20 hover:bg-white' : 'bg-white/10 text-white hover:bg-white/20 border border-white/10'">
              Choose Plan
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gray-50 border-t border-gray-100 py-20 lg:py-32">
      <div class="container mx-auto px-4 lg:px-6">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 lg:gap-16 mb-20 lg:mb-24">
          <div class="lg:col-span-1 space-y-6 lg:space-y-8">
             <div class="flex items-center gap-3">
               <img :src="'/assets/logo_main.png'" alt="ISellOnline Logo" class="h-8 lg:h-10" />
               <span class="text-2xl font-black text-gray-900 tracking-tight">ISellOnline</span>
             </div>
             <p class="text-lg text-gray-500 font-medium leading-relaxed pr-4">
               The world's first AI-powered WhatsApp creator for entrepreneurs. No code, just growth.
             </p>
             <div class="flex gap-3">
               <a v-for="i in 4" :key="i" href="#" class="w-10 h-10 lg:w-12 lg:h-12 bg-white border border-gray-200 rounded-xl flex items-center justify-center text-gray-400 hover:text-emerald-600 hover:border-emerald-600 transition-all hover:-translate-y-1">
                 <component :is="socialIcons[i-1]" class="w-4 h-4 lg:w-5 lg:h-5" />
               </a>
             </div>
          </div>
          
          <div v-for="(section, title) in footerLinks" :key="title">
             <h4 class="text-[11px] font-black text-gray-900 uppercase tracking-[0.2em] mb-6 lg:mb-8">{{ title }}</h4>
             <ul class="space-y-4 lg:space-y-6">
               <li v-for="link in section" :key="link.name">
                 <a :href="link.href" class="text-[14px] lg:text-[15px] text-gray-500 font-bold hover:text-emerald-600 transition-all">{{ link.name }}</a>
               </li>
             </ul>
          </div>
        </div>
        
        <div class="pt-10 border-t border-gray-100 flex flex-col md:flex-row justify-between items-center gap-6 lg:gap-8">
          <p class="text-gray-400 font-bold uppercase text-[10px] tracking-widest text-center lg:text-left">&copy; 2026 ISellOnline AI. Deepmind Research Tool.</p>
          <div class="flex gap-6 lg:gap-10">
            <a href="/privacy" class="text-[10px] text-gray-400 font-bold hover:text-gray-900 uppercase tracking-widest">Privacy</a>
            <a href="/terms" class="text-[10px] text-gray-400 font-bold hover:text-gray-900 uppercase tracking-widest">Terms</a>
            <a href="/user-data-deletion" class="text-[10px] text-gray-400 font-bold hover:text-gray-900 uppercase tracking-widest">Data Deletion</a>
          </div>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue';
import { 
  ChatBubbleLeftRightIcon,
  Bars3Icon,
  XMarkIcon,
  BoltIcon,
  ArrowRightIcon,
  StarIcon,
  PlayCircleIcon,
  ShoppingBagIcon,
  CheckBadgeIcon,
  GlobeAltIcon,
  AcademicCapIcon,
  WrenchIcon,
  ServerIcon,
  BellIcon,
  LockClosedIcon,
  ChartBarIcon,
  DevicePhoneMobileIcon,
  CreditCardIcon,
  EnvelopeIcon,
  FaceSmileIcon,
  PaperClipIcon,
  CameraIcon
} from '@heroicons/vue/24/outline';

const scrolled = ref(false);
const mobileMenuOpen = ref(false);
const activeFlow = ref(0);
const tagline = window.tagline || 'Simple Online Stores via WhatsApp';
const chatContainer = ref(null);

const heroImage = '/images/hero.png';

const allMessages = [
  { role: 'user', text: 'Hi! I want to create an online store', time: '9:41 AM' },
  { role: 'ai', text: 'Great! Let\'s get started. What\'s your store name?', time: '9:42 AM' },
  { role: 'user', text: 'TechGadgets Pro', time: '9:42 AM' },
  { role: 'ai', text: '✅ Perfect! Your store is ready at:\n**techgadgets.isellonline.com**', time: '9:43 AM' },
  { role: 'user', text: 'Add product: iPhone 15 Pro, ₦850,000, 10 in stock', time: '9:45 AM' },
  { role: 'ai', text: '📱 Product added successfully! iPhone 15 Pro - ₦850,000 (10 units)', time: '9:45 AM' },
  { role: 'user', text: 'Add Samsung Galaxy S24, ₦750,000', time: '9:46 AM' },
  { role: 'ai', text: '📱 Added Samsung Galaxy S24 - ₦750,000', time: '9:46 AM' },
  { role: 'user', text: 'Show my wallet balance', time: '9:50 AM' },
  { role: 'ai', text: '💰 Your wallet balance: ₦25,000\nAvailable for domain purchase', time: '9:50 AM' },
  { role: 'user', text: 'Can I purchase this domain?', time: '9:51 AM' },
  { role: 'ai', text: '🌐 Domain purchase: ₦15,000/year\nYour balance: ₦25,000\nProceed with payment?', time: '9:52 AM' },
  { role: 'user', text: 'Yes, pay from wallet', time: '9:55 AM' },
  { role: 'ai', text: '💳 Payment processed! ₦15,000 deducted.\nDomain is now yours! 🎉', time: '9:56 AM' },
  { role: 'user', text: 'Update iPhone price to ₦800,000', time: '10:00 AM' },
  { role: 'ai', text: '📈 Price updated! iPhone 15 Pro now ₦800,000', time: '10:01 AM' },
  { role: 'user', text: 'Check today\'s sales', time: '10:05 AM' },
  { role: 'ai', text: '📊 Today\'s sales: ₦0\n3 visitors to your store\nKeep up the great work!', time: '10:06 AM' }
];

const activeMessages = ref([]);

const scrollToBottom = async () => {
  await nextTick();
  if (chatContainer.value) {
    chatContainer.value.scrollTop = chatContainer.value.scrollHeight;
  }
};

const simulateChat = () => {
  let i = 0;
  activeMessages.value = [];
  const interval = setInterval(() => {
    if (i < allMessages.length) {
      activeMessages.value.push(allMessages[i]);
      i++;
      scrollToBottom();
    } else {
      setTimeout(() => {
        i = 0;
        activeMessages.value = [];
      }, 5000);
    }
  }, 2500);
};

onMounted(() => {
  simulateChat();
  window.addEventListener('scroll', () => {
    scrolled.value = window.scrollY > 20;
  });
});

const flows = [
  {
    name: 'Store Setup',
    steps: [
      { heroIcon: ChatBubbleLeftRightIcon, title: 'Send WhatsApp', description: 'Start by sending a message from your WhatsApp app.' },
      { heroIcon: ServerIcon, title: 'Processing', description: 'Our AI processes your request in milliseconds.' },
      { heroIcon: GlobeAltIcon, title: 'Live Store', description: 'Get a professional URL (yourname.isellonline.com) instantly.' }
    ]
  },
  {
    name: 'Management',
    steps: [
      { heroIcon: AcademicCapIcon, title: 'Smart Commands', description: 'Add products, prices, and stock via simple text messages.' },
      { heroIcon: WrenchIcon, title: 'Permission Check', description: 'Secure access ensures only you can modify your store content.' },
      { heroIcon: BellIcon, title: 'Live Alerts', description: 'Get instant notifications for orders and inventory updates.' }
    ]
  },
  {
    name: 'Customer Flow',
    steps: [
      { heroIcon: ShoppingBagIcon, title: 'Visit Web Store', description: 'Customers browse your beautiful mobile-optimized interface.' },
      { heroIcon: CreditCardIcon, title: 'Secure Checkout', description: 'Customers pay safely via integrated localized gateways.' },
      { heroIcon: EnvelopeIcon, title: 'Order Details', description: 'Get complete order summaries sent directly to your chat.' }
    ]
  }
];

const features = [
  { heroIcon: BoltIcon, title: 'Instant Setup', description: 'Zero configuration. Just message and sell instantly.' },
  { heroIcon: AcademicCapIcon, title: 'AI Assistant', description: 'Human-like understanding of your business commands.' },
  { heroIcon: GlobeAltIcon, title: 'Custom Domains', description: 'Professional identity at your fingertips.' },
  { heroIcon: CreditCardIcon, title: 'Safe Payments', description: 'Integrated wallet and bank transfers.' },
  { heroIcon: DevicePhoneMobileIcon, title: 'Mobile First', description: 'Optimized for the next billion users.' },
  { heroIcon: ChartBarIcon, title: 'Analytics', description: 'Track your growth with real-time dashboards.' },
  { heroIcon: BellIcon, title: 'Live Notifications', description: 'Never miss an order update ever again.' },
  { heroIcon: LockClosedIcon, title: 'Enterprise Security', description: 'Bank-level encryption for all your data.' }
];

const testimonials = [
  { 
    name: 'Sarah Johnson', 
    business: 'Fashion Boutique', 
    content: "ISellOnline changed my business completely! I went from zero to 500 customers in just 2 weeks. Using WhatsApp is so easy.",
    avatar: '/images/avatar_sarah.png'
  },
  { 
    name: 'Michael Chen', 
    business: 'Supply Hub', 
    content: "Managing my products through WhatsApp saves me hours every day. The system understands exactly what I want to do.",
    avatar: '/images/avatar_michael.png'
  },
  { 
    name: 'Amina Hassan', 
    business: 'Handmade Crafts', 
    content: "Getting my own web address made my store look professional. Customers love how smooth everything works.",
    avatar: '/images/avatar_amina.png'
  }
];

const pricingPlans = [
  { name: 'Free', price: '0', features: ['15 Products', 'Basic Support', 'Standard Store URL', 'Basic Analytics'] },
  { name: 'Starter', price: '4,599', popular: true, features: ['100 Products', 'Priority Support', 'Custom Branding', 'Advanced Analytics', 'Payment Integration'] },
  { name: 'Pro', price: '10,000', features: ['250 Products', '3 Premium Themes', 'Custom Domain Support', '24/7 Support', 'Bulk Product Manager'] },
  { name: 'Elite', price: '25,000', features: ['Unlimited Products', 'Free .ng Domain', 'Dedicated Manager', 'Custom Integrations', 'Priority Listing'] }
];

const footerLinks = {
  'Product': [
    { name: 'Features', href: '#features' },
    { name: 'Pricing', href: '#pricing' },
    { name: 'How It Works', href: '#how-it-works' }
  ],
  'Company': [
    { name: 'About', href: '#' },
    { name: 'Blog', href: '#' },
    { name: 'Careers', href: '#' },
    { name: 'Support', href: '#' }
  ],
  'Support': [
    { name: 'Privacy', href: '/privacy' },
    { name: 'Terms', href: '/terms' },
    { name: 'Data Deletion', href: '/user-data-deletion' },
    { name: 'Contact', href: '#contact' }
  ]
};

const socialIcons = [ChatBubbleLeftRightIcon, GlobeAltIcon, ServerIcon, AcademicCapIcon];
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap');

html {
  scroll-behavior: smooth;
}

body {
  margin: 0;
  padding: 0;
  overflow-x: hidden;
}

#app {
  font-family: 'Ubuntu', sans-serif;
  background: #022c22;
}

.custom-scrollbar::-webkit-scrollbar {
  width: 3px;
}
.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}
.custom-scrollbar::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.05);
  border-radius: 10px;
}

@keyframes fade-up {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes fade-up-short {
  from { opacity: 0; transform: translateY(8px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes float {
  0% { transform: translateY(0px); }
  50% { transform: translateY(-12px); }
  100% { transform: translateY(0px); }
}

@keyframes bounce-subtle {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-3px); }
}

.animate-fade-up { animation: fade-up 0.8s ease-out forwards; }
.animate-fade-up-short { animation: fade-up-short 0.4s ease-out forwards; }
.animate-float { animation: float 6s ease-in-out infinite; }
.animate-bounce-subtle { animation: bounce-subtle 3s ease-in-out infinite; }
</style>