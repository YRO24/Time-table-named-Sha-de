# ✨ Time-table-named-Sha-de ✨

## 📱 Overview
Sha-de is an iOS time-table application designed to help users organize their tasks by day of the week and time slots. The app features an elegant UI with animated elements and a clean, intuitive workflow that allows users to manage their to-do lists effectively. 🌟

## 🚀 Features
- **🔐 User Authentication**: Registration and login functionality
- **🎨 Visual Appeal**: Beautiful background images and floating animations
- **📋 Organized Task Management**:
  - 📅 Tasks organized by days of the week
  - ⏰ Time slot categorization (Morning to Noon, Afternoon to Evening, Evening to Night)
  - ✓ Task completion tracking with visual indicators
- **🛠️ Task Operations**:
  - ➕ Add new tasks
  - ✅ Mark tasks as complete/incomplete
  - 🗑️ Delete tasks
- **💾 Data Persistence**: Tasks are saved locally using UserDefaults

## 🔄 App Flow
1. **👋 Welcome Screen**: Animated floating elements with login/register options
2. **🔑 Authentication**: User can register or login
3. **📆 Day Selection**: Choose from Monday through Sunday
4. **🕒 Time Slot Selection**: Pick between Morning to Noon, Afternoon to Evening, or Evening to Night
5. **📝 Task Management**: View, add, complete, or delete tasks for the selected day and time slot

## 🧩 Technical Details
### ⚙️ Requirements
- 📱 iOS 13.0+
- 🛠️ Xcode 12.0+
- 🔶 Swift 5.0+

### 🏗️ Key Components
- **🏠 ViewController**: Main welcome screen with floating animations
- **🔐 abViewController**: Login page
- **📝 abViewController**: Registration page
- **🎉 welcome**: Success login confirmation
- **📅 abcdViewController**: Days of the week selection
- **⏰ abcViewController**: Time slot selection
- **📋 TodoListViewController**: Task management with table view

### 💽 Data Storage
The app uses UserDefaults for data persistence:
- 📦 Tasks are stored by day and time slot
- ✓ Completion status is tracked separately

## 📲 Installation
Simply Clone the repository !

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.
