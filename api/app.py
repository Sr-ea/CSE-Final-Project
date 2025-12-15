from flask import Flask, jsonify, request, make_response
from flask_jwt_extended import JWTManager, jwt_required, create_access_token
import xml.etree.ElementTree as ET
from config import get_db_connection


app = Flask(__name__)
app.config["JWT_SECRET_KEY"] = "api-secret-key"
jwt = JWTManager(app)

# Helper Functions
def dict_to_xml(tag, d):
    elem = ET.Element(tag)
    if isinstance(d, list):
        for item in d:
            child = ET.SubElement(elem, "item")
            for k, v in item.items():
                sub = ET.SubElement(child, k)
                sub.text = str(v)
    else:
        for k, v in d.items():
            child = ET.SubElement(elem, k)
            child.text = str(v)
    return ET.tostring(elem, encoding="unicode")

def respond(data, status=200):
    fmt = request.args.get("format", "json").lower()
    if fmt == "xml":
        xml_data = dict_to_xml("response", data)
        response = make_response(xml_data, status)
        response.headers["Content-Type"] = "application/xml"
        return response
    else:
        return jsonify(data), status

def is_valid_phone(phone):
    return phone.isdigit() if phone else True

# Routes
@app.route("/")
def home():
    return jsonify(message="API is running")


# Login
@app.route("/login", methods=["POST"])
def login():
    data = request.json or {}
    username = data.get("username")
    password = data.get("password")

    if not username or not password:
        return jsonify({"error": "Missing username or password"}), 400

    if username == "admin" and password == "admin":
        token = create_access_token(identity=username)
        return jsonify({"access_token": token}), 200

    return jsonify({"error": "Invalid username or password"}), 401

# Customers CRUD
@app.route("/customers", methods=["GET"])
@jwt_required()
def get_customers():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM customers")
    data = cursor.fetchall()
    cursor.close()
    conn.close()
    return respond(data)

@app.route("/customers/<int:customer_id>", methods=["GET"])
@jwt_required()
def get_customer(customer_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM customers WHERE customers_id = %s", (customer_id,))
    customer = cursor.fetchone()
    cursor.close()
    conn.close()
    if not customer:
        return respond({"error": "Customer not found"}, 404)
    return respond(customer)

@app.route("/customers", methods=["POST"])
@jwt_required()
def create_customer():
    data = request.json or {}
    first_name = data.get("first_name")
    last_name = data.get("last_name")
    phone_number = data.get("phone_number")
    city = data.get("city")
    street = data.get("street")
    province = data.get("province")

    if not first_name or not last_name:
        return respond({"error": "Missing required fields: first_name or last_name"}, 400)
    if not is_valid_phone(phone_number):
        return respond({"error": "Phone number must be numeric"}, 400)

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        """
        INSERT INTO customers (first_name, last_name, phone_number, city, street, province)
        VALUES (%s, %s, %s, %s, %s, %s)
        """,
        (first_name, last_name, phone_number, city, street, province)
    )
    conn.commit()
    new_id = cursor.lastrowid
    cursor.close()
    conn.close()

    return respond({
        "customers_id": new_id,
        "first_name": first_name,
        "last_name": last_name,
        "phone_number": phone_number,
        "city": city,
        "street": street,
        "province": province
    }, 201)

@app.route("/customers/<int:customer_id>", methods=["PUT"])
@jwt_required()
def update_customer(customer_id):
    data = request.json or {}
    fields = {k: v for k, v in data.items() if k in ["first_name", "last_name", "phone_number", "city", "street", "province"]}

    if not fields:
        return respond({"error": "No fields to update"}, 400)
    if "phone_number" in fields and not is_valid_phone(fields["phone_number"]):
        return respond({"error": "Phone number must be numeric"}, 400)

    set_clause = ", ".join(f"{k} = %s" for k in fields.keys())
    params = list(fields.values())
    params.append(customer_id)

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT customers_id FROM customers WHERE customers_id = %s", (customer_id,))
    if cursor.fetchone() is None:
        cursor.close()
        conn.close()
        return respond({"error": "Customer not found"}, 404)

    cursor.execute(f"UPDATE customers SET {set_clause} WHERE customers_id = %s", tuple(params))
    conn.commit()
    cursor.close()
    conn.close()

    return respond({"message": "Customer updated", "customers_id": customer_id})

@app.route("/customers/<int:customer_id>", methods=["DELETE"])
@jwt_required()
def delete_customer(customer_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT customers_id FROM customers WHERE customers_id = %s", (customer_id,))
    if cursor.fetchone() is None:
        cursor.close()
        conn.close()
        return respond({"error": "Customer not found"}, 404)

    cursor.execute("DELETE FROM customers WHERE customers_id = %s", (customer_id,))
    conn.commit()
    cursor.close()
    conn.close()
    return respond({"message": "Customer deleted", "customers_id": customer_id})

# Search Endpoint
@app.route("/customers/search", methods=["GET"])
@jwt_required()
def search_customers():
    query = request.args.get("q", "").lower()
    if not query:
        return respond({"error": "Query parameter 'q' is required"}, 400)

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM customers")
    all_customers = cursor.fetchall()
    cursor.close()
    conn.close()

    results = [
        c for c in all_customers
        if any(query in str(v).lower() for k, v in c.items() if isinstance(v, str))
    ]

    return respond({"results": results})

if __name__ == "__main__":
    app.run(debug=True)
