# MediMitra: AI-Powered Personal Health Copilot 🩺✨

**MediMitra** is an intelligent, compassionate personal health copilot designed to help individuals and caregivers organize, understand, and navigate their healthcare journeys. 

Built with multimodal AI (Google Gemini), a high-density clinical dashboard, multilingual biomarkers explainer (English, Hindi, and Tamil), longitudinal trend charts, source-grounded RAG chat, medication adherence tracking, and safety triage with an emergency **Call 108** escalation path.

---

## 🏛️ System Architecture Diagram

```
+---------------------------------------------------------------------------------------------------+
|                                     MEDIMITRA CLIENT FRONTEND                                     |
|  - Next.js (App Router) + TypeScript + Tailwind CSS + Lucide Icons                                |
|  - Accessibility: Large-Text scaling, Dark/Light modes, Voice Web Speech dictation                |
|  - Multilingual Biomarkers Explainer: English, हिन्दी (Hindi), தமிழ் (Tamil)                         |
|  - Family Profile Switcher: Ramesh Kumar (Father) | Priya Sharma (Self) | Aarav (Child)           |
+---------------------------------------------------------------------------------------------------+
                                                  |
                                                  | REST API JSON / Multipart Form
                                                  v
+---------------------------------------------------------------------------------------------------+
|                                        FASTAPI BACKEND                                            |
|  - /api/auth          : Simple email login, consent screen, zero-knowledge data purge             |
|  - /api/patients      : Multi-profile family records management                                   |
|  - /api/records       : Multimodal OCR & extraction, report vault, sample loader                  |
|  - /api/explain       : Biomarker explainer in EN/HI/TA with lifestyle suggestions                |
|  - /api/timeline      : Chronological timeline & biomarker trend chart metrics                    |
|  - /api/chat          : RAG Copilot with citations, confidence scores, & safety disclaimers       |
|  - /api/medications   : Drug schedules, adherence tracking, interaction & refill warnings        |
|  - /api/triage        : Symptom triage engine (Self-Care / Doctor / EMERGENCY CALL 108)          |
|  - /api/doctor-prep   : 1-Page physician visit brief & shareable print/PDF view                   |
|  - /api/insights      : Proactive pattern alerts & MediMitra health score engine                  |
+---------------------------------------------------------------------------------------------------+
                  |                                                  |
                  v                                                  v
+---------------------------------------+          +------------------------------------------------+
|       AI ENGINE (GEMINI SERVICE)      |          |               STORAGE & DATABASE               |
| - Gemini 2.5 Flash / Configurable     |          | - SQLite (SQLAlchemy ORM)                      |
| - Multimodal document parser          |          | - Vector embeddings + cosine distance search   |
| - Structured JSON outputs with schema |          | - Encrypted at rest (AES-256 standard)         |
| - Robust clinical fallback mode       |          | - Realistic demo seed data for 2 demo patients |
+---------------------------------------+          +------------------------------------------------+
```

---

## 🚀 Quickstart & Setup Guide

### Prerequisites
- Python 3.10+
- Node.js 18+ (tested on Node v24 LTS with npm 11+)

### 1. Backend Setup (FastAPI)
```bash
# Navigate to backend directory
cd backend

# (Optional) Create & activate a virtual environment
python -m venv venv
# Windows:
venv\Scripts\activate
# Linux/Mac:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Configure Environment Variables
cp .env.example .env
# Optional: Set your GEMINI_API_KEY in .env.
# If no key is set, MediMitra automatically runs in its intelligent clinical fallback mode.

# Run backend server
python run_backend.py
# Or with uvicorn directly:
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```
Backend API will be live at: **http://localhost:8000**  
Interactive Swagger docs: **http://localhost:8000/docs**

### 2. Frontend Setup (Next.js)
```bash
# In a new terminal, navigate to frontend directory
cd frontend

# Install packages
npm install

# Start Next.js development server
npm run dev
```
Frontend App will be live at: **http://localhost:3000**

---

## 👥 Seeded Realistic Demo Patients

The database automatically seeds realistic medical records on initial startup:

### 1. Ramesh Kumar (58 / M) – Father (Managed Profile)
- **Clinical History:** Type 2 Diabetes Mellitus (12 years), Primary Hypertension, Dyslipidemia. Known allergy to Sulphonamides.
- **Longitudinal Trend (8 Months):**
  - **HbA1c:** Rising from 6.8% (Feb) ➔ 7.4% (Jun) ➔ **8.2% (Oct - Critical Trend)**
  - **Fasting Blood Sugar:** 126 mg/dL ➔ 148 mg/dL ➔ **172 mg/dL**
  - **Systolic BP:** 132 mmHg ➔ 138 mmHg ➔ **146 mmHg (Stage 2 HTN)**
  - **LDL Cholesterol:** 110 mg/dL ➔ 128 mg/dL ➔ **142 mg/dL**
