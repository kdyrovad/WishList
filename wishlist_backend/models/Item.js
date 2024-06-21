const mongoose = require('mongoose');

const ItemSchema = new mongoose.Schema({
  name: { type: String, required: true },
  description: { type: String },
  url: { type: String },
});

module.exports = mongoose.model('Item', ItemSchema);
