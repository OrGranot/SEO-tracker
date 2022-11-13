// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from "@hotwired/stimulus"
// import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
// const context = require.context("controllers", true, /_controller\.js$/)
// application.load(definitionsFromContext(context))
import MenuController from "./menu_controller";
import TableController from "./table_controller";
import SearchController from "./search_controller";
import KeywordController from "./keyword_controller";


application.register("menu", MenuController)
application.register("table", TableController)
application.register("search", SearchController)
application.register("keyword", KeywordController)
