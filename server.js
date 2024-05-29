const { Server } = require("socket.io");

const io = new Server(3002, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"],
  },
});

io.on("connection", (socket) => {
  console.log("Connexion établie avec le client " + socket.id);

  socket.on("join_room", (room_id) => {
    socket.join(room_id);
    console.log("Le client " + socket.id + " a rejoint la room " + room_id);

    socket.on("send_message", ({ message }) => {
      io.to(room_id).emit("message", message);
    });
  });
});
