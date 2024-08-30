# Aswenna - Farm Management System

## Introduction

Welcome to the Aswenna Farm Management System repository! This web application is designed to help farmers manage their crops, inventory, and soil conditions efficiently. Built with Laravel, Vue3, Inertia.js, and MySQL, it offers a user-friendly interface for comprehensive farm management.

## Features

- **Crop Management:** Track and manage crops at different growth stages.
- **Inventory Management:** Manage and monitor inventory levels for seeds, fertilizers, pesticides, and other items.
- **Soil Condition Monitoring:** Evaluate soil conditions and store results for optimal farming.
- **Real-time Updates:** Keep track of changes in crops and inventory.
- **User Management:** Secure access with authentication.

## Included in the Project

- Full source code of the application.
- SQL database dump.
- Video demonstration.
- Screenshots.

## Setup Instructions

### Prerequisites

Ensure you have the following installed on your machine:

- PHP (version 8.0 or higher)
- Composer
- Node.js and npm
- MySQL

### Cloning the Repository

1. Clone the repository to your local machine:
    ```sh
    git clone https://github.com/lankeshhalangoda/FarmManagementSystem-RiseTechVillage.git
    cd FarmManagementSystem-RiseTechVillage
    ```

### Backend Setup

1. Install PHP dependencies:
    ```sh
    composer install
    ```

2. Create a copy of the `.env.example` file and rename it to `.env`:
    ```sh
    cp .env.example .env
    ```

3. Update the `.env` file with your database configuration:
    ```sh
    DB_CONNECTION=mysql
    DB_HOST=127.0.0.1
    DB_PORT=3306
    DB_DATABASE=your_database_name
    DB_USERNAME=your_database_username
    DB_PASSWORD=your_database_password
    ```

4. Generate an application key:
    ```sh
    php artisan key:generate
    ```

5. Set up the database:

   - **Option 1: Use Provided Database**

     Import the SQL file located in the `database` folder into your MySQL database.

   - **Option 2: Run Seeders**

     Alternatively, run the seeders to set up the database schema and initial data:
     ```sh
     php artisan migrate --seed
     ```

     This will create default category types and a user account with:

     - **Email**: `test@gmail.com`
     - **Password**: `risetech@123`

### Frontend Setup

1. Install Node.js dependencies:
    ```sh
    npm install
    ```

2. Build the frontend assets:
    ```sh
    npm run dev
    ```

### Running the Application

1. Start the Laravel development server:
    ```sh
    php artisan serve
    ```

2. Open your browser and navigate to `http://localhost:8000`.

## Additional Information

- **Silent Video:** Available in the `video` folder.
- **Screenshots Collection:** Available in the `screenshots` folder.

---

Thank you for using Aswenna! If you have any questions or need further assistance, please open an issue on the [GitHub repository](https://github.com/lankeshhalangoda/FarmManagementSystem-RiseTechVillage.git).
