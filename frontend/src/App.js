import React, { useState } from "react";
import { PublicClientApplication } from "@azure/msal-browser";
import axios from "axios";
import "./App.css";

// 🔑 MSAL configuration (replace with your values)
const msalConfig = {
  auth: {
    clientId: "YOUR_FRONTEND_CLIENT_ID",  // SPA app registration ID
    authority: "https://login.microsoftonline.com/YOUR_TENANT_ID", // tenant
    redirectUri: "http://localhost:3000"
  }
};

const msalInstance = new PublicClientApplication(msalConfig);

function App() {
  const [cases, setCases] = useState([]);
  const [user, setUser] = useState(null);

  const loginAndFetchCases = async () => {
    try {
      // Popup login
      const loginResponse = await msalInstance.loginPopup({
        scopes: ["api://YOUR_API_CLIENT_ID/.default"]  // backend API scope
      });

      const token = loginResponse.accessToken;
      setUser(loginResponse.account);

      // Call FastAPI backend with Bearer token
      const response = await axios.get("http://localhost:8000/cases", {
        headers: { Authorization: `Bearer ${token}` }
      });

      setCases(response.data);
    } catch (err) {
      console.error("Login or fetch failed:", err);
    }
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Investigations Portal</h1>
        {!user ? (
          <button onClick={loginAndFetchCases}>Login & Load Cases</button>
        ) : (
          <div>
            <p>Welcome, {user.username || user.name}</p>
            <button onClick={loginAndFetchCases}>Reload Cases</button>
          </div>
        )}

        <ul>
          {cases.map(c => (
            <li key={c.id}>
              <strong>{c.title}</strong> — {c.status}
            </li>
          ))}
        </ul>
      </header>
    </div>
  );
}

export default App;
