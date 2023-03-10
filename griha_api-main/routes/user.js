const router = require("express").Router();
const {
  verifyToken,
  verifyAndAuthorize,
  verifyCredentials,
  verifyAdmin,
} = require("./verifytoken");
const db = require("../db");
const bcrypt = require("bcrypt");
const { getJsonFormat } = require("../utils/constants");

//GET USERS

router.get("/", verifyToken, async (req, res) => {
  const query = `select * from users`;
  const token = req.headers.token;
  try {
    db.query(query, (error, data) => {
      if (error) return res.status(500).json(error);
      if (data) {
        const { password, ...others } = data;
        return res
          .status(200)
          .send(getJsonFormat(others, "Users fetched successfully!", true));
      }
    });
  } catch (error) {}
});

//GET USER

router.get("/:id", verifyToken, async (req, res) => {
  const query = `select * from users  where user_id=${req.params.id}`;
  const token = req.headers.token;
  try {
    db.query(query, (error, data) => {
      if (error) return res.status(500).json(error);

      if (data.length > 0) {
        const { password, ...others } = data[0];
        return res.status(200).json({ ...others, token });
      } else {
        return res.status(500).json("User not found!");
      }
    });
  } catch (error) {}
});

//UPDATE USER

router.put("/:id", verifyAndAuthorize, async (req, res) => {
  const query = "update users set full_name=?,phone_number=? where user_id=?";
  const values = [req.body.full_name, req.body.phone_number, req.params.id];
  try {
    db.query(query, values, (error, data) => {
      if (error) return res.status(500).json(error);
      if (data) return res.status(200).json("User updated successfully!");
    });
  } catch (error) {}
});

//CHANGE PASSWORD

router.put(
  "/password/:id",
  verifyAndAuthorize,
  verifyCredentials,
  async (req, res) => {
    try {
      bcrypt.hash(req.body.newPassword, 10, (err, hash) => {
        if (err) return res.status(500).json(err);

        const query = `update users set password='${hash}' where user_id='${req.params.id}'`;
        db.query(query, (error, data) => {
          if (error) return res.status(500).json(error);
          if (data) return res.status(200).json(data);
        });
      });
    } catch (error) {}
  }
);

module.exports = router;
