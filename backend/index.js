<<<<<<< HEAD
// Project: THEREALHEALTH
=======

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
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c




<<<<<<< HEAD

// File: index.js
// Description: This code is a Node.js Express server that handles user authentication, OTP verification, appointment booking, and blog management.
=======
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const twilio = require("twilio");
<<<<<<< HEAD
const multer = require("multer");
const path = require("path");
=======
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c

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

<<<<<<< HEAD
    
=======
  
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
  //schema for questionair...
  const QuestionnaireSchema = new mongoose.Schema({
    question: { type: String, required: true },
    answer: { type: String, required: true }, // "Yes" or "No"
  });
  
  // Schema for storing health conditions with their questionnaire responses
  const HealthConditionSchema = new mongoose.Schema({
    conditionName: { type: String, required: true }, // Example: "Diabetes", "Thyroid"
    questionnaireResponses: [QuestionnaireSchema], // Stores responses for each condition
  });
<<<<<<< HEAD

// User Schema with Role-Based Access
=======
   

// User Schema (Phone is Primary ID)
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
const userSchema = new mongoose.Schema({
  _id: { type: String, required: true }, // Phone number as _id
  name: { type: String, trim: true },
  age: { type: Number, min: 1 },
  weight: { type: Number },
  height: { value: Number },
  alternativePhoneNumber: { type: String, unique: true, sparse: true },
<<<<<<< HEAD
  role: { type: String, enum: ["user", "admin"], default: "user" }, // Role-based access
  healthConditions: [HealthConditionSchema], // Stores selected conditions & responses
  appointments: [{ type: String, ref: "Appointment" }], // Reference to appointments
}, { timestamps: true });

const User = mongoose.model("User", userSchema);

// Admin Schema
const adminSchema = new mongoose.Schema({
  _id: { type: String, required: true }, // Phone number as _id
  name: { type: String, required: true },
  role: { type: String, enum: ["admin"], default: "admin" }, // Role-based access
  createdAt: { type: Date, default: Date.now },
});

const Admin = mongoose.model("Admin", adminSchema);

=======
  appointments: [{
    date: { type: String, required: true },
    timeSlot: { type: String, required: true },
    status: { type: String, enum: ["pending", "confirmed", "canceled"], default: "pending" }
  }],
 
healthConditions: [HealthConditionSchema] // Stores selected conditions & responses
},
{ timestamps: true });

const User = mongoose.model("User", userSchema);

>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
// OTP Schema
const otpSchema = new mongoose.Schema({
  phone: String,
  otp: String,
  createdAt: { type: Date, default: Date.now, expires: 300 } // Auto-delete OTP after 5 mins
});

const OTP = mongoose.model("OTP", otpSchema);

<<<<<<< HEAD
// Blog Schema
const blogSchema = new mongoose.Schema({
  title: { type: String, required: true },
  content: { type: String, required: true },
  createdAt: { type: Date, default: Date.now },
  image: { type: String }, // Add image field to Blog schema
});

const Blog = mongoose.model("Blog", blogSchema);

// Appointment Schema
const appointmentSchema = new mongoose.Schema({
  _id: { type: String, required: true }, // Reference to User
  userName: { type: String, required: true },
  date: { type: String, required: true },
  timeSlot: { type: String, required: true },
  status: { type: String, enum: ["pending", "confirmed", "canceled"], default: "pending" },
}, { timestamps: true });

const Appointment = mongoose.model("Appointment", appointmentSchema);

// Authentication Middleware
=======
// Middleware to Authenticate User
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
const authenticateUser = (req, res, next) => {
  try {
    const token = req.headers.authorization?.split(" ")[1];
    if (!token) return res.status(401).json({ message: "Unauthorized: Token missing" });
<<<<<<< HEAD
    
=======

>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(401).json({ message: "Invalid or expired token" });
  }
};

<<<<<<< HEAD
const authenticateAdmin = (req, res, next) => {
  authenticateUser(req, res, () => {
    if (req.user.role !== "admin") {
      return res.status(403).json({ message: "Access denied: Admins only" });
    }
    next();
  });
};

