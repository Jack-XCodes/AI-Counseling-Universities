 # RafikiAI Backend

This is the backend for RafikiAI, an AI-powered counseling platform for Kenyan university students, built using Python, Flask, and the Google Gemini Flash API (`gemini-1.5-flash-latest` or `gemini-2.0-flash`). It provides RESTful APIs for text-based counseling, integrated with the Flutter frontend, and is designed to be free, simple, and collapse-proof for Kenya.

## Overview
The backend handles:
- Text responses using Google Gemini Flash API for mental health, career guidance, and personal development.
- Conversation history storage in `conversations.json`.
- API endpoints (`/api/chat`, `/api/history`, `/api/health`) for real-time interaction with the Flutter frontend.

## Prerequisites
- **Python 3.9+** (recommended: 3.12 for Gemini compatibility—free from python.org).
- **Git** (for cloning, free from git-scm.com).
- **Virtual Environment** (optional but recommended for dependency isolation—free, collapse-proof for Kenya).
- **Google Gemini API Key** (free tier, 15 req/min, 1M tokens/month—register at ai.google.dev, upgrade to $0.125/1M tokens if needed).

## Installation

### 1. Clone the Repository
Navigate to your desired directory and clone the RafikiAI repository:
```bash
git clone https://github.com/Jack-XCodes/AI-Counseling-Universities/
cd rafiki-ai-counseling/backend
```

### 2. Set Up Virtual Environment
Create and activate a virtual environment (Windows, using CMD or PowerShell):
```cmd
python -m venv venv
venv\Scripts\activate
```
- Ensure `venv` is in `.gitignore` to avoid tracking (free, simple, collapse-proof).

### 3. Install Dependencies
Install required Python packages from `requirements.txt`:
```bash
pip install -r requirements.txt
```
- `requirements.txt` includes:
  ```plaintext
  flask==3.0.0
  flask-cors==5.0.0
  google-generativeai==0.7.2
  dotenv==1.0.1  # For .env, free
  ```

### 4. Configure Environment Variables
Create a `.env` file in the `backend` directory with your Google Gemini API key:
```plaintext
GEMINI_API_KEY=your_gemini_api_key_here
```
- Do not commit `.env` to Git (add to `.gitignore` in the root)—free, secure, collapse-proof for Kenya.

## Running the Backend
Start the Flask development server (for local testing, not production—use DigitalOcean/Render for production, $5/month or free tier):
```bash
python flask_api.py
```
- Output: "Running on http://0.0.0.0:5000" (access via `http://localhost:5000` or `http://10.0.2.2:5000` for Android emulator).
- Test endpoints with `curl`:
  ```bash
  curl -X POST -H "Content-Type: application/json" -d '{"message": "hello", "client_id": "anonymous"}' http://localhost:5000/api/chat
  curl http://localhost:5000/api/history?client_id=anonymous
  ```

## Deployment
For production, deploy to DigitalOcean ($5/month) or Render (free tier):
- Use Git, SSH, or dashboard to deploy `flask_api.py`, `requirements.txt`, and `.env`.
- Update frontend (`main.dart`) to use the online backend URL (e.g., `https://your-backend-domain`).

## API Endpoints
- **GET /api/history?client_id={client_id}**: Fetch conversation history (e.g., `client_id=anonymous`).
- **POST /api/chat**: Send a message and get a response (JSON: `{"message": "text", "client_id": "anonymous"}`).
- **GET /api/health**: Check backend health (returns JSON status).

## Contributing
- Fork the repository, create a branch, submit pull requests—free, open-source, collapse-proof for Kenya.
- Report issues on GitHub: [https://github.com/Jack-XCodes/AI-Counseling-Universities/]

## License
This project is licensed under the Apache 2.0 License—free, simple, collapse-proof for Kenya (see root `LICENSE`).

## Acknowledgements
- Google Gemini Flash API (`gemini-1.5-flash-latest` or `gemini-2.0-flash`) for AI counseling—free tier, $0.125/1M tokens paid.
- Flask and Python communities for open-source tools.