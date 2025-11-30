# 🩸 B-Life: Save Lives, One Donation at a Time

> **"A single drop of blood can make a huge difference."**

Welcome to **B-Life**, a Flutter-based mobile application designed to bridge the gap between blood donors and those in need. Our mission is to streamline the process of finding donors, managing blood requests, and saving lives through technology.

---

## 🚀 Project Overview

B-Life is a comprehensive blood donation management system. It allows users to register as donors, create blood requests, view available donors, and manage their donation history. Built with **Flutter** and **SQLite**, it ensures a smooth, offline-capable experience.  
Software Requirements Specification Document: [LINK](https://docs.google.com/document/d/1S-Bcqam8NwTtYMirJzaRjQYuzLQYqbIQfYwW_YIHZ1U/edit?tab=t.0)

### ✨ Key Features
*   **User Authentication:** Secure Registration and Login flows.
*   **Dashboard:** A central hub for quick actions and activity overview.
*   **Request Management:** Create, Read, Update, and Delete (CRUD) blood requests.
*   **Donor Network:** Browse a list of available donors.
*   **Profile Management:** Manage personal details and donation history.
*   **Local Storage:** Robust data persistence using SQLite.

---

## 👥 Meet the Team & Contributions

This project was brought to life by a dedicated team of developers. Here is the breakdown of our contributions:

### 🛠️ Core Architecture & Backend
**👨‍💻 Jamol Shoymurzaev (ID: 220073)**
*   **Role:** Lead Developer & Architect
*   **Contributions:**
    *   Implemented the **Core Functionality** and main user flows.
    *   Built the **Request CRUD** system (Add, List, Details, Edit, Delete).
    *   Built the **Profile CRUD** system (Details, Edit, Delete).
    *   Developed the **DatabaseHelper** service with full SQLite integration.
    *   Set up the complete **Routing Structure** in `main.dart`.
    *   Authored the full **SRS (Software Requirements Specification)** document.

### 🎨 UI/UX & Feature Implementation

**👨‍💻 Azizbek Ergashov (ID: 220088)**
*   **Role:** Dashboard & Experience Developer
*   **Contributions:**
    *   Developed the **Dashboard Screen**, the heart of the application.
    *   Designed the overview of recent requests and activities.
    *   Implemented "Quick Actions" for seamless navigation to Add Request or Profile.
    *   Ensured a responsive and engaging user interface for the main hub.

**👨‍💻 Arislanbek Kalbaev (ID: 220081)**
*   **Role:** Authentication Specialist
*   **Contributions:**
    *   Developed the **Registration Page** with comprehensive validation (Name, Passport, DOB, Email).
    *   Built the **Login Page** ensuring secure access via Email and Passport.
    *   Implemented strict form validation and error handling (Red alert notifications).
    *   Managed the navigation flow between Auth screens and the Dashboard.

**👩‍💻 Durdana YEmbergenova (ID: 220072)**
*   **Role:** Navigation Component Developer
*   **Contributions:**
    *   Developed the **AppNavigation** widget (Bottom Navigation Bar).
    *   Implemented state management for seamless screen switching (Home, Add, Requests, Profile).
    *   Designed the visual hierarchy with active/inactive states and Material icons.
    *   Integrated the navigation component into the `HomeContainer` for a unified app structure.

**👩‍💻 Sodiqova Marjona (ID: 220089)**
*   **Role:** Donor Network Developer
*   **Contributions:**
    *   Developed the **Donors List Screen** to display available heroes.
    *   Created the **Donor Card** UI for clear summary information (Name, Blood Group).
    *   Implemented efficient list rendering with `ListView.builder`.
    *   Integrated the screen into the core navigation system.

---

## 🛠️ Tech Stack

*   **Framework:** Flutter (Dart)
*   **Database:** SQLite (sqflite)
*   **Architecture:** MVC Pattern (Models, Views/Screens, Controllers/Services)
*   **State Management:** `setState` & Callback-based management

---

## 📱 Getting Started

1.  **Clone the repo:**
    ```bash
    git clone https://github.com/Durdana4/B-Life.git
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the app:**
    ```bash
    flutter run
    ```

---

*Developed with ❤️ by the B-Life Team.*