=======
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
// Generate a 6-digit OTP
const generateOTP = () => Math.floor(100000 + Math.random() * 900000).toString();

// Send OTP API
app.post("/send-otp", async (req, res) => {
  const { phone } = req.body;
  if (!phone) return res.status(400).json({ message: "Phone number is required" });

  const otp = generateOTP();

  try {
    await OTP.create({ phone, otp });

<<<<<<< HEAD
=======
    // let user = await User.findById(phone);
    // if (!user) {
    //   user = new User({ _id: phone });
    //   await user.save();
    // }

>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
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

<<<<<<< HEAD
// Verify OTP API with Role-Based Authentication
=======
// // Verify OTP API
// app.post("/verify-otp", async (req, res) => {
//   try {
//     const { phone, otp } = req.body;
//     if (!phone || !otp) return res.status(400).json({ message: "Phone and OTP are required" });

//     const record = await OTP.findOne({ phone });
//     if (!record || String(record.otp) !== String(otp)) {
//       return res.status(401).json({ message: "Invalid or expired OTP" });
//     }

//     await OTP.deleteMany({ phone });

//     let user = await User.findById(phone);

//     const token = jwt.sign({ phone }, JWT_SECRET, { expiresIn: "1h" });

//     res.json({ message: "OTP verified successfully", token });

//     if (user) {
//       res.json({ message: "User exists, logging in", token, isNewUser: false });
//     } else {
//       res.json({ message: "New user, proceed to registration", token, isNewUser: true });
//     }
//   } catch (error) {
//     res.status(500).json({ message: "Internal server error", error: error.message });
//   }
// });
//verify otp 
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
app.post("/verify-otp", async (req, res) => {
  try {
    const { phone, otp } = req.body;
    if (!phone || !otp) {
      return res.status(400).json({ message: "Phone and OTP are required" });
    }

<<<<<<< HEAD
    // Verify OTP
=======
    // Find OTP record
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
    const record = await OTP.findOne({ phone });
    if (!record || String(record.otp) !== String(otp)) {
      return res.status(401).json({ message: "Invalid or expired OTP" });
    }

    // Delete OTP after verification
    await OTP.deleteMany({ phone });

<<<<<<< HEAD
    // Check if the phone number exists in the Admin collection
    const isAdmin = await Admin.findById(phone);

    if (isAdmin) {
      // If the phone number belongs to an admin, do not save it in the User collection
      const token = jwt.sign({ phone, role: "admin" }, JWT_SECRET, { expiresIn: "1h" });
      return res.json({
        message: "Admin logged in successfully",
        token,
        role: "admin",
      });
    }

    // Check if the user exists in the User collection
=======
    // ✅ Fix: Use findOne instead of findById
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
    let user = await User.findOne({ _id: phone });
    let isNewUser = false;

    if (!user) {
      isNewUser = true;
<<<<<<< HEAD
      user = new User({ _id: phone, name: "New User", role: "user" }); // Default role is user
      await user.save();
    }

    // Generate JWT token for the user
    const token = jwt.sign({ phone, role: "user" }, JWT_SECRET, { expiresIn: "1h" });
=======
      user = new User({ _id: phone }); // Create user with phone as _id
      await user.save();
    }

    // ✅ Generate JWT token for both new & existing users
    const token = jwt.sign({ phone }, JWT_SECRET, { expiresIn: "1h" });
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c

    return res.json({
      message: isNewUser ? "New user created, proceed to registration" : "User exists, logging in",
      token,
<<<<<<< HEAD
      role: "user",
=======
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
      isNewUser,
    });
  } catch (error) {
    console.error("Error in /verify-otp:", error);
    return res.status(500).json({ message: "Internal server error", error: error.message });
  }
});


<<<<<<< HEAD
// Predefine Admin Users
const predefinedAdmins = [
  { _id: "9917668808", name: "harsh", role: "admin" },
];

predefinedAdmins.forEach(async (admin) => {
  const existingAdmin = await Admin.findById(admin._id);
  if (!existingAdmin) {
    await new Admin(admin).save();
  }
 });

//registration form

=======
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
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
<<<<<<< HEAD
// API to Book an Appointment
app.post("/book-appointment", authenticateUser, async (req, res) => {
  try {
    const { date, timeSlot } = req.body;

    // Validate input
    if (!date || !timeSlot) {
      return res.status(400).json({ message: "Date and time slot are required" });
    }

    // Get the user ID from the authenticated user's schema (req.user)
    const userId = req.user.phone;

    // Find the user
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Check if the user already has an appointment for the same date and time slot
    const existingAppointment = await Appointment.findOne({ _id: userId, date, timeSlot });
    if (existingAppointment) {
      return res.status(400).json({ message: "Time slot already booked" });
    }

    // Create a new appointment
    const newAppointment = new Appointment({
      _id: userId, // Use the user's phone number as the appointment ID
      userName: user.name,
      date,
      timeSlot,
      status: "pending",
    });

    await newAppointment.save();

    // Add the appointment ID to the user's appointments array
    user.appointments.push(newAppointment._id);
    await user.save();

    res.status(201).json({ message: "Appointment booked successfully!", appointment: newAppointment });
  } catch (error) {
    console.error("Error booking appointment:", error.message);
=======

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
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
    res.status(500).json({ error: "Server error" });
  }
});

// api end poit to save health condition data...
app.post("/submit-health-data", authenticateUser, async (req, res) => {
  try {
    const phone = req.user.phone;
    const { selectedCondition, otherCondition, questionnaireResponses } = req.body;

    if (!selectedCondition) {
      return res.status(400).json({ message: "Health condition is required" });
    }

    // Find user
    let user = await User.findById(phone);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Check if the condition already exists
    const existingCondition = user.healthConditions.find(
      (condition) => condition.conditionName === selectedCondition
    );

    if (existingCondition) {
      // Update existing condition responses
      existingCondition.questionnaireResponses = questionnaireResponses || [];
    } else {
      // Add new health condition entry
      user.healthConditions.push({
        conditionName: selectedCondition,
        questionnaireResponses: questionnaireResponses || [],
      });
    }

    // If "Other" condition is provided, save it
    if (selectedCondition === "Others" && otherCondition) {
      user.healthConditions.push({
        conditionName: otherCondition,
        questionnaireResponses: questionnaireResponses || [],
      });
    }

    // Save the updated user data
    await user.save();

    res.status(200).json({ message: "Health data submitted successfully", user });
  } catch (error) {
    res.status(500).json({ error: "Internal server error", details: error.message });
  }
});

// get questionair user data ...
app.post("/submit-questionnaire", authenticateUser, async (req, res) => {
  try {
    const phone = req.user.phone;
    const { conditionName, responses } = req.body;

    if (!conditionName || !responses || !Array.isArray(responses)) {
      return res.status(400).json({ message: "Invalid request format" });
    }

    // Find user
    let user = await User.findById(phone);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Check if the health condition exists
    const existingCondition = user.healthConditions.find(
      (condition) => condition.conditionName === conditionName
    );

    if (existingCondition) {
      // Update existing responses
      existingCondition.questionnaireResponses = responses;
    } else {
      // Add new condition with responses
      user.healthConditions.push({
        conditionName,
        questionnaireResponses: responses,
      });
    }

    // Save user data
    await user.save();

    res.status(200).json({ message: "Questionnaire submitted successfully", user });
  } catch (error) {
    res.status(500).json({ error: "Internal server error", details: error.message });
  }
});

<<<<<<< HEAD
// Configure Multer for file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/"); // Directory to save uploaded images
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname)); // Unique filename
  },
});
const upload = multer({ storage });

