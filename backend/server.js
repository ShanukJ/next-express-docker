require('dotenv').config();
const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.send('Express Backend is Running!');
});

app.get('/api/hello', (req, res) => {
  res.json({ message: '👋 Hello from Express!' });
});

app.listen(PORT, () => {
  console.log(`Express Server is running on http://localhost:${PORT}`);
});
