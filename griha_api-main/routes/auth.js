const router = require("express").Router();
const db = require("../db");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const { verifyCredentials, verifyAdminCredentials } = require("./verifytoken");

router.post("/register", checkUniqueEmail, async (req, res) => {
  try {
    const query =
      "insert into users (full_name,phone_number, email, password,is_admin) values(?)";
    const saltRounds = 8;
    bcrypt.hash(req.body.password, saltRounds, (err, hash) => {
      if (err) return res.status(500).json(err);

      const values = [
        req.body.fullName,
        req.body.phoneNumber,
        req.body.email,
        hash,
        req.body.isAdmin,
      ];

      db.query(query, [values], (err, results) => {
        if (err) return res.status(500).json(err);

        res.status(200).json("User registered successfully");
      });
    });
  } catch (err) {
    res.status(500).json(err);
  }
});

//CHECKING IF USER WITH SAME EMAIL ALREADY EXISTS

function checkUniqueEmail(req, res, next) {
  try {
    const query = "select * from users where email=?";
    const values = [req.body.email];

    db.query(query, [values], (error, data) => {
      if (data.length) return res.status(409).json("Email already exists");
      if (error) return res.status(500).json(error);

      next();
    });
  } catch (error) {
    res.status(500).json(error);
  }
}

//LOGIN ENDPOINT FOR THE API

router.post("/login", verifyCredentials, async (req, res) => {
  try {
    const token = jwt.sign(
      {
        id: req.data.user_id,
        isAdmin: req.data.is_admin,
      },
      process.env.jwt_pass,
      { expiresIn: "60d" }
    );

    const { password, ...others } = req.data;
    res.status(200).json({ ...others, token });
  } catch (err) {
    res.status(500).json(err);
  }
});

//LOGIN ENDPOINT FOR THE API (ADMIN)

module.exports = router;
