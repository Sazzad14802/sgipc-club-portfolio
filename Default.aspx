<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="SGIPC - A competitive programming club for problem solvers passionate about algorithms, coding contests, and continuous learning." />
  <title>SGIPC - Competitive Programming Club</title>

  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;600;700&amp;family=Manrope:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="Assets/styles.css?v=3" />
</head>
<body>
  <form id="form1" runat="server">
    <asp:ScriptManager runat="server" />
    <div class="nav-overlay" id="navOverlay" aria-hidden="true"></div>

    <!-- Mobile drawer — outside header so backdrop-filter stacking context doesn't trap it -->
    <nav class="nav-drawer" id="navDrawer" aria-label="Mobile navigation" aria-hidden="true">
      <ul class="nav-links" id="navLinks" role="list">
        <li><a href="#about">About</a></li>
        <li><a href="#activities">Activities</a></li>
        <li><a href="#resources">Resources</a></li>
        <li><a href="#events">Events</a></li>
        <li><a href="#achievements">Achievements</a></li>
        <li><a href="#contact">Contact</a></li>
        <li><a href="Login.aspx">Admin</a></li>
      </ul>
    </nav>

    <header class="site-header">
      <div class="container nav-wrap" role="navigation" aria-label="Main navigation">
        <a class="logo" href="#home"><img src="Assets/logo.png" alt="SGIPC Logo" /></a>

        <!-- Desktop-only nav links (hidden on mobile via CSS) -->
        <ul class="nav-links-desktop" aria-label="Desktop navigation links">
          <li><a href="#about">About</a></li>
          <li><a href="#activities">Activities</a></li>
          <li><a href="#resources">Resources</a></li>
          <li><a href="#events">Events</a></li>
          <li><a href="#achievements">Achievements</a></li>
          <li><a href="#contact">Contact</a></li>
          <li><a href="Login.aspx">Admin</a></li>
        </ul>

        <div class="nav-actions">
          <button class="theme-toggle" id="themeToggleBtn" type="button" aria-label="Switch to light theme" aria-pressed="false">
            <!-- Sun icon (shown in dark mode) -->
            <svg class="icon-sun" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
              <circle cx="12" cy="12" r="4"/><line x1="12" y1="2" x2="12" y2="6"/><line x1="12" y1="18" x2="12" y2="22"/>
              <line x1="4.22" y1="4.22" x2="7.05" y2="7.05"/><line x1="16.95" y1="16.95" x2="19.78" y2="19.78"/>
              <line x1="2" y1="12" x2="6" y2="12"/><line x1="18" y1="12" x2="22" y2="12"/>
              <line x1="4.22" y1="19.78" x2="7.05" y2="16.95"/><line x1="16.95" y1="7.05" x2="19.78" y2="4.22"/>
            </svg>
            <!-- Moon icon (shown in light mode) -->
            <svg class="icon-moon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
              <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/>
            </svg>
          </button>

          <button class="hamburger" id="hamburgerBtn" type="button" aria-label="Open navigation menu" aria-expanded="false" aria-controls="navDrawer">
            <span class="bar"></span>
            <span class="bar"></span>
            <span class="bar"></span>
          </button>
        </div>
      </div>
    </header>


    <main id="home">
      <section class="hero section">
        <div class="container hero-grid">
          <article class="card hero-content fade-up">
            <p class="chip">Competitive Programming Club of <span class="kuet-highlight">KUET</span></p>
            <h1>SGIPC | <span>Special Group Interested in Programming Contest</span></h1>
            <p class="section-subtitle">
              We train coders to solve hard problems under pressure through contests,
              team drills, and algorithm deep-dives. From first AC to ICPC regionals,
              this is where disciplined practice meets a supportive community.
            </p>
          </article>

          <aside class="card hero-stats fade-up delay-1" aria-label="Club highlights">
            <p class="chip">Current Snapshot</p>
            <div class="metric-grid">
              <asp:Repeater ID="statsRepeater" runat="server">
                <ItemTemplate>
                  <div class="metric">
                    <h3><%#: Eval("MetricValue") %></h3>
                    <p><%#: Eval("Description") %></p>
                  </div>
                </ItemTemplate>
              </asp:Repeater>
            </div>
          </aside>
        </div>
      </section>

      <section id="about" class="section">
          <div class="container">
          <p class="chip">About the Club</p>
          <h2 class="section-title">Building Problem Solvers, Not Just Coders</h2>
          <p class="section-subtitle">
            Competitive programming is the sport of algorithms. You solve carefully designed
            problems with speed, logic, and clean implementation. At SGIPC,
            we focus on consistency, collaboration, and confidence under contest pressure.
          </p>

          <div class="about">
            <article class="card fade-up">
              <h3>What We Do</h3>
              <p>
                We organize structured practice tracks covering data structures, graph theory,
                dynamic programming, number theory, and contest strategy. Every member gets
                guided progression and clear milestones.
              </p>
            </article>
            <article class="card fade-up delay-1">
              <h3>Our Mission</h3>
              <p>
                Create an inclusive space where students level up through practice, peer mentoring,
                and meaningful feedback. We celebrate small wins, learn from wrong submissions,
                and grow together.
              </p>
            </article>
          </div>
        </div>
      </section>

      <section id="activities" class="section">
        <div class="container">
          <p class="chip">Activities</p>
          <h2 class="section-title">Training That Feels Like a Team Sport</h2>
          <p class="section-subtitle">
            Weekly structure keeps momentum high while leaving space for curiosity and experimentation.
          </p>

          <div class="feature-grid">
            <article class="card activity-card fade-up">
              <img src="Assets/workshop.jpg" alt="Interactive Sessions" onerror="this.onerror=null; this.src='Assets/logo.png';" />
              <div class="card-body">
                <h3>Interactive Sessions</h3>
                <p>We organize structured practice tracks covering data structures, graph theory, dynamic programming, number theory, and contest strategy.</p>
              </div>
            </article>
            <article class="card activity-card fade-up delay-1">
              <img src="Assets/teamcontest.jpg" alt="Weekly Contests" onerror="this.onerror=null; this.src='Assets/logo.png';" />
              <div class="card-body">
                <h3>Weekly Contests</h3>
                <p>Internal rounds every Friday with editorial walkthroughs, three-person team simulations, and post-contest analysis.</p>
              </div>
            </article>
          </div>
        </div>
      </section>

      <section id="resources" class="section">
        <div class="container">
          <p class="chip">Practice Resources</p>
          <h2 class="section-title">Curated Platforms for Every Level</h2>
          <p class="section-subtitle">
            Start with fundamentals, then move into advanced ladders and contest archives.
          </p>

          <div class="resource-grid">
            <article class="card resource-card fade-up">
              <h3>Codeforces</h3>
              <p>Frequent rounds, rich editorials, and a huge problem archive for ratings growth.</p>
              <a href="https://codeforces.com" target="_blank" rel="noopener">Visit Platform</a>
            </article>
            <article class="card resource-card fade-up delay-1">
              <h3>AtCoder</h3>
              <p>Excellent quality problems and clean progression from beginner to expert.</p>
              <a href="https://atcoder.jp" target="_blank" rel="noopener">Visit Platform</a>
            </article>
            <article class="card resource-card fade-up delay-2">
              <h3>CSES Problem Set</h3>
              <p>Structured topic-based training ideal for mastering classic algorithms.</p>
              <a href="https://cses.fi/problemset" target="_blank" rel="noopener">Visit Platform</a>
            </article>
            <article class="card resource-card fade-up">
              <h3>ICPC Archive</h3>
              <p>Historic regional and world-final style problems for team practice scenarios.</p>
              <a href="https://icpc.global" target="_blank" rel="noopener">Visit Platform</a>
            </article>
          </div>
        </div>
      </section>

      <section id="events" class="section">
        <div class="container">
          <p class="chip">Events</p>
          <h2 class="section-title">Organizing Competitive Events</h2>
          <p class="section-subtitle">We host national and intra-university programming contests to foster a competitive programming culture.</p>

          <div class="achievement-grid">
            <asp:Repeater ID="eventsRepeater" runat="server">
              <ItemTemplate>
                <article class="card activity-card fade-up">
                  <img src='<%# string.IsNullOrEmpty(Convert.ToString(Eval("ImageUrl"))) ? "Assets/logo.png" : Eval("ImageUrl") %>' alt='<%# Eval("Title") %>' onerror="this.onerror=null; this.src='Assets/logo.png';" />
                  <div class="card-body">
                    <h3><%# Eval("Title") %></h3>
                    <p><%# Eval("Description") %></p>
                  </div>
                </article>
              </ItemTemplate>
            </asp:Repeater>
          </div>
        </div>
      </section>

      <section id="achievements" class="section">
        <div class="container">
          <p class="chip">Achievements</p>
          <h2 class="section-title">Results That Reflect Consistent Practice</h2>
          <p class="section-subtitle">Our members continue to push boundaries in local and international contests.</p>

          <div class="achievement-grid">
            <asp:Repeater ID="achievementsRepeater" runat="server">
              <ItemTemplate>
                <article class="card achievement-card fade-up">
                  <h3><%#: Eval("Title") %></h3>
                  <p><%#: Eval("Description") %></p>
                </article>
              </ItemTemplate>
            </asp:Repeater>
          </div>
        </div>
      </section>

      <section id="contact" class="section">
        <div class="container">
          <p class="chip">Contact Us</p>
          <h2 class="section-title">Get In Touch</h2>
          <p class="section-subtitle">Have questions or want to collaborate? Send us a message.</p>

          <div class="join-wrap">
            <aside class="card contact-box fade-up">
              <h3>Contact</h3>
              <p>Reach out for onboarding, training schedules, and collaboration opportunities.</p>
              <ul class="social-list">
                <li><a href="mailto:sgipc@kuet.edu">sgipc@kuet.edu</a></li>
                <li><a href="https://discord.com" target="_blank" rel="noopener">Discord Community Server</a></li>
                <li><a href="https://www.facebook.com/sgipc.kuet" target="_blank" rel="noopener">Facebook Page</a></li>
              </ul>
            </aside>

            <asp:UpdatePanel runat="server">
              <ContentTemplate>
                <section class="card join-form fade-up delay-1" aria-label="Contact form">
                  <h3>Send a Message</h3>

                  <label for="name">Full Name</label>
                  <asp:TextBox ID="name" runat="server" ClientIDMode="Static" placeholder="Your name" />
                  <asp:RequiredFieldValidator ID="nameValidator" runat="server" ControlToValidate="name" CssClass="validation-message" ErrorMessage="Full name is required." Display="Dynamic" />

                  <label for="email">Email Address</label>
                  <asp:TextBox ID="email" runat="server" ClientIDMode="Static" TextMode="Email" placeholder="you@example.com" />
                  <asp:RequiredFieldValidator ID="emailValidator" runat="server" ControlToValidate="email" CssClass="validation-message" ErrorMessage="Email address is required." Display="Dynamic" />
                  <asp:RegularExpressionValidator ID="emailFormatValidator" runat="server" ControlToValidate="email" CssClass="validation-message" ErrorMessage="Enter a valid email address." ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" Display="Dynamic" />

                  <label for="subject">Subject</label>
                  <asp:TextBox ID="subject" runat="server" ClientIDMode="Static" placeholder="Message subject" />
                  <asp:RequiredFieldValidator ID="subjectValidator" runat="server" ControlToValidate="subject" CssClass="validation-message" ErrorMessage="Subject is required." Display="Dynamic" />

                  <label for="message">Message</label>
                  <asp:TextBox ID="message" runat="server" ClientIDMode="Static" TextMode="MultiLine" placeholder="Your message..." />
                  <asp:RequiredFieldValidator ID="messageValidator" runat="server" ControlToValidate="message" CssClass="validation-message" ErrorMessage="Message is required." Display="Dynamic" />

                  <asp:Button ID="submitButton" runat="server" Text="Send Message" OnClick="SubmitButton_Click" />
                </section>
              </ContentTemplate>
            </asp:UpdatePanel>
          </div>
        </div>
      </section>
    </main>

    <footer>
      <div class="container">
        <p>&copy; 2026 SGIPC. Built with ASP.NET Web Forms for aspiring problem solvers.</p>
      </div>
    </footer>
  </form>

  <script src="Assets/script.js?v=2"></script>
</body>
</html>