// API to Post a Blog with Image
app.post("/admin/blogs", authenticateAdmin, upload.single("image"), async (req, res) => {
  try {
    const { title, content } = req.body;
    const imageUrl = req.file ? `/uploads/${req.file.filename}` : null;

    if (!title || !content) {
      return res.status(400).json({ message: "Title and content are required" });
    }

    const newBlog = new Blog({
      title,
      content,
      image: imageUrl,
      createdAt: new Date(),
    });

    await newBlog.save();

    res.status(201).json({ message: "Blog posted successfully", blog: newBlog });
  } catch (error) {
    console.error("Error posting blog:", error.message);
    res.status(500).json({ message: "Server error", error: error.message });
  }
});

// API to Fetch Blogs
app.get("/blogs", async (req, res) => {
  try {
    const blogs = await Blog.find().sort({ createdAt: -1 });
    res.status(200).json(blogs);
  } catch (error) {
    res.status(500).json({ message: "Error fetching blogs", error: error.message });
  }
});

// API to Delete a Blog
app.delete("/admin/blogs/:id", authenticateAdmin, async (req, res) => {
  try {
    const { id } = req.params;

    const deletedBlog = await Blog.findByIdAndDelete(id);
    if (!deletedBlog) {
      return res.status(404).json({ message: "Blog not found" });
    }

    res.status(200).json({ message: "Blog deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: "Error deleting blog", error: error.message });
  }
});

// API to Fetch All Users with Full Details
app.get("/admin/users", authenticateAdmin, async (req, res) => {
  try {
    // Fetch all users
    const users = await User.find().populate("healthConditions").exec();

    // Fetch appointments for each user
    const usersWithAppointments = await Promise.all(
      users.map(async (user) => {
        const appointments = await Appointment.find({ _id: user._id }); // Match appointments by user ID (phone number)
        return {
          ...user.toObject(), // Convert Mongoose document to plain object
          appointments, // Add appointments to the user object
        };
      })
    );

    res.status(200).json(usersWithAppointments);
  } catch (error) {
    console.error("Error fetching users:", error.message);
    res.status(500).json({ message: "Error fetching users", error: error.message });
  }
});

// API to Fetch All Appointments for Admin
app.get("/admin/appointments", authenticateAdmin, async (req, res) => {
  try {
    // Fetch all appointments
    const appointments = await Appointment.find();
    res.status(200).json(appointments);
  } catch (error) {
    console.error("Error fetching appointments:", error.message);
    res.status(500).json({ message: "Error fetching appointments", error: error.message });
  }
});

// API to Fetch Total Records (Stats)
app.get("/admin/stats", authenticateAdmin, async (req, res) => {
  try {
    // Fetch total users
    const totalUsers = await User.countDocuments();

    // Fetch total appointments
    const totalAppointments = await Appointment.countDocuments();

    // Fetch total health records
    const totalHealthRecords = await User.aggregate([
      { $unwind: "$healthConditions" }, // Unwind the healthConditions array
      { $count: "totalHealthRecords" }, // Count the total number of health records
    ]);

    res.status(200).json({
      totalUsers,
      totalAppointments,
      totalHealthRecords: totalHealthRecords[0]?.totalHealthRecords || 0,
    });
  } catch (error) {
    console.error("Error fetching stats:", error.message);
    res.status(500).json({ message: "Error fetching stats", error: error.message });
  }
});

// API to Create a New User
app.post("/admin/users", authenticateAdmin, async (req, res) => {
  try {
    const { _id, name, age, weight, height, alternativePhoneNumber, role } = req.body;

    if (!_id || !name) {
      return res.status(400).json({ message: "Phone number and name are required" });
    }

    const existingUser = await User.findById(_id);
    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    const newUser = new User({
      _id,
      name,
      age,
      weight,
      height: { value: height },
      alternativePhoneNumber,
      role: role || "user", // Default role is "user"
    });

    await newUser.save();
    res.status(201).json({ message: "User created successfully", user: newUser });
  } catch (error) {
    console.error("Error creating user:", error.message);
    res.status(500).json({ message: "Error creating user", error: error.message });
  }
});

// API to Get User Details by ID
app.get("/admin/users/:id", authenticateAdmin, async (req, res) => {
  try {
    const { id } = req.params;

    const user = await User.findById(id).populate("appointments").exec();
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json({ user });
  } catch (error) {
    console.error("Error fetching user details:", error.message);
    res.status(500).json({ message: "Error fetching user details", error: error.message });
  }
});

// API to Update User Details
app.put("/admin/users/:id", authenticateAdmin, async (req, res) => {
  try {
    const { id } = req.params;
    const { name, age, weight, height, alternativePhoneNumber, role } = req.body;

    const updatedUser = await User.findByIdAndUpdate(
      id,
      {
        name,
        age,
        weight,
        height: { value: height },
        alternativePhoneNumber,
        role,
      },
      { new: true, runValidators: true }
    );

    if (!updatedUser) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json({ message: "User updated successfully", user: updatedUser });
  } catch (error) {
    console.error("Error updating user:", error.message);
    res.status(500).json({ message: "Error updating user", error: error.message });
  }
});

// API to Delete a User
app.delete("/admin/users/:id", authenticateAdmin, async (req, res) => {
  try {
    const { id } = req.params;

    // Delete the user
    const deletedUser = await User.findByIdAndDelete(id);
    if (!deletedUser) {
      return res.status(404).json({ message: "User not found" });
    }

    // Delete the user's appointments
    await Appointment.deleteMany({ _id: id });

    res.status(200).json({ message: "User and associated data deleted successfully" });
  } catch (error) {
    console.error("Error deleting user:", error.message);
    res.status(500).json({ message: "Error deleting user", error: error.message });
  }
});

// API to Fetch Appointments for a Specific User
app.get("/admin/users/:id/appointments", authenticateAdmin, async (req, res) => {
  try {
    const { id } = req.params;

    const appointments = await Appointment.find({ _id: id });
    if (!appointments) {
      return res.status(404).json({ message: "No appointments found for this user" });
    }

    res.status(200).json(appointments);
  } catch (error) {
    console.error("Error fetching appointments:", error.message);
    res.status(500).json({ message: "Error fetching appointments", error: error.message });
  }
});

// API to Fetch Health Conditions for a Specific User
app.get("/admin/users/:id/health-conditions", authenticateAdmin, async (req, res) => {
  try {
    const { id } = req.params;

    const user = await User.findById(id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json(user.healthConditions);
  } catch (error) {
    console.error("Error fetching health conditions:", error.message);
    res.status(500).json({ message: "Error fetching health conditions", error: error.message });
  }
});

app.put("/admin/appointments/:id", authenticateAdmin, async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    // Validate status
    if (!["pending", "approved", "canceled"].includes(status)) {
      return res.status(400).json({ message: "Invalid status" });
    }

    // Update the appointment status
    const updatedAppointment = await Appointment.findByIdAndUpdate(
      id,
      { status },
      { new: true }
    );

    if (!updatedAppointment) {
      return res.status(404).json({ message: "Appointment not found" });
    }

    res.status(200).json({ message: "Appointment status updated", appointment: updatedAppointment });
  } catch (error) {
    console.error("Error updating appointment:", error.message);
    res.status(500).json({ message: "Server error", error: error.message });
  }
});

// API to Fetch User Details for Dashboard
app.get("/user/details", authenticateUser, async (req, res) => {
  try {
    const phone = req.user.phone;

    const user = await User.findById(phone);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json({ message: "User details fetched successfully", user });
  } catch (error) {
    console.error("Error fetching user details:", error.message);
    res.status(500).json({ message: "Error fetching user details", error: error.message });
=======

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

// get health condition with questionair data...
app.get("/get-user-health", authenticateUser, async (req, res) => {
  try {
    const phone = req.user.phone;
    
    const user = await User.findById(phone).select("healthConditions");
    if (!user) return res.status(404).json({ message: "User not found" });

    res.json(user.healthConditions);
  } catch (error) {
    res.status(500).json({ error: "Internal server error", details: error.message });
>>>>>>> 6ad1d47e8786c0bad2274c6be52b164ab0035c7c
  }
});


app.listen(PORT, () => console.log(`✅ Server running on port ${PORT}`));
