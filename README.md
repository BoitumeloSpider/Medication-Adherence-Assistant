<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>AI Healthcare Triage Mobile Application</title>
<style>
body{
font-family: Arial, sans-serif;
margin:40px;
line-height:1.6;
background:#f5f7fa;
}

h1,h2,h3{
color:#0a4d68;
}

.container{
background:white;
padding:30px;
border-radius:8px;
box-shadow:0 2px 10px rgba(0,0,0,0.1);
}

table{
width:100%;
border-collapse:collapse;
margin-top:10px;
}

table, th, td{
border:1px solid #ccc;
}

th, td{
padding:10px;
text-align:left;
}

code{
background:#eee;
padding:3px 6px;
border-radius:4px;
}

.section{
margin-bottom:30px;
}

</style>
</head>

<body>

<div class="container">

<h1>AI Healthcare Triage Mobile Application</h1>

<div class="section">
<h2>Project Overview</h2>
<p>
The AI Healthcare Triage Mobile Application helps users assess symptoms and receive healthcare guidance using Artificial Intelligence.
The system aims to reduce unnecessary clinic visits, improve healthcare accessibility, and assist patients in managing medication schedules.
</p>

<p>The application consists of two main components:</p>

<ul>
<li><b>Flutter Mobile App</b> – User interface for patients</li>
<li><b>Spring Boot Backend</b> – Handles authentication and system logic</li>
</ul>

<p>The system uses <b>PostgreSQL</b> as the database and <b>Swagger UI</b> for API documentation and testing.</p>
</div>

<div class="section">
<h2>System Architecture</h2>

<p>Client – Server Architecture</p>

<pre>
Flutter Mobile App
        |
        | REST API
        v
Spring Boot Backend
        |
        v
PostgreSQL Database
</pre>

</div>

<div class="section">
<h2>Tools Used</h2>

<table>
<tr>
<th>Tool</th>
<th>Purpose</th>
</tr>

<tr>
<td>VS Code</td>
<td>Flutter mobile development</td>
</tr>

<tr>
<td>IntelliJ IDEA</td>
<td>Spring Boot backend development</td>
</tr>

<tr>
<td>PostgreSQL</td>
<td>Database</td>
</tr>

<tr>
<td>pgAdmin</td>
<td>Database management</td>
</tr>

<tr>
<td>Swagger UI</td>
<td>API documentation and testing</td>
</tr>

<tr>
<td>GitHub</td>
<td>Version control</td>
</tr>

</table>
</div>

<div class="section">
<h2>Technology Stack</h2>

<h3>Frontend</h3>
<ul>
<li>Flutter</li>
<li>Dart</li>
<li>Material UI</li>
</ul>

<h3>Backend</h3>
<ul>
<li>Java 17</li>
<li>Spring Boot</li>
<li>Spring Security</li>
<li>Liquibase</li>
</ul>

<h3>Database</h3>
<ul>
<li>PostgreSQL</li>
<li>pgAdmin</li>
</ul>

<h3>API Documentation</h3>
<ul>
<li>Swagger UI</li>
</ul>

</div>

<div class="section">
<h2>Development Environment Setup</h2>

<h3>VS Code</h3>
<p>Used for Flutter mobile development.</p>

<h3>IntelliJ IDEA</h3>
<p>Used for Spring Boot backend development.</p>

<h3>PostgreSQL</h3>

<pre>
Port: 5432
Username: postgres
Password: postgres
</pre>

<h3>pgAdmin</h3>
<p>Used for managing the PostgreSQL database.</p>

<h3>Android Emulator</h3>
<p>Install Android Studio to create virtual devices for testing the Flutter application.</p>

</div>

<div class="section">
<h2>Backend Setup (Spring Boot)</h2>

<h3>Step 1: Open Project</h3>
<p>Open the backend project in IntelliJ IDEA.</p>

<h3>Step 2: Configure Database</h3>

<pre>
spring.datasource.url=jdbc:postgresql://localhost:5432/healthcare_ai
spring.datasource.username=postgres
spring.datasource.password=postgres

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
</pre>

<h3>Step 3: Run the Application</h3>

<p>Run the main class:</p>

<code>MerchantwebApplication.java</code>

<p>Application will run on:</p>

<code>http://localhost:8080</code>

</div>

<div class="section">
<h2>Swagger API Documentation</h2>

<p>Swagger UI allows developers to test APIs.</p>

<p>Open:</p>

<code>http://localhost:8080/swagger-ui/index.html</code>

<table>

<tr>
<th>Endpoint</th>
<th>Description</th>
</tr>

<tr>
<td>POST /api/users/register</td>
<td>Register new user</td>
</tr>

<tr>
<td>POST /api/users/login</td>
<td>User login</td>
</tr>

<tr>
<td>POST /api/users/forgot</td>
<td>Reset password</td>
</tr>

</table>

</div>

<div class="section">
<h2>Database Setup</h2>

<p>Create database in pgAdmin:</p>

<code>healthcare_ai</code>

<p>Liquibase automatically creates tables when backend starts.</p>

</div>

<div class="section">
<h2>Mobile Application Setup</h2>

<h3>Step 1</h3>
<p>Open Flutter project in VS Code.</p>

<h3>Step 2</h3>

<pre>
flutter pub get
</pre>

<h3>Step 3</h3>

<p>Configure API URL for Android emulator:</p>

<pre>
http://10.0.2.2:8080/api/users
</pre>

</div>

<div class="section">
<h2>Application Features</h2>

<ul>
<li>User Registration</li>
<li>User Login</li>
<li>Forgot Password</li>
<li>AI Symptom Triage</li>
<li>Medication Reminder</li>
<li>Health Notifications</li>
</ul>

</div>

<div class="section">
<h2>Running the Full System</h2>

<ol>
<li>Start PostgreSQL</li>
<li>Run Spring Boot backend in IntelliJ</li>
<li>Open Swagger UI to test APIs</li>
<li>Run Flutter mobile app using <code>flutter run</code></li>
</ol>

</div>

<div class="section">
<h2>Future Improvements</h2>

<ul>
<li>AI chatbot integration</li>
<li>Doctor consultation</li>
<li>Health analytics dashboard</li>
<li>Emergency service integration</li>
<li>Wearable device support</li>
</ul>

</div>

<div class="section">
<h2>Contributors</h2>

<p>This project was developed for academic purposes as part of a Software Engineering healthcare system project.</p>

</div>

</div>

</body>
</html>