# ˚˖𓍢ִ໋❀ Vet Clinic REST API   ᯓ★
![Flask](https://img.shields.io/badge/Flask-2.x-ffb6c1.svg)
![Python](https://img.shields.io/badge/Python-3.10+-ff69b4.svg)
![MySQL](https://img.shields.io/badge/MySQL-Database-ffc0cb.svg)
![JWT](https://img.shields.io/badge/JWT-Authentication-ff69b4.svg)
![REST API](https://img.shields.io/badge/REST-API-ffb6c1.svg)

*A simple, secure, and cute CRUD API built with Flask & MySQL*

This project is a **Flask-based REST API** designed to manage customer records for a veterinary clinic.
It includes **JWT authentication**, **CRUD operations**, and clean **JSON responses**.

---
## 𖦹 Features ⋮

- JWT Authentication (Login-protected endpoints)
- Create, Read, Update, Delete (CRUD) Customers
- Search Customers
- JSON / XML response support
- Input validation and error handling
- MySQL database integration
- Tested using PowerShell `Invoke-RestMethod`

---

## 𖦹 Tech Stack ⋮

- Python 3.10+
- Flask
- Flask-JWT-Extended
- MySQL
- mysql-connector-python

---

## 𖦹 Setup Instructions ⋮

### 1️⃣ Clone the Repository ⟢

```powershell
git clone <repository-url>
cd vet_clinic_api
```

### 1️⃣ Set up your virtual environment ⟢
```
python -m venv csenv
.\csenv\Scripts\Activate
```
You should see something like this:
```
(csenv) PS C:\Users\Desktop\cse>
```

### 3️⃣ Install Dependencies ⟢
``` 
pip install -r requirements.txt
```

### 4️⃣ Set up database ⟢
Import `salonoy.sql` using MySQL Workbench
1. Open MySQL Workbench
2. Go to **Server → Data Import**
3. Select **Import from Self-Contained File**
4. Choose `salonoy.sql`
5. Click **Start Import**

*⚠️ note: Do not rename the database, tables, or columns.*

### 5️⃣ Configure database(config.py) ⟢
```
DB_HOST = "host name here" #change this accordingly
DB_USER = "db user here" #change this accordingly
DB_PASSWORD = "db password here" #change this accordingly
DB_NAME = "salonoy"

JWT_SECRET_KEY = "super-secret-key"
```

### 6️⃣ Run the Server ⟢
```
python app.py
```

## ˚˖𓍢ִ໋❀ Authentication .ᐟ.ᐟ
Most endpoints are protected using JWT.

### 🌸 Login Credentials ⋆˚࿔
```
username: admin
password: admin
```
### 🌸 Login Request ⋆˚࿔
in your powershell:
```
$loginBody = @{
    username = "admin"
    password = "admin"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "http://127.0.0.1:5000/login" `
    -Method POST `
    -ContentType "application/json" `
    -Body $loginBody

$token = $loginResponse.access_token
$headers = @{ Authorization = "Bearer $token" }

Write-Host "JWT Token: $token"
```

### 🌼 Get all Customer ⋆˚࿔
```
Invoke-RestMethod -Uri http://127.0.0.1:5000/customers `
    -Method GET `
    -Headers $headers
```

### 🌼 Get Customer by their ID ⋆˚࿔
```
$customerId = 1 #sample ID

# Make the GET request
$customer = Invoke-RestMethod -Uri "http://127.0.0.1:5000/customers/$customerId" `
    -Method GET `
    -Headers $headers

# Output the result
Write-Host "Customer Details:"
$customer | Format-List
```

### 🌼 Create Customer ⋆˚࿔
```
$newCustomer = @{
    first_name = "eya"
    last_name  = "salonoy"
    phone_number = "09171234567"
    city = "Cityville"
    street = "123 mayo Street"
    province = "palawan"
} | ConvertTo-Json

$createResponse = Invoke-RestMethod -Uri "http://127.0.0.1:5000/customers" `
    -Method POST `
    -Headers $headers `
    -ContentType "application/json" `
    -Body $newCustomer

$customerId = $createResponse.customers_id
Write-Host "Created Customer ID: $customerId"
```

### 🌼 Update Customer ⋆˚࿔
```
$updateCustomer = @{
    phone_number = "09998887777"
    city = "New City"
} | ConvertTo-Json

$updateResponse = Invoke-RestMethod -Uri "http://127.0.0.1:5000/customers/$customerId" `
    -Method PUT `
    -Headers $headers `
    -ContentType "application/json" `
    -Body $updateCustomer

Write-Host "Update Response:" $updateResponse.message
```

### 🌼 Delete Customer ⋆˚࿔
```
$customerId = 20 #sample data

$response = Invoke-RestMethod -Uri "http://127.0.0.1:5000/customers/$customerId" `
    -Method DELETE `
    -Headers $headers

Write-Host "Delete Response:"
```

## ˚. ᵎᵎ Common Issues ּ ֶָ֢.

- **Unknown database** → Make sure salonoy.sql is imported

- **JWT error** → Ensure Authorization: Bearer <token> is set

- **Module not found** → Activate virtual environment

##  ⤷ Author  ๋࣭ ࣪ ˖🎐
<div style="text-align:center;"> <a href="https://github.com/sr-ea"> <img src="https://github.com/sr-ea.png" width="120" height="120" style="border-radius:50%; border:3px solid #ddd;"> </a>

 sr-ea ۶۟ৎ

Owner | CSE Final Project

<a href="https://github.com/sr-ea"> <img src="https://img.shields.io/badge/GitHub-sr--ea-black?style=for-the-badge&logo=github"> </a> </div>