- **Active Medications:** Metformin 500mg (*Refill alert: 3 days remaining!*), Glimepiride 1mg, Telmisartan 40mg, Atorvastatin 10mg.
- **Safety Alerts:** Telmisartan + NSAID (Diclofenac) drug interaction warning (renal risk).

### 2. Priya Sharma (28 / F) – Account Owner (Self)
- **Clinical History:** Subclinical Hypothyroidism, Mild Iron Deficiency Anemia.
- **Positive Recovery Trend:**
  - **TSH:** Lowered from 7.20 mIU/L ➔ **4.80 mIU/L** (normalizing on Levothyroxine)
  - **Hemoglobin:** Restored from 10.4 g/dL ➔ **11.6 g/dL**
- **Medication Absorption Rule:** 4-hour required separation between morning Levothyroxine and evening Iron tablet.

---

## ⏱️ 2-Minute Demo Script & Walkthrough

| Step | Action | What to Observe |
|---|---|---|
| **1. Home Dashboard** | Open `http://localhost:3000` | • **Health Score (82/100)** with category breakdown.<br>• **Proactive Insights**: "HbA1c Rising Over 3 Consecutive Reports" & "Refill Due in 3 Days: Metformin 500mg".<br>• Today's Medication schedule with one-click **Mark Taken** checkbox. |
| **2. Health Record Vault** | Click **Record Vault** tab | • View stored Apollo & Fortis lab scans.<br>• Click **View Details & JSON** to see multimodal OCR structured extraction.<br>• Try drag-and-drop upload or the **+ Sample Report** quick loader. |
| **3. Smart Report Explainer** | Click **Smart Explainer** tab | • Review lab biomarker cards (HbA1c, Fasting Sugar, BP, LDL, Creatinine).<br>• Toggle language pills between **English**, **हिन्दी**, and **தமிழ்** to see instant localized explanations and nutritional tips. |
| **4. Timeline & Trends** | Click **Timeline & Trends** tab | • Interactive SVG line chart with green reference normal band.<br>• Switch metrics between **HbA1c**, **Systolic BP**, and **Fasting Blood Sugar** to observe progression.<br>• Scroll through the chronological event feed. |
| **5. Chat Copilot (RAG)** | Click **Chat Copilot** tab | • Click prompt pill: *"What was my last sugar level?"*<br>• Observe verified answer grounded in records with **clickable source citations** (`[Diabetic Review Q2]`), confidence rating (96%), and disclaimer.<br>• Test the **Microphone (Voice Input)** button. |
| **6. Medication Manager** | Click **Medications** tab | • Check Morning, Afternoon, Evening, Bedtime slots.<br>• Check adherence streak (14 days) and drug interaction warnings (Telmisartan + NSAIDs). |
| **7. Emergency Triage (108)** | Click **Symptom Triage** tab | • Select preset *"Sudden Chest Tightness & Sweating"* or type chest pain symptoms.<br>• Click Evaluate: triggers **EMERGENCY** urgency and launches the flashing **CALL 108 AMBULANCE** emergency modal with golden-hour instructions. |
| **8. Doctor Visit Prep** | Click **Doctor Visit Prep** tab | • Formats history, active meds, and prioritized questions for the doctor into a 1-page summary.<br>• Click **Print / Save PDF** to view the clean printable brief. |
| **9. Privacy & Safety** | Click **Privacy & Safety** tab | • View 256-bit AES encryption status, zero AI training guarantee, and test the **Delete All My Data** sovereign purge button. |

---

## 🔒 Safety and Trust Guardrails
- **Non-Diagnostic Advisory:** MediMitra enforces clear disclaimers that it assists understanding and does not provide formal medical diagnoses or prescriptions.
- **Source-Grounded Citations:** Every AI claim in the chat copilot includes document name, physician, and text excerpt.
- **Hallucination Prevention:** If information is missing from the patient's records, the copilot explicitly declines to guess and prompts the user to upload relevant reports.
- **Emergency Escalation:** Cardiovascular, respiratory, or neurological red flags bypass normal queues and immediately surface the national Indian Emergency Ambulance (108) banner.
- **Privacy & Sovereignty:** Zero user data is stored for AI model training. One-click permanent data deletion purges all records from the database.
