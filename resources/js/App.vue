<template>
  <div id="app">
    <!-- Navigation -->
    <nav class="navbar">
      <div class="container">
        <div class="nav-brand">
          <h2 class="brand-name">ISellOnline</h2>
          <p class="tagline">{{ tagline }}</p>
        </div>
        <div class="nav-links" :class="{ 'mobile-open': mobileMenuOpen }">
          <a href="#features" @click="mobileMenuOpen = false">Features</a>
          <a href="#pricing" @click="mobileMenuOpen = false">Pricing</a>
          <a href="#how-it-works" @click="mobileMenuOpen = false">How It Works</a>
          <a href="#contact" @click="mobileMenuOpen = false">Contact</a>
          <button class="cta-btn" @click="mobileMenuOpen = false">Start Now</button>
        </div>
        <button class="mobile-menu-toggle" @click="toggleMobileMenu" :class="{ active: mobileMenuOpen }">
          <span></span>
          <span></span>
          <span></span>
        </button>
      </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
      <div class="container">
        <div class="hero-content" :class="{ 'fade-in': loaded }">
          <h1 class="hero-title">
            Build Your Online Store
            <span class="gradient-text">Via WhatsApp</span>
          </h1>
          <p class="hero-subtitle">
            Turn simple WhatsApp messages into a complete online store.
            No technical skills needed. Just send messages and start selling.
          </p>
          <div class="hero-cta">
            <button class="btn-primary">Get Started</button>
            <button class="btn-secondary">See How It Works</button>
          </div>
        </div>
        <div class="hero-visual" :class="{ 'slide-in': loaded }">
          <div class="phone-mockup">
            <div class="whatsapp-chat">
              <div class="chat-message sent">
                <p>Hi! I want to create an online store</p>
              </div>
              <div class="chat-message received">
                <p>Great! Let's get started. What's your store name?</p>
              </div>
              <div class="chat-message sent">
                <p>TechGadgets Pro</p>
              </div>
              <div class="chat-message received">
                <p>✅ Perfect! Your store is ready at:<br><strong>techgadgets.isellonline.com</strong></p>
              </div>
              <div class="chat-message sent">
                <p>Add product: iPhone 15 Pro, ₦850,000, 10 in stock</p>
              </div>
              <div class="chat-message received">
                <p>📱 Product added successfully! iPhone 15 Pro - ₦850,000 (10 units)</p>
              </div>
              <div class="chat-message sent">
                <p>Add Samsung Galaxy S24, ₦750,000</p>
              </div>
              <div class="chat-message received">
                <p>📱 Added Samsung Galaxy S24 - ₦750,000</p>
              </div>
              <div class="chat-message sent">
                <p>Show my wallet balance</p>
              </div>
              <div class="chat-message received">
                <p>💰 Your wallet balance: ₦25,000<br>Available for domain purchase and other services</p>
              </div>
              <div class="chat-message sent">
                <p>Can I purchase this domain?</p>
              </div>
              <div class="chat-message received">
                <p>🌐 Domain purchase: ₦15,000/year<br>Your balance: ₦25,000<br>Proceed with payment?</p>
              </div>
              <div class="chat-message sent">
                <p>Yes, pay from wallet</p>
              </div>
              <div class="chat-message received">
                <p>💳 Payment processed! ₦15,000 deducted.<br>New balance: ₦10,000<br>Domain is now yours! 🎉</p>
              </div>
              <div class="chat-message sent">
                <p>Update iPhone price to ₦800,000</p>
              </div>
              <div class="chat-message received">
                <p>📈 Price updated! iPhone 15 Pro now ₦800,000</p>
              </div>
              <div class="chat-message sent">
                <p>Check today's sales</p>
              </div>
              <div class="chat-message received">
                <p>📊 Today's sales: ₦0<br>3 visitors to your store<br>Keep up the great work!</p>
              </div>
              <div class="chat-message sent">
                <p>Add AirPods Pro, ₦120,000, 20 stock</p>
              </div>
              <div class="chat-message received">
                <p>🎧 Product added! AirPods Pro - ₦120,000 (20 units)</p>
              </div>
              <div class="chat-message sent">
                <p>Send promotional message to customers</p>
              </div>
              <div class="chat-message received">
                <p>📢 What message would you like to send?</p>
              </div>
              <div class="chat-message sent">
                <p>Flash sale! 20% off all products today only!</p>
              </div>
              <div class="chat-message received">
                <p>✅ Promotional message sent to 5 customers!</p>
              </div>
              <div class="chat-message sent">
                <p>Can I purchase techgadgets.xyz?</p>
              </div>
              <div class="chat-message received">
                <p>🌐 Custom domain available!<br>techgadgets.xyz - ₦25,000/year<br>Your wallet: ₦10,000<br>💳 Pay ₦25,000 to purchase?</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- How It Works Section -->
    <section id="how-it-works" class="how-it-works">
      <div class="container">
        <h2 class="section-title">How It Works</h2>
        <p class="section-subtitle">Three easy steps that make your online store work</p>
        
        <div class="flow-tabs">
          <button 
            v-for="(flow, index) in flows" 
            :key="index"
            :class="['tab-btn', { active: activeFlow === index }]"
            @click="activeFlow = index"
          >
            {{ flow.name }}
          </button>
        </div>

        <div class="flow-content">
          <transition name="fade" mode="out-in">
            <div :key="activeFlow" class="flow-steps">
              <div 
                v-for="(step, idx) in flows[activeFlow].steps" 
                :key="idx"
                class="step-card"
                :style="{ animationDelay: `${idx * 0.1}s` }"
              >
                <div class="step-number">{{ idx + 1 }}</div>
                <div class="step-content">
                  <h3>{{ step.title }}</h3>
                  <p>{{ step.description }}</p>
                </div>
                <div class="step-icon">
                  <component :is="step.icon" size="32" color="#0D4715" />
                </div>
              </div>
            </div>
          </transition>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="features">
      <div class="container">
        <h2 class="section-title">Store Features</h2>
        <p class="section-subtitle">Everything you need to run your online store successfully</p>
        
        <div class="features-grid">
          <div v-for="(feature, index) in features" :key="index" class="feature-card">
            <div class="feature-icon">
              <component :is="feature.icon" size="48" color="white" />
            </div>
            <h3>{{ feature.title }}</h3>
            <p>{{ feature.description }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials">
      <div class="container">
        <h2 class="section-title">What Our Users Say</h2>
        <p class="section-subtitle">See how other store owners are succeeding</p>

        <div class="testimonials-grid">
          <div class="testimonial-card">
            <div class="testimonial-content">
              <p>"ISellOnline changed my business completely! I went from zero to 500 customers in just 2 weeks. Using WhatsApp is so easy."</p>
            </div>
            <div class="testimonial-author">
              <div class="author-avatar">
                <User size="24" color="white" />
              </div>
              <div class="author-info">
                <h4>Sarah Johnson</h4>
                <p>Fashion Store Owner</p>
              </div>
            </div>
          </div>

          <div class="testimonial-card">
            <div class="testimonial-content">
              <p>"Managing my products through WhatsApp saves me hours every day. The system understands exactly what I want to do."</p>
            </div>
            <div class="testimonial-author">
              <div class="author-avatar">
                <ChefHat size="24" color="white" />
              </div>
              <div class="author-info">
                <h4>Michael Chen</h4>
                <p>Restaurant Supplies</p>
              </div>
            </div>
          </div>

          <div class="testimonial-card">
            <div class="testimonial-content">
              <p>"Getting my own web address made my store look professional. Customers love how smooth everything works."</p>
            </div>
            <div class="testimonial-author">
              <div class="author-avatar">
                <Palette size="24" color="#0D4715" />
              </div>
              <div class="author-info">
                <h4>Amina Hassan</h4>
                <p>Art & Crafts</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Pricing Section -->
    <section id="pricing" class="pricing">
      <div class="container">
        <h2 class="section-title">Choose Your Plan</h2>
        <p class="section-subtitle">Select the perfect plan for your business needs</p>

        <div class="pricing-grid">
          <div class="pricing-card">
            <div class="pricing-header">
              <h3>Free</h3>
              <div class="price">₦0<span>/month</span></div>
            </div>
            <ul class="pricing-features">
              <li>15 Products</li>
              <li>Basic WhatsApp Support</li>
              <li>Standard Templates</li>
              <li>Basic Analytics</li>
            </ul>
            <button class="pricing-btn">Get Started Free</button>
          </div>

          <div class="pricing-card popular">
            <div class="pricing-badge">Most Popular</div>
            <div class="pricing-header">
              <h3>Starter</h3>
              <div class="price">₦4,599<span>/month</span></div>
            </div>
            <ul class="pricing-features">
              <li>100 Products</li>
              <li>Priority WhatsApp Support</li>
              <li>Custom Branding</li>
              <li>Advanced Analytics</li>
              <li>Payment Integration</li>
            </ul>
            <button class="pricing-btn primary">Choose Starter</button>
          </div>

          <div class="pricing-card">
            <div class="pricing-header">
              <h3>Pro</h3>
              <div class="price">₦10,000<span>/month</span></div>
            </div>
            <ul class="pricing-features">
              <li>250 Products</li>
              <li>3 Premium Themes</li>
              <li>Advanced Document Analytics</li>
              <li>Custom Domain Support</li>
              <li>24/7 Priority Support</li>
              <li>Bulk Product Management</li>
            </ul>
            <button class="pricing-btn">Choose Pro</button>
          </div>

          <div class="pricing-card">
            <div class="pricing-header">
              <h3>Enterprise</h3>
              <div class="price">₦25,000<span>/month</span></div>
            </div>
            <ul class="pricing-features">
              <li>Unlimited Products</li>
              <li>5 Premium Themes</li>
              <li>Free .ng Domain</li>
              <li>Top Store Listing</li>
              <li>Dedicated Account Manager</li>
              <li>Custom Integrations</li>
              <li>Advanced Reporting</li>
            </ul>
            <button class="pricing-btn">Contact Sales</button>
          </div>
        </div>
      </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact">
      <div class="container">
        <div class="contact-content">
          <h2>Need Help?</h2>
          <p>Our friendly support team is here to help you anytime</p>
          <div class="contact-methods">
            <a :href="`tel:${supportPhone}`" class="contact-card">
              <div class="contact-icon">
                <Phone size="48" color="#0D4715" />
              </div>
              <div class="contact-info">
                <h4>Call Us</h4>
                <p>{{ supportPhone }}</p>
              </div>
            </a>
            <a :href="`mailto:${supportEmail}`" class="contact-card">
              <div class="contact-icon">
                <Mail size="48" color="#0D4715" />
              </div>
              <div class="contact-info">
                <h4>Email Us</h4>
                <p>{{ supportEmail }}</p>
              </div>
            </a>
          </div>
        </div>
      </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
      <div class="container">
        <div class="footer-content">
          <!-- Company Info -->
          <div class="footer-section company-info">
            <div class="footer-logo">
              <h3>ISellOnline</h3>
            </div>
            <p>Transform your WhatsApp conversations into a complete online store. No technical skills required - just chat and sell!</p>
            <div class="contact-info">
              <p><Phone size="16" /> {{ supportPhone }}</p>
              <p><Mail size="16" /> {{ supportEmail }}</p>
            </div>
          </div>

          <!-- Product Links -->
          <div class="footer-section">
            <h4>Product</h4>
            <ul>
              <li><a href="#features">Features</a></li>
              <li><a href="#pricing">Pricing</a></li>
              <li><a href="#how-it-works">How It Works</a></li>
              <li><a href="#">API Documentation</a></li>
              <li><a href="#">Integrations</a></li>
            </ul>
          </div>

          <!-- Company Links -->
          <div class="footer-section">
            <h4>Company</h4>
            <ul>
              <li><a href="#">About Us</a></li>
              <li><a href="#">Blog</a></li>
              <li><a href="#">Careers</a></li>
              <li><a href="#">Press</a></li>
              <li><a href="#">Partners</a></li>
            </ul>
          </div>

          <!-- Support Links -->
          <div class="footer-section">
            <h4>Support</h4>
            <ul>
              <li><a href="#contact">Contact Us</a></li>
              <li><a href="#">Help Center</a></li>
              <li><a href="#">Privacy Policy</a></li>
              <li><a href="#">Terms of Service</a></li>
              <li><a href="#">Status</a></li>
            </ul>
          </div>

          <!-- Social & Newsletter -->
          <div class="footer-section social-newsletter">
            <h4>Stay Connected</h4>
            <p>Follow us for updates and tips</p>
            <div class="social-links">
              <a href="#" aria-label="Facebook"><Facebook size="20" /></a>
              <a href="#" aria-label="Twitter"><Twitter size="20" /></a>
              <a href="#" aria-label="Instagram"><Instagram size="20" /></a>
              <a href="#" aria-label="LinkedIn"><Linkedin size="20" /></a>
              <a href="#" aria-label="YouTube"><Youtube size="20" /></a>
            </div>
            <div class="newsletter">
              <p>Get the latest updates</p>
              <div class="newsletter-input">
                <input type="email" placeholder="Enter your email" />
                <button type="submit">Subscribe</button>
              </div>
            </div>
          </div>
        </div>

        <!-- Footer Bottom -->
        <div class="footer-bottom">
          <p>&copy; 2026 ISellOnline. All rights reserved.</p>
          <div class="footer-bottom-links">
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
            <a href="#">Cookie Policy</a>
          </div>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
import {
  MessageSquareX,
  Cloud,
  Search,
  ShoppingBag,
  Globe,
  CheckCircle,
  Zap,
  Brain,
  Wrench,
  Database,
  Bell,
  Lock,
  BarChart3,
  Smartphone,
  CreditCard,
  Phone,
  Mail,
  User,
  ChefHat,
  Palette,
  Facebook,
  Twitter,
  Instagram,
  Linkedin,
  Youtube
} from 'lucide-vue-next';

export default {
  name: 'App',
  components: {
    MessageSquareX,
    Cloud,
    Search,
    ShoppingBag,
    Globe,
    CheckCircle,
    Zap,
    Brain,
    Wrench,
    Database,
    Bell,
    Lock,
    BarChart3,
    Smartphone,
    Facebook,
    Twitter,
    Instagram,
    Linkedin,
    Youtube,
    CreditCard,
    Phone,
    Mail,
    User,
    ChefHat,
    Palette
  },
  data() {
    return {
      tagline: window.tagline || 'Simple Online Stores via WhatsApp',
      supportPhone: '+1234567890',
      supportEmail: 'support@isellonline.com',
      loaded: false,
      activeFlow: 0,
      mobileMenuOpen: false,
      flows: [
        {
          name: 'Store Setup',
          steps: [
            { icon: 'MessageSquareX', title: 'Send WhatsApp Message', description: 'You start by sending a message on WhatsApp' },
            { icon: 'Cloud', title: 'Message Processing', description: 'Your message is received and processed' },
            { icon: 'Search', title: 'Account Check', description: 'We check if you have an account with us' },
            { icon: 'ShoppingBag', title: 'Quick Setup', description: 'New users go through simple setup steps' },
            { icon: 'Database', title: 'Store Creation', description: 'Your store information is saved' },
            { icon: 'Globe', title: 'Store URL Creation', description: 'We create your unique store web address' },
            { icon: 'CheckCircle', title: 'Confirmation', description: 'Your store link is sent back via WhatsApp' }
          ]
        },
        {
          name: 'Store Management',
          steps: [
            { icon: 'MessageSquareX', title: 'WhatsApp Command', description: 'You send a command through WhatsApp' },
            { icon: 'Brain', title: 'Smart Understanding', description: 'Our system understands what you want to do' },
            { icon: 'CheckCircle', title: 'Permission Check', description: 'We verify you can make this change' },
            { icon: 'Wrench', title: 'Process Request', description: 'Add products, update prices, manage stock' },
            { icon: 'Database', title: 'Save Changes', description: 'All your changes are saved securely' },
            { icon: 'Bell', title: 'WhatsApp Confirmation', description: 'You get a confirmation message on WhatsApp' }
          ]
        },
        {
          name: 'Customer Shopping',
          steps: [
            { icon: 'Globe', title: 'Visit Store', description: 'Customer finds your store online' },
            { icon: 'Search', title: 'Website Routing', description: 'Their browser connects to your store' },
            { icon: 'Cloud', title: 'Connection Routing', description: 'Request is directed to the right place' },
            { icon: 'Search', title: 'Store Recognition', description: 'System identifies your specific store' },
            { icon: 'Cloud', title: 'Data Request', description: 'Store information is retrieved' },
            { icon: 'ShoppingBag', title: 'Store Loading', description: 'Your store page appears for the customer' },
            { icon: 'Zap', title: 'Show Store', description: 'Customer sees your products and information' },
            { icon: 'CreditCard', title: 'Order & Payment', description: 'Customer places order and pays' },
            { icon: 'MessageSquareX', title: 'Order Notification', description: 'You receive order details on WhatsApp' }
          ]
        }
      ],
      features: [
        { icon: 'Zap', title: 'Quick Setup', description: 'Get your store ready in just a few minutes using WhatsApp' },
        { icon: 'Brain', title: 'Smart Assistant', description: 'Just type what you want to do in normal language' },
        { icon: 'Globe', title: 'Your Own Web Address', description: 'Get a professional web address for your store right away' },
        { icon: 'CreditCard', title: 'Easy Payments', description: 'Accept payments from customers without extra setup' },
        { icon: 'Smartphone', title: 'Works on Phones', description: 'Your store looks great and works perfectly on mobile devices' },
        { icon: 'BarChart3', title: 'Sales Tracking', description: 'See your sales and customer activity in real-time' },
        { icon: 'Bell', title: 'Order Alerts', description: 'Receive instant notifications about new orders on WhatsApp' },
        { icon: 'Lock', title: 'Safe & Secure', description: 'Your store and customer data are fully protected' }
      ]
    }
  },
  mounted() {
    setTimeout(() => {
      this.loaded = true;
    }, 100);
  },
  methods: {
    toggleMobileMenu() {
      this.mobileMenuOpen = !this.mobileMenuOpen;
    }
  }
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;600;700;800&display=swap');

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

#app {
  font-family: 'Ubuntu', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #1a1a1a;
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  min-height: 100vh;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

/* Navbar */
.navbar {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  padding: 20px 0;
  position: sticky;
  top: 0;
  z-index: 1000;
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
}

.navbar .container {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.brand-name {
  font-size: 24px;
  font-weight: 800;
  color: #0D4715;
  margin: 0;
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.nav-brand .tagline {
  font-size: 12px;
  color: #666;
  margin: 0;
}

.nav-links {
  display: flex;
  gap: 30px;
  align-items: center;
}

.nav-links a {
  color: #333;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.3s;
}

.nav-links a:hover {
  color: #0D4715;
}

.cta-btn {
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: transform 0.3s, box-shadow 0.3s;
}

.cta-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px rgba(13, 71, 21, 0.4);
}

.mobile-menu-toggle {
  display: none;
  flex-direction: column;
  background: none;
  border: none;
  cursor: pointer;
  padding: 10px;
  gap: 4px;
}

.mobile-menu-toggle span {
  width: 25px;
  height: 3px;
  background: #333;
  transition: 0.3s;
  transform-origin: center;
}

.mobile-menu-toggle.active span:nth-child(1) {
  transform: rotate(45deg) translate(5px, 5px);
}

.mobile-menu-toggle.active span:nth-child(2) {
  opacity: 0;
}

.mobile-menu-toggle.active span:nth-child(3) {
  transform: rotate(-45deg) translate(7px, -6px);
}

/* Hero Section */
.hero {
  padding: 100px 0;
  color: white;
}

.hero .container {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 60px;
  align-items: center;
}

.hero-content {
  opacity: 0;
  transform: translateY(30px);
}

.hero-content.fade-in {
  animation: fadeInUp 0.8s forwards;
}

@keyframes fadeInUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.hero-title {
  font-size: 56px;
  font-weight: 800;
  line-height: 1.2;
  margin-bottom: 20px;
}

.gradient-text {
  background: linear-gradient(135deg, #ffd89b 0%, #19547b 100%);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  display: block;
}

.hero-subtitle {
  font-size: 18px;
  line-height: 1.6;
  opacity: 0.9;
  margin-bottom: 40px;
}

.hero-cta {
  display: flex;
  gap: 20px;
}

.btn-primary, .btn-secondary {
  padding: 16px 32px;
  border-radius: 12px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
  border: none;
}

.btn-primary {
  background: white;
  color: #0D4715;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 30px rgba(255, 255, 255, 0.3);
}

.btn-secondary {
  background: rgba(255, 255, 255, 0.2);
  color: white;
  border: 2px solid white;
}

.btn-secondary:hover {
  background: rgba(255, 255, 255, 0.3);
}

/* Phone Mockup */
.hero-visual {
  opacity: 0;
  transform: translateX(30px);
}

.hero-visual.slide-in {
  animation: slideInRight 0.8s 0.3s forwards;
}

@keyframes slideInRight {
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

.phone-mockup {
  background: #1a1a1a;
  border-radius: 30px;
  padding: 20px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
}

.whatsapp-chat {
  background: #0d1418;
  border-radius: 20px;
  padding: 20px;
  height: 400px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  overflow-y: auto;
  overflow-x: hidden;
}



.chat-message {
  max-width: 70%;
  padding: 12px 16px;
  border-radius: 12px;
  animation: messageSlide 0.6s ease-out forwards;
  opacity: 0;
}

.chat-message:nth-child(1) { animation-delay: 0.2s; }
.chat-message:nth-child(2) { animation-delay: 0.6s; }
.chat-message:nth-child(3) { animation-delay: 1.0s; }
.chat-message:nth-child(4) { animation-delay: 1.4s; }
.chat-message:nth-child(5) { animation-delay: 1.8s; }
.chat-message:nth-child(6) { animation-delay: 2.2s; }
.chat-message:nth-child(7) { animation-delay: 2.6s; }
.chat-message:nth-child(8) { animation-delay: 3.0s; }
.chat-message:nth-child(9) { animation-delay: 3.4s; }
.chat-message:nth-child(10) { animation-delay: 3.8s; }
.chat-message:nth-child(11) { animation-delay: 4.2s; }
.chat-message:nth-child(12) { animation-delay: 4.6s; }
.chat-message:nth-child(13) { animation-delay: 5.0s; }
.chat-message:nth-child(14) { animation-delay: 5.4s; }
.chat-message:nth-child(15) { animation-delay: 5.8s; }
.chat-message:nth-child(16) { animation-delay: 6.2s; }
.chat-message:nth-child(17) { animation-delay: 6.6s; }
.chat-message:nth-child(18) { animation-delay: 7.0s; }
.chat-message:nth-child(19) { animation-delay: 7.4s; }
.chat-message:nth-child(20) { animation-delay: 7.8s; }

@keyframes messageSlide {
  from {
    opacity: 0;
    transform: translateY(20px) scale(0.95);
  }
  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}



.chat-message.received {
  background: #1f2c34;
  color: white;
  align-self: flex-start;
}

.chat-message.sent {
  background: #005c4b;
  color: white;
  align-self: flex-end;
}

.chat-message p {
  margin: 0;
  font-size: 14px;
  line-height: 1.4;
}

/* How It Works Section */
.how-it-works {
  background: white;
  padding: 100px 0;
}

.section-title {
  font-size: 42px;
  font-weight: 800;
  text-align: center;
  margin-bottom: 10px;
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.section-subtitle {
  text-align: center;
  font-size: 18px;
  color: #666;
  margin-bottom: 60px;
}

.flow-tabs {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-bottom: 40px;
  flex-wrap: wrap;
}

.tab-btn {
  padding: 12px 24px;
  border: 2px solid #e0e0e0;
  background: white;
  border-radius: 12px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
  color: #666;
}

.tab-btn.active {
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  color: white;
  border-color: transparent;
  box-shadow: 0 5px 20px rgba(13, 71, 21, 0.3);
}

.tab-btn:hover:not(.active) {
  border-color: #0D4715;
  color: #0D4715;
}

.flow-steps {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 20px;
}

.step-card {
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  border-radius: 16px;
  padding: 24px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  animation: fadeInScale 0.5s ease-out backwards;
  transition: transform 0.3s, box-shadow 0.3s;
}

@keyframes fadeInScale {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.step-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
}

.step-number {
  width: 40px;
  height: 40px;
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  color: white;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 18px;
}

.step-content h3 {
  font-size: 18px;
  font-weight: 700;
  color: #1a1a1a;
  margin: 0;
}

.step-content p {
  font-size: 14px;
  color: #666;
  margin: 0;
  line-height: 1.5;
}

.step-icon {
  font-size: 32px;
  text-align: right;
}

/* Features Section */
.features {
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  padding: 100px 0;
  color: white;
}

.features .section-title {
  color: white;
  background: none;
  -webkit-text-fill-color: white;
}

.features .section-subtitle {
  color: rgba(255, 255, 255, 0.9);
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
}

.feature-card {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  padding: 30px;
  text-align: center;
  transition: all 0.3s;
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.feature-card:hover {
  background: rgba(255, 255, 255, 0.2);
  transform: translateY(-5px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
}

.feature-icon {
  font-size: 48px;
  margin-bottom: 20px;
}

.feature-card h3 {
  font-size: 20px;
  font-weight: 700;
  margin-bottom: 10px;
}

.feature-card p {
  font-size: 14px;
  opacity: 0.9;
  line-height: 1.6;
}

/* Testimonials Section */
.testimonials {
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  padding: 100px 0;
}

.testimonials .section-title {
  color: #1a1a1a;
  background: none;
  -webkit-text-fill-color: #1a1a1a;
}

.testimonials .section-subtitle {
  color: #666;
}

.testimonials-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  margin-top: 60px;
}

.testimonial-card {
  background: white;
  border-radius: 16px;
  padding: 30px;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s, box-shadow 0.3s;
}

.testimonial-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
}

.testimonial-content p {
  font-size: 16px;
  line-height: 1.6;
  color: #333;
  margin-bottom: 20px;
  font-style: italic;
}

.testimonial-author {
  display: flex;
  align-items: center;
  gap: 15px;
}

.author-avatar {
  width: 50px;
  height: 50px;
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
}

.author-info h4 {
  font-size: 16px;
  font-weight: 700;
  color: #1a1a1a;
  margin: 0;
}

.author-info p {
  font-size: 14px;
  color: #666;
  margin: 0;
}

/* Pricing Section */
.pricing {
  background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
  padding: 100px 0;
}

.pricing .section-title {
  color: #1a1a1a;
  background: none;
  -webkit-text-fill-color: #1a1a1a;
}

.pricing .section-subtitle {
  color: #666;
}

.pricing-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 30px;
  margin-top: 60px;
}

@media (min-width: 1200px) {
  .pricing-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}

.pricing-card {
  background: white;
  border-radius: 16px;
  padding: 40px 30px;
  text-align: center;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s, box-shadow 0.3s;
  position: relative;
  border: 2px solid transparent;
}

.pricing-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
}

.pricing-card.popular {
  border-color: #0D4715;
  transform: scale(1.05);
}

.pricing-card.popular:hover {
  transform: scale(1.05) translateY(-5px);
}

.pricing-badge {
  position: absolute;
  top: -12px;
  left: 50%;
  transform: translateX(-50%);
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  color: white;
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
  text-transform: uppercase;
}

.pricing-header h3 {
  font-size: 24px;
  font-weight: 700;
  color: #1a1a1a;
  margin-bottom: 10px;
}

.price {
  font-size: 36px;
  font-weight: 800;
  color: #0D4715;
  margin-bottom: 30px;
}

.price span {
  font-size: 16px;
  font-weight: 400;
  color: #666;
}

.pricing-features {
  list-style: none;
  padding: 0;
  margin: 30px 0;
  text-align: left;
}

.pricing-features li {
  padding: 8px 0;
  color: #555;
  position: relative;
  padding-left: 20px;
}

.pricing-features li:before {
  content: "✓";
  color: #0D4715;
  font-weight: bold;
  position: absolute;
  left: 0;
}

.pricing-btn {
  width: 100%;
  padding: 14px 24px;
  border: 2px solid #0D4715;
  background: transparent;
  color: #0D4715;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
  margin-top: 20px;
}

.pricing-btn:hover {
  background: #0D4715;
  color: white;
}

.pricing-btn.primary {
  background: #0D4715;
  color: white;
}

.pricing-btn.primary:hover {
  background: #1a7a2e;
}

/* Contact Section */
.contact {
  background: white;
  padding: 100px 0;
}

.contact-content {
  text-align: center;
  max-width: 800px;
  margin: 0 auto;
}

.contact-content h2 {
  font-size: 42px;
  font-weight: 800;
  margin-bottom: 10px;
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.contact-content > p {
  font-size: 18px;
  color: #666;
  margin-bottom: 40px;
}

.contact-methods {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  margin-top: 40px;
}

.contact-card {
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  border-radius: 16px;
  padding: 30px;
  display: flex;
  align-items: center;
  gap: 20px;
  text-decoration: none;
  color: inherit;
  transition: all 0.3s;
}

.contact-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
}

.contact-icon {
  font-size: 48px;
}

.contact-info {
  text-align: left;
}

.contact-info h4 {
  font-size: 18px;
  font-weight: 700;
  margin-bottom: 5px;
  color: #1a1a1a;
}

.contact-info p {
  font-size: 16px;
  color: #0D4715;
  font-weight: 600;
  margin: 0;
}

/* Footer */
.footer {
  background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
  color: white;
  padding: 60px 0 20px;
  margin-top: 60px;
}

.footer-content {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1fr 1.5fr;
  gap: 40px;
  margin-bottom: 40px;
}

.footer-section {
  min-width: 0;
}

.footer-section h4 {
  color: white;
  font-size: 18px;
  font-weight: 700;
  margin-bottom: 20px;
  position: relative;
}

.footer-section h4::after {
  content: '';
  position: absolute;
  bottom: -5px;
  left: 0;
  width: 30px;
  height: 2px;
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  border-radius: 1px;
}

.footer-section ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-section ul li {
  margin-bottom: 12px;
}

.footer-section ul li a {
  color: rgba(255, 255, 255, 0.7);
  text-decoration: none;
  font-size: 14px;
  transition: all 0.3s;
  display: inline-block;
}

.footer-section ul li a:hover {
  color: white;
  transform: translateX(5px);
}

/* Company Info */
.company-info .footer-logo {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 16px;
}

.footer-logo-img {
  width: 40px;
  height: 40px;
  border-radius: 8px;
}

.company-info h3 {
  font-size: 20px;
  font-weight: 800;
  color: white;
  margin: 0;
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.company-info > p {
  color: rgba(255, 255, 255, 0.8);
  font-size: 14px;
  line-height: 1.6;
  margin-bottom: 20px;
}

.contact-info p {
  display: flex;
  align-items: center;
  gap: 8px;
  color: rgba(255, 255, 255, 0.7);
  font-size: 14px;
  margin: 8px 0;
}

.contact-info svg {
  color: #0D4715;
  flex-shrink: 0;
}

/* Social Links */
.social-links {
  display: flex;
  gap: 16px;
  margin: 20px 0;
}

.social-links a {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  color: rgba(255, 255, 255, 0.7);
  text-decoration: none;
  transition: all 0.3s;
}

.social-links a:hover {
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  color: white;
  transform: translateY(-2px);
  box-shadow: 0 5px 15px rgba(13, 71, 21, 0.3);
}

/* Newsletter */
.newsletter p {
  color: rgba(255, 255, 255, 0.8);
  font-size: 14px;
  margin: 16px 0 12px;
}

.newsletter-input {
  display: flex;
  gap: 8px;
  margin-top: 12px;
}

.newsletter-input input {
  flex: 1;
  padding: 10px 16px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 6px;
  background: rgba(255, 255, 255, 0.1);
  color: white;
  font-size: 14px;
}

.newsletter-input input::placeholder {
  color: rgba(255, 255, 255, 0.5);
}

.newsletter-input input:focus {
  outline: none;
  border-color: #0D4715;
  background: rgba(255, 255, 255, 0.15);
}

.newsletter-input button {
  padding: 10px 16px;
  background: linear-gradient(135deg, #0D4715 0%, #1a7a2e 100%);
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.newsletter-input button:hover {
  background: linear-gradient(135deg, #1a7a2e 0%, #0D4715 100%);
  transform: translateY(-1px);
  box-shadow: 0 3px 10px rgba(13, 71, 21, 0.3);
}

/* Footer Bottom */
.footer-bottom {
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  padding-top: 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 20px;
}

.footer-bottom p {
  color: rgba(255, 255, 255, 0.6);
  font-size: 14px;
  margin: 0;
}

.footer-bottom-links {
  display: flex;
  gap: 24px;
}

.footer-bottom-links a {
  color: rgba(255, 255, 255, 0.6);
  text-decoration: none;
  font-size: 14px;
  transition: color 0.3s;
}

.footer-bottom-links a:hover {
  color: white;
}

/* Transitions */
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.3s, transform 0.3s;
}

.fade-enter-from {
  opacity: 0;
  transform: translateY(10px);
}

.fade-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}

/* Responsive */
@media (max-width: 768px) {
  .navbar .container {
    position: relative;
  }

  .mobile-menu-toggle {
    display: flex;
  }

  .nav-links {
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    flex-direction: column;
    padding: 20px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
    transform: translateY(-100%);
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s;
    gap: 15px;
    align-items: flex-start;
  }

  .nav-links.mobile-open {
    transform: translateY(0);
    opacity: 1;
    visibility: visible;
  }

  .nav-links a, .nav-links .cta-btn {
    width: 100%;
    text-align: left;
    padding: 10px 0;
  }

  .hero .container {
    grid-template-columns: 1fr;
  }

  .hero-title {
    font-size: 36px;
  }

  .flow-steps {
    grid-template-columns: 1fr;
  }

  .hero-cta {
    flex-direction: column;
  }

  .btn-primary, .btn-secondary {
    width: 100%;
  }

  .testimonials-grid {
    grid-template-columns: 1fr;
  }

  .pricing-grid {
    grid-template-columns: 1fr;
  }

  .pricing-card.popular {
    transform: none;
  }

  .pricing-card.popular:hover {
    transform: translateY(-5px);
  }

  /* Footer Mobile */
  .footer {
    padding: 40px 0 20px;
    margin-top: 40px;
  }

  .footer-content {
    grid-template-columns: 1fr;
    gap: 30px;
    margin-bottom: 30px;
  }

  .company-info {
    text-align: center;
  }

  .company-info .footer-logo {
    justify-content: center;
  }

  .social-links {
    justify-content: center;
  }

  .newsletter-input {
    flex-direction: column;
  }

  .newsletter-input button {
    width: 100%;
  }

  .footer-bottom {
    flex-direction: column;
    text-align: center;
    gap: 16px;
  }

  .footer-bottom-links {
    justify-content: center;
  }
}
</style>