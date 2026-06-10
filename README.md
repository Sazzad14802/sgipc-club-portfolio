<div align="center">

<img src="Assets/logo.png" alt="SGIPC Logo" width="150"/>

# SGIPC Portfolio
**A Modern, Responsive, and Lightweight University Competitive Programming Club Portfolio**

[![C#](https://img.shields.io/badge/C%23-10.0-239120?style=for-the-badge&logo=csharp&logoColor=white)](#)
[![ASP.NET Web Forms](https://img.shields.io/badge/ASP.NET_Web_Forms-4.8-512BD4?style=for-the-badge&logo=dotnet&logoColor=white)](#)
[![Microsoft SQL Server](https://img.shields.io/badge/SQL_Server-LocalDB-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)](#)
<br>
[![HTML5](https://img.shields.io/badge/HTML5-Structure-E34F26?style=for-the-badge&logo=html5&logoColor=white)](#)
[![CSS3](https://img.shields.io/badge/CSS3-Styling-1572B6?style=for-the-badge&logo=css3&logoColor=white)](#)
[![JavaScript](https://img.shields.io/badge/JavaScript-ES6-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)](#)

</div>

> **SGIPC** (Special Group Interested in Programming Contest) is the official competitive programming club of KUET. This platform serves as a modern portfolio showcasing statistics, achievements, activities, and resources, while providing an administrative dashboard to manage content and receive contact inquiries.

---

## 🚀 Features

- **Premium Responsive Layout:** Fully optimized for all device sizes featuring a clean dark/light theme toggle.
- **Dynamic Metrics & Milestones:** Key statistics, club achievements, and competitive events are served dynamically from the MSSQL database.
- **AJAX Contact Channel:** An interactive contact form that submits asynchronously (without page refresh) and stores user messages securely for review.
- **Admin Dashboard:** Secure dashboard allowing administrators to CRUD (Create, Read, Update, Delete) snapshots, achievements, events, and manage incoming contact messages. Features automatic background AJAX updates with Javascript confirmation safety checks.
- **Native Image Upload System:** Admins can directly upload event images straight from their computer. The server automatically renames files using GUIDs to prevent overwrites, caches them in a dedicated uploads directory, and securely deletes old files during updates or deletions to save disk space.
- **Modern Typography & Styling:** Rich design aesthetics with custom fonts, image-centric modern cards, glassmorphism elements, and smooth transitions without relying on heavy CSS frameworks.

---

## 🛠️ Technology Stack

- **Backend Logic:** C# / ASP.NET Web Forms (.NET Framework 4.8)
- **Database Architecture:** Microsoft SQL Server (LocalDB) via `System.Data.SqlClient`
- **Frontend Presentation:** HTML5, Custom Vanilla CSS3, ES6 JavaScript

---

## 📂 Project Structure

```text
club_portfolio_project/
├── Admin/
│   ├── Admin.aspx                        # Admin dashboard UI
│   ├── Admin.aspx.cs                     # Admin dashboard code-behind
│   ├── Admin.master                      # Master page for admin area (contains AJAX UpdatePanel)
│   ├── AdminSnapshots.aspx               # Snapshot management UI
│   ├── AdminAchievements.aspx            # Achievement management UI
│   ├── AdminEvents.aspx                  # Events & workshop management UI with file uploads
│   └── AdminContactMessages.aspx         # Contact messages management UI
├── App_Code/
│   └── PortfolioRepository.cs            # Data access layer for DB operations
├── Assets/
│   ├── Uploads/                          # System-managed directory for user-uploaded images (.gitignored)
│   ├── logo.png                          # Club logo asset
│   ├── script.js                         # Frontend interactions and theme toggling
│   └── styles.css                        # Core styling system
├── DatabaseScripts/
│   └── CreatePortfolioTables.sql         # SQL script to initialize DB schema and seed data
├── Default.aspx                          # Main landing page UI
├── Default.aspx.cs                       # Main landing page code-behind
├── Login.aspx                            # Admin login UI
├── Login.aspx.cs                         # Admin login code-behind
└── Web.config                            # Application and database configuration
```

---

## ⚙️ Setup & Installation

Follow these steps to get a development environment running.

### 1. Database Setup

Ensure your local SQL Server instance is running and execute the database script to set up the schema and seed initial data. Open Command Prompt or PowerShell in the root directory and run:

```bash
sqlcmd -S "(localdb)\MSSQLLocalDB" -i "DatabaseScripts\CreatePortfolioTables.sql"
```

The script will automatically:
- Create the `sgipcdb` database.
- Construct the `Snapshot`, `Achievements`, `Events`, and `ContactMessages` tables.
- Seed the tables with initial metrics, activities, and achievements.

### 2. Connection & Credentials

Configure the application via the `Web.config` file:

- **Database Connection String:**
  By default, it is configured to use the LocalDB instance:
  ```xml
  <connectionStrings>
    <add name="PortfolioDb" connectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=sgipcdb;Integrated Security=True" providerName="System.Data.SqlClient"/>
  </connectionStrings>
  ```
- **Administrative Credentials:**
  These are used to log in to the `/Login.aspx` portal.
  - **Username:** `admin`
  - **Password:** `admin123`

### 3. Run the Application

1. Open `club_portfolio_project.sln` using **Visual Studio 2022** (or your preferred IDE supporting ASP.NET Web Forms).
2. Ensure **IIS Express** is selected as the launch profile.
3. Run the project (Press `F5` or `Ctrl+F5`).
4. The browser should automatically open `http://localhost:<port>/Default.aspx`.
