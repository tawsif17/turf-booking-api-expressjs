## **🔄 Flow List**

---

### **🧑‍💼 1\. Admin Adds Turf and Assigns Owner**

1. Admin logs in.  
2. Clicks **"Add Turf"** → fills:  
   * Name, location, sport type(s), availability (days/hours)  
   * Time-based pricing (e.g., 6 AM – 6 PM \= 500 BDT/hr, 6 PM – 12 AM \= 700 BDT/hr)  
   * Owner's email or phone

3. System:  
   * Saves turf to DB  
   * Creates inactive owner account  
   * Sends secure "Set Password" link to owner

---

### **🧑‍💻 2\. Turf Owner Onboarding Flow**

1. Owner receives SMS/email → clicks link  
2. Sets password → account activated  
3. Logs into dashboard to:  
   * View turf details  
   * View/manage bookings  
   * Block slots  
   * View earnings

---

### **👤 3\. User Registration and Login**

#### **Registration**

1. User opens app/website  
2. Clicks “Register”  
3. Inputs name, phone, password  
4. Logs in using phone \+ password

#### **Login**

1. Enters phone \+ password  
2. On success → redirected to turf listing

---

### **🏟️ 4\. Turf Browsing & Booking**

1. User logs in

2. Sees available turfs (filter by location, sport, price, time)

3. Clicks a turf → sees profile:

   * Description, location, available time slots

   * Pricing per slot, turf duration options (30 min, 1 hr, etc.)

4. Selects:

   * Date, time, duration (e.g., 5 PM to 6 PM)

5. Fills form (pre-filled if logged in)

6. Redirected to payment page:

   * Pays via **bKash**

   * App takes commission, rest forwarded to turf owner

7. Booking confirmed

8. Receives SMS/email confirmation

---

### **🚫 5\. Booking Cancellation (User)**

1. User views "My Bookings"

2. Clicks cancel (only available if \>6 hours before start time)

3. System marks status \= cancelled

4. Sends notification to:

   * User

   * Turf owner

   * Admin

5. Refund process triggered (manual or API)

---

### **📊 6\. Turf Owner Dashboard**

1. Logs in

2. Views turf(s) and bookings

3. Can:

   * See user info, time, payment status

   * Block dates/time

   * View revenue (weekly/monthly)

---

### **🛠️ 7\. Admin Dashboard**

1. Admin logs in

2. Manages:

   * Turf list (add/edit/delete)

   * Owner assignments

   * All bookings

3. Views analytics:

   * Most booked turf

   * Revenue stats

