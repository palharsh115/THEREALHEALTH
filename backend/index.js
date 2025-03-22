
// require("dotenv").config();
// const express = require("express");
// const mongoose = require("mongoose");
// const cors = require("cors");
// const bodyParser = require("body-parser");
// const twilio = require("twilio");
// const jwt = require("jsonwebtoken");

// const app = express();
// const PORT = process.env.PORT || 3000;
// const JWT_SECRET = process.env.JWT_SECRET ;

// app.use(cors());
// app.use(bodyParser.json());

// // Twilio Credentials
// const accountSid = process.env.TWILIO_ACCOUNT_SID;
// const authToken = process.env.TWILIO_AUTH_TOKEN;
// const twilioPhoneNumber = process.env.TWILIO_PHONE_NUMBER;
// const client = twilio(accountSid, authToken);

// // Connect to MongoDB
// async function connectDb(){
//   await mongoose.connect(process.env.MONGO_URI, {
//     useNewUrlParser: true,
//     useUnifiedTopology: true,
//   });
// }

// connectDb()
// .then(()=>{
//   console.log("connected");
// })
// .catch((err)=>{
//   console.log(err);
// });

// let otpSchema=new mongoose.Schema({
//   phone: String,
//   otp: String,
//   createdAt: { type: Date, default: Date.now() }, 
// });

// const OTP = mongoose.model("OTP", otpSchema);

// // Function to generate a 6-digit OTP
// function generateOTP() {
//   return Math.floor(100000 + Math.random() * 900000).toString();
// }

// // Send OTP
// app.post("/send-otp", async (req, res) => {
//   const { phone } = req.query;
//   if (!phone) return res.status(400).json({ message: "Phone number is required" });
 
//   const otp = generateOTP();

//   try {
//     // Save OTP to database
//      await OTP.create({phone,otp});

//     //  let user = await User.findById(phone);
//     // if (!user) {
//     //   user = new User({ _id: phone }); // Create user with phone as _id
//     //   await user.save();
//     // }


//     // Send OTP via Twilio
//     await client.messages.create({
//       body: `Your OTP code is: ${otp}`,
//       from: twilioPhoneNumber,
//       to: `+91${phone}`,
//     });

//     res.json({ message: "OTP sent successfully" });
//   } catch (error) {
//     console.error("Error sending OTP:", error.message || error);
//     res.status(500).json({ message: "Error sending OTP", error: error.message });
//   }
// });



// app.post("/verify-otp", async (req, res) => {
//   try {
//     const { phone, otp } = req.body;

//     if (!phone || !otp) return res.status(400).json({ message: "Phone and OTP are required" });

//     console.log(`Checking OTP for phone: ${phone}, entered OTP: ${otp}`);

//     const record = await OTP.findOne({ phone });
     
//     if (!record) {
//       console.error(`No OTP found for phone: ${phone}`);
//       return res.status(401).json({ message: "Invalid or expired OTP" });
//     }

//     console.log("Fetched OTP Record:", record);

//     // Ensure OTP is correctly compared
//     if (String(record.otp) !== String(otp)) {
//       console.error(`OTP mismatch! Entered: ${otp}, Stored: ${record.otp}`);
//       return res.status(401).json({ message: "Invalid OTP" });
//     }

//     console.log("OTP matched successfully!");

//     await OTP.deleteMany({ phone }); // Clear used OTPs
  
    
//     // if (!user) {
//     //   user = new User({ phone }); // Creating new user if not found
//     //   await user.save();
//     // }

//     // 🔹 Generate JWT Token with `userId`
//     const token = jwt.sign({ phone }, JWT_SECRET, { expiresIn: "1h" });

//     // const token = jwt.sign({ phone }, JWT_SECRET, { expiresIn: "1h" });
    
//     res.json({ message: "OTP verified successfully", token });
//   } catch (error) {
//     console.error("Error verifying OTP:", error.message);
//     res.status(500).json({ message: "Internal server error", error: error.message });
//   }
// });


// app.post("/resend-otp", async (req, res) => {
//   const { phone } = req.body;
  
//   if (!phone) return res.status(400).json({ message: "Phone number is required" });
  
//   const otp = generateOTP();

//   try {
//     // Save OTP to database
//      await OTP.create({phone,otp});

//     // Send OTP via Twilio
//     await client.messages.create({
//       body: `Your OTP code is: ${otp}`,
//       from: twilioPhoneNumber,
//       to: `+91${phone}`,
//     });

