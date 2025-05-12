# 
# Flutter CarOnSale Challenge App

## Overview
This is a Flutter application that get auction data by VIN.

## Setup Instructions

### Prerequisites
Before you begin, make sure you have the following installed:
- [Flutter](https://docs.flutter.dev/get-started/install) SDK
- Dart
- Android Studio or Xcode for emulators
- Git (for cloning the repository)

### Steps to Run the Project

1. **Clone the Repository**
   ```bash
   git git@github.com:qaysdwekat/car_on_sale_challenge.git
   cd car_on_sale_challenge
   ```
2. **Add Configuration Files**

- Development Configration: 
    -  Create a file `development.json` with the following content:
        ```bash
        {
            "env": "development",
            "base_url": "https://api-dev.caroncaronsale.com/",
        }
         ```
    - Save this file at: 
        ```bash
        lib/environments/caronsale_app/development/development.json
        ```

- Production Configration: 
    -  Create a file `production.json` with the following content:
        ```bash
        {
            "env": "Production",
            "base_url": "https://api.caroncaronsale.com/",
            }
          ```  
    - Save this file at:
 
        ```bash
        lib/environments/caronsale_app/production/production.json
        ```

3. **Generate Environment Files**
 Use the following command to generate the necessary environment-specific files:

    ```bash
        dart run build_runner build
    ```

4. **Run the Application**
   
   - Run the Application Start the app using the desired environment flavor.
   
      * For Development:
      
          ```bash
          flutter run -t lib/environments/caronsale_app/development/main_development.dart
          ```
      * For Production:
      
          ```bash
          flutter run -t lib/environments/caronsale_app/production/main_production.dart
          ```

### Running Tests

- Unit & Widget Tests Run the following command to execute the tests:
   
    ```bash
    flutter test
    ```

- Integration Test Run the following command to execute the tests:

    ```bash
    flutter test integration_test
    ```
