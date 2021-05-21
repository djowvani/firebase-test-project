const functions = require("firebase-functions");
const firebase = require("firebase-admin");
const express = require("express");
var path = require("path");
var exphbs = require("express-handlebars");

const firebaseApp = firebase.initializeApp(functions.config().firebase);

async function getMenooOfRestaurant(restName) {
  return firebaseApp
    .firestore()
    .collection("menu")
    .where("shortName", "==", restName)
    .get();
}

var handlebars = exphbs.create({
  layoutsDir: path.join(__dirname, "views/layouts"),
  partialsDir: path.join(__dirname, "views/partials"),
  defaultLayout: "index",
  extname: "hbs",
  helpers: require("./helpers/hbs.js").helpers,
});

async function loadMenoo(restShortName) {
  console.log("restShortName: ", restShortName);
  var resMenoo = await getMenooOfRestaurant(restShortName);
  var menuObj = undefined;
  try {
    //obtendo o restaurante ID.
    resMenoo.forEach((docRest) => {
      menuObj = docRest.data();
    });
    return menuObj;
  } catch (e) {
    console.error("BLA", e);
  }
}

const app = express();
app.engine("hbs", handlebars.engine);
app.set("view engine", "hbs");
app.set("views", "./views");

app.get("/profile/:name", (request, response) => {
  //   console.log("começo de tudo: ", request);
  //   console.log("começo de tudo 2: ", response);
  response.set("Cache-Control", "public, max-age=600, s-maxage=600");
  const rest = request.params.name;
  console.log("rest: ", rest);
  loadMenoo(rest)
    .then((menoo) => {
      console.log("oh o menoo: ", menoo);
      if (menoo === undefined) {
        console.log("entrou 404");
        response.status(404).render("404", { layout: "404" });
      } else {
        console.log("entrou no menoo");
        response.render("index", { menoo });
      }
    })
    .catch((err) => {
      console.log("Erro de execução na função", err);
    });
});

exports.app = functions.https.onRequest(app);
