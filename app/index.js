const express = require('express');
const path = require('path');
const app = express();
const port = process.env.PORT || 80;

// Serve static files
app.use(express.static(path.join(__dirname, 'public')));

app.listen(port, () => {
  console.log(`Sample app listening at http://localhost:${port}`);
});
