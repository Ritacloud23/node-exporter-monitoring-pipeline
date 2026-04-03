const express = require("express");

const app = express();
const PORT = 5000;

app.get("/", (req, res) => {
  res.send("Backend is running");
});

app.get("/api/health", (req, res) => {
  res.json({ status: "ok", service: "backend" });
});

app.listen(PORT, () => {
  console.log(`Backend running on port ${PORT}`);
});