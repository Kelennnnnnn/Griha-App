const router = require("express").Router();
const {
  verifyToken,
  verifyAndAuthorize,
  verifyCredentials,
  verifyAdmin,
} = require("./verifytoken");
const db = require("../db");
const { getJsonFormat } = require("../utils/constants");

//GET ALL CATEGORIES

router.get("/", async (req, res) => {
  const query = `select * from cities`;
  try {
    db.query(query, (error, data) => {
      if (error) return res.status(500).json(error);
      if (data) {
        return res
          .status(200)
          .send(getJsonFormat(data, "Cities fetched successfully!", true));
      }
    });
  } catch (error) {}
});

router.delete("/:id", verifyAdmin, async (req, res) => {
  const query = `delete from cities where city_id=${req.params.id}`;
  try {
    db.query(query, (error, data) => {
      if (error.errno == 1451)
        return res
          .status(500)
          .send(getJsonFormat("City is used can't be deleted!", false));
      if (error) return res.status(500).json(error);
      if (data) {
        return res
          .status(200)
          .send(getJsonFormat("Cities deleted successfully!", true));
      }
    });
  } catch (error) {}
});

const checkCityName = (req, res, next) => {
  try {
    const query = "select * from cities where city_name=?";
    const values = [req.body.city_name];
    db.query(query, [values], (err, results) => {
      if (err) return res.status(500).json(err);

      if (results.length > 0) {
        return res
          .status(500)
          .send(getJsonFormat(null, "City already exists!", false));
      } else {
        next();
      }
    });
  } catch (err) {
    res.status(500).json(err);
  }
};

//INSERT CITIES IN THE DATABASE
router.post("/", verifyAdmin, checkCityName, async (req, res) => {
  try {
    const query = "insert into cities (city_name) values (?)";

    const values = [req.body.city_name];
    db.query(query, [values], (err, results) => {
      if (err) return res.status(500).json(err);

      res
        .status(200)
        .send(getJsonFormat(null, "City added successfully!", true));
    });
  } catch (err) {
    res.status(500).json(err);
  }
});

module.exports = router;
