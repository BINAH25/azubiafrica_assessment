import mongoose from "mongoose";

const connectDb = async () => {
  try {
    const uri = process.env.MONGO_URI || "mongodb://localhost:27017/todo-db";
    await mongoose.connect(uri);
    console.log("Database connected successfully");
  } catch (error) {
    console.error("DB connection failed", error);
    process.exit(1);
  }
};

export default connectDb;
