const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("Hello from Jenkins CI/CD pipeline on Azure!");
});

// ✅ Use process.env.PORT (required by Azure)
const port = process.env.PORT || 8080;
app.listen(port, () => console.log(`Server running on port ${port}`));
