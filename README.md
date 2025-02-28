# RafikiAI: AI-Powered Counseling Platform for Kenyan University Students

RafikiAI is a simple AI-powered counseling platform designed specifically for Kenyan university students. The application provides mental health support, career guidance, and personal development assistance through a text-based interface powered by Google's Gemini Flash API.

![RafikiAI Logo](path/to/logo.png) <!-- You can add your logo image here -->

## Project Overview

RafikiAI consists of two main components:

1. **Flutter Frontend**: A responsive mobile and web interface with a ChatGPT-like experience
2. **Python/Flask Backend**: RESTful API service that processes requests using Google Gemini AI

The platform is designed to be:
- **Free to use**: Leveraging Google Gemini's free tier (1M tokens/month)
- **Simple**: Text-only interface accessible on basic devices and connections
- **Collapse-proof**: Works reliably in the Kenyan context with intermittent connectivity
- **Privacy-focused**: Secure conversation storage and minimal data collection

## Key Features

- **Mental Health Support**: AI-guided discussions on stress, anxiety, and emotional well-being
- **Career Guidance**: Help with course selection, job hunting, and professional development
- **Personal Development**: Assistance with study habits, time management, and goal setting
- **Conversation History**: Saved discussions for continuity of support
- **Multi-platform**: Works on Android devices and web browsers

## Project Structure

```
rafiki-ai-counseling/
├── backend/                  # Flask API server and AI integration
│   ├── flask_api.py          # Main API server code
│   ├── requirements.txt      # Python dependencies
│   └── README.md             # Backend documentation
├── frontend/                 # Flutter mobile and web application
│   ├── lib/                  # Dart/Flutter source code
│   ├── pubspec.yaml          # Flutter dependencies
│   └── README.md             # Frontend documentation
├── LICENSE                   # Apache 2.0 License
└── README.md                 # This file
```

## Getting Started

### Prerequisites

- **Backend**: Python 3.9+, Git, Google Gemini API Key
- **Frontend**: Flutter 3.16.0+, Git, Android Studio (optional)
- **Development**: VS Code with Flutter and Python extensions (recommended)

### Quick Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Jack-XCodes/AI-Counseling-Universities/
   cd rafiki-ai-counseling
   ```

2. **Set Up Backend**
   ```bash
   cd backend
   python -m venv venv
   venv\Scripts\activate  # On Windows
   pip install -r requirements.txt
   # Create .env file with your GEMINI_API_KEY
   python flask_api.py
   ```

3. **Set Up Frontend**
   ```bash
   cd ../frontend
   flutter pub get
   flutter run -d chrome  # For web
   # OR
   flutter run             # For Android emulator/device
   ```

For detailed setup instructions, see the README files in the `backend/` and `frontend/` directories.

## Deployment

- **Backend**: Deploy to DigitalOcean ($5/month) or Render (free tier)
- **Frontend**: Deploy web version to GitHub Pages (free) or Firebase Hosting (free tier)
- **Mobile**: Generate APK for direct installation or publish to Google Play Store

## Contributing

Contributions to RafikiAI are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the Apache 2.0 License - see the LICENSE file for details.

## Team

- **Jacob Kasunzu John** - Lead Developer - [GitHub](https://github.com/Jack-XCodes)
- **Kimani Geoffrey Chege** - Developer - [GitHub](https://github.com/Jeff-kimani)

## Acknowledgements

- Google Gemini Flash API (`gemini-1.5-flash-latest` or `gemini-2.0-flash`) for AI counseling capabilities
- Flutter and Dart for cross-platform UI development
- Flask and Python communities for backend tools
- All contributors and supporters of mental health initiatives in Kenyan universities

---

Developed with ❤️ for Kenyan university students
