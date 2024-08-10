# Interview Task

## Requirements

- **Xcode:** Version 15.4 or later
- **iOS:** Version 17.4 or later

## Installation

1. **Open the project in Xcode:**

    - Navigate to the project directory.
    - Double-click the `.xcworkspace` file to open the project in Xcode.

2. **Build and Run:**

    - Select your target device or simulator.
    - Click on the "Run" button or press `Cmd + R`.
      
3. **Database**
     - I used Realm Database to store the password records in a local database.
     - To view the database records, you need to download the software named `Realm Studio`.
   
## Usage

1. **Password security:**
    - To encrypt the password, I used the RSA algorithm.
    - I integrated a system-generated password for the password record.
    - To update or see your password, you must pass through Face authentication.
    

3. **Storing**
    - The password records are safely stored in the phone's local database.
    - I added the keys for encryption and decryption of the password.
  
4. **Manage**
    - In the project, the class file `PasswordManager`  is to manage the records of the passwords.