//     res.json({ message: "OTP sent successfully" });
//   } catch (error) {
//     console.error("Error sending OTP:", error.message || error);
//     res.status(500).json({ message: "Error sending OTP", error: error.message });
//   }
// });



// // register form

// mongoose
//   .connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
//   .then(() => console.log("MongoDB connected"))
//   .catch((err) => console.log(err));


// // Form Schema
// const formSchema = new mongoose.Schema({
//  // _id: { type: String, required: true },
//   name: { type: String, required: true, trim: true },
//   age: { type: Number, required: true, min: 1 },
//   weight: { type: Number, required: true },
//   height: { 
//     value: { type: Number, required: true },
//     //unit: { type: String, enum: ["cm", "ft"], required: false }
//   },
//   alternativePhoneNumber: { type: String, unique: true, sparse: true }, // Optional but unique
// }, { timestamps: true });

// const Form = mongoose.model("Form", formSchema);

// // Form Submission API
// app.post("/submit-form", async (req, res) => {
//   try {
//     let { name, age, weight, height,  alternativePhoneNumber } = req.body;

//     // Validate height unit
//     // if (!["cm", "ft"].includes(heightUnit)) {
//     //   return res.status(400).json({ error: "Invalid height unit. Use 'cm' or 'ft'." });
//     // }

//     const newFormEntry = new Form({
//       name,
//       age,
//       weight,
//       height: { value: height },
//       alternativePhoneNumber: alternativePhoneNumber ? alternativePhoneNumber.trim() : undefined,
//     });

//     await newFormEntry.save();

// //     const updatedUser = await User.findByIdAndUpdate(
// //       phone, // Find user by phone number (_id)
// //       {
// //         name,
// //         age,
// //         weight,
// //         height: { value: height },
// //         alternativePhoneNumber,
// //       },
// //       { new: true, upsert: true } // Upsert ensures user is created if not found
// //     );
//     res.status(201).json({ message: "Form submitted successfully!" });
//   } catch (error) {
//     console.error("Error submitting form:", error.message);
//     res.status(500).json({ error: "Internal server error", details: error.message });
//   }
// });


// //appointment....
// mongoose
//   .connect(process.env.MONGO_URI, { useNewUrlParser: true, useUnifiedTopology: true })
//   .then(() => console.log("MongoDB  appointment connected"))
//   .catch((err) => console.log(err));

//   const AppointmentSchema = new mongoose.Schema({
//    // userId: { type: String, required: true, ref: "User" },
//     date: { type: String, required: true }, // Appointment Date (YYYY-MM-DD)
//     timeSlot: { type: String, required: true }, // Time Slot (e.g., "10:00 AM - 11:00 AM")
//     status: { 
//       type: String, 
//       enum: ["pending", "confirmed", "canceled"], 
//       default: "pending" 
//     }, // Appointment Status
//   }, { timestamps: true });
  
//   const Appointment = mongoose.model("Appointment", AppointmentSchema);

//   app.post("/book-appointment", async (req, res) => {
//     try {
//       const {date, timeSlot } = req.body;
  
//       if (!date || !timeSlot) {
//         return res.status(400).json({ error: "Missing required fields" });
//       }

//       // const userExists = await User.findById(phone);
//       // if (!userExists) return res.status(404).json({ message: "User not found" });
  
  
//       // Check if time slot is already booked
//       const existingAppointment = await Appointment.findOne({ date, timeSlot });
//       if (existingAppointment) {
//         return res.status(400).json({ error: "Time slot already booked" });
//       }
  
//       const newAppointment = new Appointment({ date, timeSlot });
//       await newAppointment.save();
  
//       res.json({ message: "Appointment booked successfully!" });
//     } catch (err) {
//       res.status(500).json({ error: "Server error" });
//     }
//   });
  
  
//   app.listen(PORT, () => console.log(`Server running on port ${PORT}`));




require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const twilio = require("twilio");

const app = express();
const PORT = process.env.PORT || 3000;
const JWT_SECRET = process.env.JWT_SECRET;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Twilio Credentials
const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const twilioPhoneNumber = process.env.TWILIO_PHONE_NUMBER;
const client = twilio(accountSid, authToken);

// Connect to MongoDB
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => console.log("✅ MongoDB Connected"))
  .catch((err) => console.error("❌ MongoDB Connection Error:", err));

