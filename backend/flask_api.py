from flask import Flask, request, jsonify
from flask_cors import CORS
import os
import time
from datetime import datetime
import uuid
import traceback
import google.generativeai as genai
from dotenv import load_dotenv
import json  # Added this import

app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "http://localhost:*"}})  # Allow localhost for Flutter testing

load_dotenv()

# Configure the Gemini API
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY", "")
if not GEMINI_API_KEY:
    raise ValueError("GEMINI_API_KEY not found in .env file. Please set it up.")
genai.configure(api_key=GEMINI_API_KEY)

class GeminiAssistant:
    def __init__(self):
        self.conversations = {}
        if os.path.exists('conversations.json'):
            try:
                with open('conversations.json', 'r') as f:
                    self.conversations = json.load(f)  # Use json.load
            except:
                pass
    
    def load_conversations(self):
        return self.conversations
    
    def save_conversations(self, conversations):
        with open('conversations.json', 'w') as f:
            json.dump(conversations, f, indent=4)  # Use json.dump
    
    def answer(self, prompt, client_id='anonymous'):
        try:
            # Load conversation history
            history = self.conversations.get(client_id, [])
            
            # Add query to history
            history.append({"timestamp": datetime.now().isoformat(), "query": prompt, "role": "user"})
            
            # Prepare the prompt
            system_message = """You are Rafiki, a specialized mental health counselor for Kenyan university students.
            When responding:
            1. Always address the emotional or psychological concern first
            2. Provide specific, actionable advice for students
            3. Consider academic stress, social challenges, and career worries
            4. Keep responses short and supportive
            5. Never talk about yourself, your capabilities, or your development
            6. Always respond as if you are speaking directly to a student seeking help
            7. For Kenyan students, include Swahili phrases where appropriate, but do not use asterisks (*) for emphasis—write them plainly (e.g., 'Hakuna matata' instead of '*Hakuna matata*')
            8. Focus on practical mental health techniques
            9.Make it short and coversational like dialogues a counsellor and a student seeking guidance and counselling also
            10 make it flow like a converison 100 words or less for each response"""
            
            # Create context from recent history
            recent_messages = history[-5:] if len(history) > 5 else history
            context = "\n".join([f"{msg['role']}: {msg['query']}" for msg in recent_messages])
            
            # Create the full prompt for Gemini
            full_prompt = f"{system_message}\n\nConversation history:\n{context}\n\nUser: {prompt}\n"
            
            # Set up the Gemini model
            model = genai.GenerativeModel('gemini-1.5-flash-002')  # Use latest flash model
            
            # Generate response
            response = model.generate_content(full_prompt)
            
            # Extract and format the text, removing any remaining special characters
            response_text = response.text.strip()
            response_text = response_text.replace('*', '').replace('(', '').replace(')', '')  # Clean special characters
            response_text = f"Rafiki: {response_text}"
            
            # Add response to history
            history.append({"timestamp": datetime.now().isoformat(), "query": response_text, "role": "assistant"})
            self.conversations[client_id] = history
            self.save_conversations(self.conversations)
            
            return response_text
        except Exception as e:
            print(f"Error processing response: {e}")
            traceback.print_exc()
            return "Rafiki: I'm having trouble processing your question. Can you try again?"

# Create a global instance
assistant = GeminiAssistant()

@app.route('/api/chat', methods=['POST'])
def chat():
    try:
        data = request.json
        user_message = data.get('message', '')
        client_id = data.get('client_id', 'anonymous')
        
        if not user_message:
            return jsonify({"error": "No message provided"}), 400
        
        # Process the message directly
        response_text = assistant.answer(user_message, client_id)
        
        # Return the response
        return jsonify({
            "status": "success",
            "client_id": client_id,
            "response": response_text,
            "timestamp": datetime.now().isoformat()
        })
    
    except Exception as e:
        print(f"Error in chat endpoint: {e}")
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500

@app.route('/api/history', methods=['GET'])
def get_history():
    try:
        client_id = request.args.get('client_id', 'anonymous')
        
        history = assistant.load_conversations().get(client_id, [])
        
        return jsonify({
            "client_id": client_id,
            "history": history
        })
    
    except Exception as e:
        print(f"Error fetching history: {e}")
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500

@app.route('/api/health', methods=['GET'])
def health_check():
    return jsonify({
        "status": "ok", 
        "model": "Gemini Pro",
        "version": "1.0.0",
        "timestamp": datetime.now().isoformat()
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)