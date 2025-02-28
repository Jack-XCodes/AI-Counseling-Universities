# RafikiAI Project Roadmap

## Overview
RafikiAI is an AI-powered counseling platform for Kenyan university students, using Google Gemini Flash API (`gemini-1.5-flash-latest` or `gemini-2.0-flash`) for text-based mental health support, built with Flutter (frontend) and Flask (backend).

## Milestones

### Phase 1: Initial Development (Completed - February 2025)
- **Goal**: Build a functional prototype with text-only ChatGPT-like UI.
- **Tasks**:
  - Set up Flutter frontend for web/Android (`main.dart`, `pubspec.yaml`).
  - Implement Flask backend with Gemini Flash API (`flask_api.py`, `requirements.txt`).
  - Integrate backend with frontend for real-time text responses.
  - Test locally on web (Chrome) and Android emulator.
- **Status**: Completed (as of February 26, 2025).

### Phase 2: Testing and Optimization (March 2025)
- **Goal**: Enhance responsiveness, fix bugs, and optimize performance.
- **Tasks**:
  - Test on multiple Android devices/emulators, ensure collapse-proof operation.
  - Optimize Gemini Flash API calls for speed (e.g., reduce latency, handle rate limits: 15 req/min, 1M tokens/month free tier).
  - Improve UI/UX for ChatGPT-like flow (immediate response, no delays).
  - Conduct user testing with Kenyan university students (focus groups, feedback).
- **Timeline**: March 1–15, 2025.

### Phase 3: Deployment and Scaling (April 2025)
- **Goal**: Deploy to production, scale for Kenyan universities.
- **Tasks**:
  - Host backend on DigitalOcean ($5/month) or Render (free tier) for collapse-proof operation.
  - Update `main.dart` for online backend URL (e.g., `https://your-backend-domain`).
  - Add user authentication (e.g., Google Sign-In, student IDs) using `shared_preferences` or Firebase (optional, free/low-cost).
  - Monitor usage, handle Gemini API quotas, ensure free/low-cost access for students.
- **Timeline**: April 1–30, 2025.

### Phase 4: Expansion and Research (May–June 2025)
- **Goal**: Expand features, publish research, and engage stakeholders.
- **Tasks**:
  - Add multilingual support (Swahili, English) using Gemini Flash’s capabilities.
  - Conduct academic research on RafikiAI’s impact on Kenyan students’ mental health (paper draft in `docs/PAPER_DRAFT.md`).
  - Present at university conferences, pitch to NGOs/funders (PPT in `docs/PITCH_PPT.pdf`).
  - Explore funding for sustainability, maintain free/low-cost access.
- **Timeline**: May 1–June 30, 2025.

## Risks and Mitigations
- **Risk**: Gemini API rate limits (15 req/min, 1M tokens/month free tier).
  - **Mitigation**: Batch requests, monitor usage, upgrade to paid tier if needed ($0.125/1M tokens, collapse-proof with DigitalOcean/Render).
- **Risk**: Internet outages in Kenya (CBK collapse risk).
  - **Mitigation**: Use local backups, offline testing, cloud hosting with redundancy.

## Contributors
- [Your Name] (Developer, Lead)
- Open to collaborators (GitHub Issues/PRs, free, collapse-proof).

## Tools
- Flutter 3.16.0 (frontend, Android/web)
- Flask 3.0.0 (backend)
- Google Gemini Flash API (`gemini-1.5-flash-latest` or `gemini-2.0-flash`)
- VS Code/Android Studio (development)
- DigitalOcean/Render (hosting, $5/month or free tier)