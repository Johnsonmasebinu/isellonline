# ISellOnline - WhatsApp E-commerce Platform

<p align="center">
  <img src="https://img.shields.io/badge/Laravel-11-red.svg" alt="Laravel">
  <img src="https://img.shields.io/badge/Vue.js-3-green.svg" alt="Vue.js">
  <img src="https://img.shields.io/badge/MySQL-8.0-blue.svg" alt="MySQL">
  <img src="https://img.shields.io/badge/Docker-Ready-blue.svg" alt="Docker">
</p>

## 🚀 About ISellOnline

ISellOnline is an AI-powered WhatsApp-first e-commerce platform that allows users to create and manage online stores through simple WhatsApp messages. No technical skills required - just chat and sell!

### ✨ Key Features

- **WhatsApp Integration**: Manage your store entirely through WhatsApp
- **AI-Powered**: Intelligent conversation handling
- **Custom Domains**: Professional web presence
- **Payment Integration**: Secure payment processing
- **Analytics Dashboard**: Real-time sales insights
- **Mobile-First Design**: Optimized for all devices

## 🛠️ Tech Stack

- **Backend**: Laravel 11 (PHP 8.2)
- **Frontend**: Vue.js 3 with Vite
- **Database**: MySQL 8.0 (runs in same container)
- **Styling**: Tailwind CSS
- **Icons**: Lucide Vue
- **Deployment**: Docker (single container)

## 📋 Prerequisites

- Docker & Docker Compose
- Git
- Node.js 18+ (for local development)

## 🚀 Quick Start

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/Johnsonmasebinu/isellonline.git
   cd isellonline
   ```

2. **Environment Setup**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Start with Docker**
   ```bash
   docker-compose up -d
   ```

4. **Install Dependencies**
   ```bash
   composer install
   npm install
   ```

5. **Build Assets**
   ```bash
   npm run build
   ```

6. **Run Migrations**
   ```bash
   php artisan migrate
   ```

7. **Access the Application**
   - Frontend: http://localhost
   - API: http://localhost/api

## 🐳 Production Deployment

### Single Container Deployment (Recommended)

The application now runs MySQL in the same container for simplified deployment:

```bash
# Build and run with docker-compose
docker-compose -f docker-compose.prod.yml up -d

# Or deploy directly with Docker
docker build -t isellonline .
docker run -d -p 80:80 -v mysql_data:/var/lib/mysql isellonline
```

### Environment Variables

```env
# Application
APP_URL=https://isellonline.website
APP_KEY=your-generated-app-key
SUPPORT_PHONE=+1234567890
SUPPORT_EMAIL=support@isellonline.website
TAGLINE="AI- WhatsApp First E-commerce Creator"

# Database (MySQL runs in same container)
DB_HOST=127.0.0.1
DB_DATABASE=isellonline
DB_USERNAME=isellonline_user
DB_PASSWORD=isellonline_password
```

### Multi-Container Deployment (Dockploy)

If you prefer separate containers, set the database service name:

```env
DB_HOST=your-database-service-name
```

### 3. Post-Deployment

```bash
# Generate app key (if not set)
php artisan key:generate

# Run migrations
php artisan migrate

# Clear cache
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

## 📁 Project Structure

```
isellonline/
├── app/                    # Laravel application code
├── resources/
│   ├── js/                # Vue.js frontend
│   └── css/               # Stylesheets
├── routes/                # API routes
├── database/              # Migrations & seeders
├── docker/                # Docker configurations
├── .dockploy/            # Dockploy deployment config
├── public/               # Static assets
├── Dockerfile            # Docker build config
├── docker-compose.yml    # Local development
└── docker-compose.prod.yml # Production setup
```

## 🔧 Development Commands

```bash
# Start development server
npm run dev

# Build for production
npm run build

# Run tests
php artisan test

# Run linting
npm run lint

# Database operations
php artisan migrate
php artisan db:seed
```

## 🌐 API Documentation

API documentation is automatically generated using Scribe. Access it at:
- Local: http://localhost/docs
- Production: https://isellonline.website/docs

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

- **Email**: support@isellonline.website
- **Phone**: +1234567890
- **WhatsApp**: Connect with us on WhatsApp for instant support

## 🔗 Links

- **Website**: https://isellonline.website
- **GitHub**: https://github.com/Johnsonmasebinu/isellonline
- **Documentation**: https://isellonline.website/docs

---

**Built with ❤️ for entrepreneurs who want to sell online without the technical hassle.**
