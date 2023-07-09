// import {Todo} from "./lib/chat_pb";
// import { onCall, onRequest } from "firebase-functions/v2/https";

// export const helloWorld = onRequest((request, response) => {
//   response.set("Access-Control-Allow-Origin", "*");
//   response.send({ message: "Hello from Firebase emulator!" });
// });

// export const sayHello = onCall((request) => {
//   return {
//     message: "Hello from the emulator",
//     data: request.data,
//     todo: testTodo(),
//     // auth: request.auth,
//   };
// });

// export function testTodo() {
//   const todo = new Todo();

//   // Set the id, title, and completed properties
//   todo.setId(1);
//   todo.setTitle("Buy groceries");
//   todo.setCompleted(false);

//   // Assert that the properties have been set correctly
//   if (todo.getId() !== 1) {
//     throw new Error("Todo id should be 1");
//   }

//   if (todo.getTitle() !== "Buy groceries") {
//     throw new Error("Todo title should be \"Buy groceries\"");
//   }

//   if (todo.getCompleted() !== false) {
//     throw new Error("Todo should not be completed yet");
//   }

//   return todo.toObject();
// }
