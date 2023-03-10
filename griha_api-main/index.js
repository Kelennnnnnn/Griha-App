const express = require("express");
const app = express();
const dotenv = require("dotenv");
const bodyParser = require("body-parser");
const cors = require("cors");
const multer = require("multer");

// const corsOptions = {
//   origin: "*",
//   credentials: false, //access-control-allow-credentials:true
//   optionSuccessStatus: 200,
// };

dotenv.config();
app.use(express.static("public"));
app.use("/public", express.static("public"));
app.use(bodyParser.json());
const authRoute = require("./routes/auth");
const userRoute = require("./routes/user");
const postRoute = require("./routes/post");
const categoryRoute = require("./routes/category");
const cityRoute = require("./routes/city");
const statsRoute = require("./routes/stats");

// const messageRoute = require("./routes/message");

app.use(cors());
app.use("/api/auth", authRoute);
app.use("/api/user", userRoute);
app.use("/api/post", postRoute);
app.use("/api/category", categoryRoute);
app.use("/api/city", cityRoute);
app.use("/api/stats", statsRoute);

app.listen(process.env.PORT || 5000, () => {
  console.log("Backend server is running.");
});
