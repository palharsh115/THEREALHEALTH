
require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const bodyParser = require("body-parser");
const twilio = require("twilio");
const jwt = require("jsonwebtoken");

const app = express();
const PORT = process.env.PORT || 3000;
const JWT_SECRET = process.env.JWT_SECRET ;

app.use(cors());
app.use(bodyParser.json());

// Twilio Credentials
const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const twilioPhoneNumber = process.env.TWILIO_PHONE_NUMBER;
const client = twilio(accountSid, authToken);

// Connect to MongoDB
async function connectDb(){
  await mongoose.connect(process.env.MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });
}

connectDb()
.then(()=>{
  console.log("connected");
})
.catch((err)=>{
  console.log(err);
});

let otpSchema=new mongoose.Schema({
  phone: String,
  otp: String,
  createdAt: { type: Date, default: Date.now(), expires: 30 }, // OTP expires in 5 mins
});

const OTP = mongoose.model("OTP", otpSchema);

// Function to generate a 6-digit OTP
function generateOTP() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

// Send OTP
app.post("/send-otp", async (req, res) => {
  const { phone } = req.query;
  if (!phone) return res.status(400).json({ message: "Phone number is required" });
 
  const otp = generateOTP();

  try {
    // Save OTP to database
     await OTP.create({phone,otp});

    // Send OTP via Twilio
    await client.messages.create({
      body: `Your OTP code is: ${otp}`,
      from: twilioPhoneNumber,
      to: `+91${phone}`,
    });

    res.json({ message: "OTP sent successfully" });
  } catch (error) {
    console.error("Error sending OTP:", error.message || error);
    res.status(500).json({ message: "Error sending OTP", error: error.message });
  }
});



app.post("/verify-otp", async (req, res) => {
  try {
    const { phone, otp } = req.body;

    if (!phone || !otp) return res.status(400).json({ message: "Phone and OTP are required" });

    console.log(`Checking OTP for phone: ${phone}, entered OTP: ${otp}`);

    const record = await OTP.findOne({ phone });
     
    if (!record) {
      console.error(`No OTP found for phone: ${phone}`);
      return res.status(401).json({ message: "Invalid or expired OTP" });
    }

    console.log("Fetched OTP Record:", record);

    // Ensure OTP is correctly compared
    if (String(record.otp) !== String(otp)) {
      console.error(`OTP mismatch! Entered: ${otp}, Stored: ${record.otp}`);
      return res.status(401).json({ message: "Invalid OTP" });
    }

    console.log("OTP matched successfully!");

    await OTP.deleteMany({ phone }); // Clear used OTPs

    const token = jwt.sign({ phone }, JWT_SECRET, { expiresIn: "1h" });
    
    res.json({ message: "OTP verified successfully", token });
  } catch (error) {
    console.error("Error verifying OTP:", error.message);
    res.status(500).json({ message: "Internal server error", error: error.message });
  }
});


app.post("/resend-otp", async (req, res) => {
  const { phone } = req.body;
  
  if (!phone) return res.status(400).json({ message: "Phone number is required" });
  
  const otp = generateOTP();

  try {
    // Save OTP to database
     await OTP.create({phone,otp});

    // Send OTP via Twilio
    await client.messages.create({
      body: `Your OTP code is: ${otp}`,
      from: twilioPhoneNumber,
      to: `+91${phone}`,
    });

    res.json({ message: "OTP sent successfully" });
  } catch (error) {
    console.error("Error sending OTP:", error.message || error);
    res.status(500).json({ message: "Error sending OTP", error: error.message });
  }
});



app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
