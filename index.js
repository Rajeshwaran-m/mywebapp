const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("Hello from Jenkins CI/CD pipeline on Azure!");
});

app.listen(8080, () => console.log("Server running on port 8080"));
