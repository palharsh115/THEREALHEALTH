// Project: THEREALHEALTH





// File: index.js
// Description: This code is a Node.js Express server that handles user authentication, OTP verification, appointment booking, and blog management.
require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const twilio = require("twilio");
const multer = require("multer");
const path = require("path");

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

// User Schema with Role-Based Access
const userSchema = new mongoose.Schema({
  _id: { type: String, required: true }, // Phone number as _id
  name: { type: String, trim: true },
  age: { type: Number, min: 1 },
  weight: { type: Number },
  height: { value: Number },
  alternativePhoneNumber: { type: String, unique: true, sparse: true },
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

// OTP Schema
const otpSchema = new mongoose.Schema({
  phone: String,
  otp: String,
  createdAt: { type: Date, default: Date.now, expires: 300 } // Auto-delete OTP after 5 mins
});

const OTP = mongoose.model("OTP", otpSchema);

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

const authenticateAdmin = (req, res, next) => {
  authenticateUser(req, res, () => {
    if (req.user.role !== "admin") {
      return res.status(403).json({ message: "Access denied: Admins only" });
    }
    next();
  });
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

// Verify OTP API with Role-Based Authentication
app.post("/verify-otp", async (req, res) => {
  try {
    const { phone, otp } = req.body;
    if (!phone || !otp) {
      return res.status(400).json({ message: "Phone and OTP are required" });
    }

    // Verify OTP
    const record = await OTP.findOne({ phone });
    if (!record || String(record.otp) !== String(otp)) {
      return res.status(401).json({ message: "Invalid or expired OTP" });
    }

    // Delete OTP after verification
    await OTP.deleteMany({ phone });

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
    let user = await User.findOne({ _id: phone });
    let isNewUser = false;

    if (!user) {
      isNewUser = true;
      user = new User({ _id: phone, name: "New User", role: "user" }); // Default role is user
      await user.save();
    }

    // Generate JWT token for the user
    const token = jwt.sign({ phone, role: "user" }, JWT_SECRET, { expiresIn: "1h" });

    return res.json({
      message: isNewUser ? "New user created, proceed to registration" : "User exists, logging in",
      token,
      role: "user",
      isNewUser,
    });
  } catch (error) {
    console.error("Error in /verify-otp:", error);
    return res.status(500).json({ message: "Internal server error", error: error.message });
  }
});


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

// API to Fetch User Profile
app.get('/users/profile', authenticateUser, async (req, res) => {
  try {
    const user = await User.findById(req.user.id);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }
    res.json({ name: user.name });
  } catch (error) {
    console.error(error.message);
    res.status(500).json({ message: 'Server error' });
  }
});

app.listen(PORT, () => console.log(`✅ Server running on port ${PORT}`));
