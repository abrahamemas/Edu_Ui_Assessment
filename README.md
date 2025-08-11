# Educational Mobile iOS App - Flutter UI Assessment

A professional Flutter application that replicates the UI design from [Dribbble](https://dribbble.com/shots/25532415-Educational-Mobile-iOS-App) with a focus on clean architecture, responsive design, and native Flutter implementation.

## 🎯 Project Overview

This project demonstrates advanced Flutter development skills by implementing a complete educational quiz application with:

- **Pure Flutter Implementation**: No external packages used
- **Clean Architecture**: Professional code organization
- **Real-time Data Synchronization**: Live updates between screens
- **Responsive Design**: Works across various screen sizes
- **Custom State Management**: Built-in reactive state system

## 🏗️ Architecture

```
lib/
├── ds/                    # Design System
│   ├── components/        # Reusable UI components
│   └── theme/            # Colors, spacing, typography
├── domain/               # Business Logic Layer
│   ├── models.dart       # Data models
│   └── usecases.dart     # Business use cases
├── data/                 # Data Layer
│   └── repository.dart   # Data repository interface
├── state/                # State Management
│   └── app_state.dart    # Global app state
├── feature/              # Feature-based screens
│   ├── home/            # Home screen and components
│   ├── practice/        # Practice screen and components
│   ├── topics/          # Topics screen and components
│   └── question/        # Question screen and components
├── router/              # Navigation
│   └── app_router.dart  # Route definitions
├── bootstrap.dart       # App initialization
├── app.dart            # Main app configuration
└── main.dart           # Entry point
```

## 🚀 Features

### **Core Functionality**
- **Quiz System**: Interactive question-answer interface
- **Real-time Scoring**: Live score updates with 2-point system
- **Progress Tracking**: Questions completed, mistakes, time spent
- **Topic-based Practice**: Practice by specific topics
- **Random Quiz Mode**: Mixed questions from all topics

### **UI/UX Features**
- **Responsive Design**: Adapts to different screen sizes
- **Dark Theme**: Professional dark color scheme
- **Smooth Animations**: Subtle micro-interactions
- **Real-time Updates**: Live data synchronization
- **Professional Styling**: Consistent design tokens

### **Technical Features**
- **Custom State Management**: Stream-based reactive system
- **Clean Architecture**: Separation of concerns
- **Memory Management**: Proper disposal of resources
- **Error Handling**: Graceful error management
- **Performance Optimized**: Efficient widget rebuilds

## 📱 Screenshots

### Home Screen
- Real-time statistics dashboard
- Live score updates
- Progress tracking
- Performance metrics

### Practice Screen
- Multiple practice modes
- Topic selection
- Interactive tiles
- Professional styling

### Question Screen
- Interactive quiz interface
- Real-time answer validation
- Progress indicators
- Smooth navigation

## 🛠️ Technical Stack

- **Framework**: Flutter (Latest Stable)
- **Language**: Dart
- **Architecture**: Clean Architecture
- **State Management**: Custom Stream-based system
- **Design System**: Custom design tokens
- **Navigation**: Custom router implementation

## 📋 Requirements

- Flutter SDK: ^3.6.2
- Dart SDK: ^3.6.2
- iOS: 12.0+
- Android: API 21+

## 🚀 Getting Started

### Prerequisites
```bash
flutter --version  # Should be 3.6.2 or higher
```

### Installation
```bash
# Clone the repository
git clone https://github.com/abrahamemas/Edu_Ui_Assessment.git

# Navigate to project directory
cd Edu_Ui_Assessment

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Build Instructions
```bash
# For iOS
flutter build ios

# For Android
flutter build apk

# For Web
flutter build web
```

## 🎨 Design System

### Colors
- **Primary**: `#33F699` (Mint Green)
- **Secondary**: `#67E7FF` (Cyan Blue)
- **Background**: `#070707` (Dark Black)
- **Surface**: `#232323` (Dark Gray)
- **Text Primary**: `#F4F6F6` (Light Gray)

### Typography
- **Font Family**: Outfit, Satoshi
- **Headings**: 42px, 32px, 18px
- **Body**: 16px, 14px
- **Weights**: 500, 600

### Spacing
- **Tiny**: 4px
- **Small**: 8px
- **Medium**: 12px
- **Large**: 16px
- **Extra Large**: 24px
- **Double Extra Large**: 32px

## 🔧 Key Implementation Details

### State Management
```dart
// Custom singleton pattern with streams
class AppState {
  static AppState get I => _instance;
  
  // Real-time streams
  Stream<List<SubjectModel>> get subjectsStream;
  Stream<int> get scoreStream;
  Stream<Duration> get timeSpentStream;
}
```

### Real-time Updates
- **Live Score Tracking**: Updates immediately on answer submission
- **Time Spent**: Real-time timer during quizzes
- **Progress Sync**: Cross-screen data synchronization
- **Performance Metrics**: Live statistics updates

### Responsive Design
```dart
// Dynamic padding based on screen size
double _calculateHorizontalPadding(double width) {
  if (width >= 1200) return 48; // Large tablets
  if (width >= 768) return 32;  // Tablets
  if (width >= 400) return 24;  // Large phones
  return 16; // Small phones
}
```

## 📊 Performance Features

- **Efficient Widget Rebuilds**: Minimal state updates
- **Memory Management**: Proper stream disposal
- **Optimized Images**: Asset optimization
- **Smooth Animations**: 60fps performance
- **Fast Navigation**: Instant screen transitions

## 🧪 Testing

The project is structured for comprehensive testing:
- **Unit Tests**: Business logic and use cases
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end functionality

## 📈 Project Metrics

- **Lines of Code**: ~2,500+
- **Components**: 20+ reusable widgets
- **Screens**: 4 main feature screens
- **Architecture Layers**: 3 (Domain, Data, Presentation)
- **Custom Components**: 15+ specialized widgets

## 🎯 Interview Assessment Compliance

### ✅ Requirements Met
- **No External Packages**: Pure Flutter implementation
- **Professional Architecture**: Clean, organized codebase
- **Responsive Design**: Works across all screen sizes
- **UI Replication**: Faithful to Dribbble design
- **Code Quality**: Well-structured, maintainable code

### 🏆 Technical Excellence
- **Custom State Management**: No external state libraries
- **Stream-based Reactivity**: Modern Flutter patterns
- **Memory Optimization**: Proper resource management
- **Performance**: Optimized for smooth user experience
- **Scalability**: Easy to extend and maintain

## 🤝 Contributing

This is an assessment project, but contributions are welcome for learning purposes.

## 📄 License

This project is created for educational and assessment purposes.

## 👨‍💻 Author

Created with ❤️ using Flutter

---

**Note**: This project demonstrates advanced Flutter development skills with a focus on clean architecture, performance, and user experience. It serves as a comprehensive example of professional Flutter application development.