// User Schema (Phone is Primary ID)
const userSchema = new mongoose.Schema({
  _id: { type: String, required: true }, // Phone number as _id
  name: { type: String, trim: true },
  age: { type: Number, min: 1 },
  weight: { type: Number },
  height: { value: Number },
  alternativePhoneNumber: { type: String, unique: true, sparse: true },
  appointments: [{
    date: { type: String, required: true },
    timeSlot: { type: String, required: true },
    status: { type: String, enum: ["pending", "confirmed", "canceled"], default: "pending" }
  }]
}, { timestamps: true });

const User = mongoose.model("User", userSchema);

// OTP Schema
const otpSchema = new mongoose.Schema({
  phone: String,
  otp: String,
  createdAt: { type: Date, default: Date.now, expires: 300 } // Auto-delete OTP after 5 mins
});

const OTP = mongoose.model("OTP", otpSchema);

// Middleware to Authenticate User
const authenticateUser = (req, res, next) => {
  try {
    const token = req.headers.authorization?.split(" ")[1];
    if (!token) return res.status(401).json({ message: "Unauthorized: Token missing" });

    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(401).json({ message: "Invalid or expired token" });
  }
};

// Generate a 6-digit OTP
const generateOTP = () => Math.floor(100000 + Math.random() * 900000).toString();

// Send OTP API
app.post("/send-otp", async (req, res) => {
  const { phone } = req.body;
  if (!phone) return res.status(400).json({ message: "Phone number is required" });

  const otp = generateOTP();

  try {
    await OTP.create({ phone, otp });

    let user = await User.findById(phone);
    if (!user) {
      user = new User({ _id: phone });
      await user.save();
    }

    await client.messages.create({
      body: `Your OTP code is: ${otp}`,
      from: twilioPhoneNumber,
      to: `+91${phone}`,
    });

    res.json({ message: "OTP sent successfully" });
  } catch (error) {
    res.status(500).json({ message: "Error sending OTP", error: error.message });
  }
});

// Verify OTP API
app.post("/verify-otp", async (req, res) => {
  try {
    const { phone, otp } = req.body;
    if (!phone || !otp) return res.status(400).json({ message: "Phone and OTP are required" });

    const record = await OTP.findOne({ phone });
    if (!record || String(record.otp) !== String(otp)) {
      return res.status(401).json({ message: "Invalid or expired OTP" });
    }

    await OTP.deleteMany({ phone });

    const token = jwt.sign({ phone }, JWT_SECRET, { expiresIn: "1h" });

    res.json({ message: "OTP verified successfully", token });
  } catch (error) {
    res.status(500).json({ message: "Internal server error", error: error.message });
  }
});

// Submit Form API (Updates User Data)
app.post("/submit-form", authenticateUser, async (req, res) => {
  try {
    const phone = req.user.phone;
    const { name, age, weight, height, alternativePhoneNumber } = req.body;

    const updatedUser = await User.findByIdAndUpdate(
      phone,
      { name, age, weight, height: { value: height }, alternativePhoneNumber },
      { new: true, upsert: true }
    );

    res.status(201).json({ message: "Form submitted successfully!", user: updatedUser });
  } catch (error) {
    res.status(500).json({ error: "Internal server error", details: error.message });
  }
});

// Book Appointment API
app.post("/book-appointment", authenticateUser, async (req, res) => {
  try {
    const phone = req.user.phone;
    const { date, timeSlot } = req.body;

    const user = await User.findById(phone);
    if (!user) return res.status(404).json({ message: "User not found" });

    const existingAppointment = user.appointments.find(appt => appt.date === date && appt.timeSlot === timeSlot);
    if (existingAppointment) return res.status(400).json({ error: "Time slot already booked" });

    user.appointments.push({ date, timeSlot });
    await user.save();

    res.json({ message: "Appointment booked successfully!", user });
  } catch (err) {
    res.status(500).json({ error: "Server error" });
  }
});

// Get User Details API
app.get("/get-user", authenticateUser, async (req, res) => {
  try {
    const phone = req.user.phone;
    const user = await User.findById(phone);
    if (!user) return res.status(404).json({ message: "User not found" });

    res.json({ user });
  } catch (error) {
    res.status(500).json({ error: "Internal server error", details: error.message });
  }
});

app.listen(PORT, () => console.log(`✅ Server running on port ${PORT}`));
